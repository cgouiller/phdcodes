        load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));

%% Initialisations de la simu
N=round(64/pi*L);%Résolution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images
nt=old_nt+50000;
utot=zeros(N+60,N+60);
vtot=zeros(N+60,N+60);
counttot=zeros(N+60,N+60);
make_grid; %Initialise la grille de simu (N*N) et une variable utile pour gérer l'aliasing
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.

%% Paramètres physiques invariables

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
Dcamp=0.15;% Coeff de diffusion du camphre


%% Initialisation des tableaux de stockage de valeurs

    t=old_nt*dt;

%% Début de la simu
% profil source de camphre (centré en pi), qui correspond à un nageur
source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);

% on definit le filtre dans l'espace de fourier
gfilt_f=source0_f/sum(sum(source));

source=asrc*source; % permet de l'annuler si pas de Marangoni en ayant quand même défini le filtre.
source0_f=asrc*source0_f; % Linéarité de la TF



%% Pas de temps 0

% en fourier d_t TF[s] = -(Dcamp*k2+alpha)*TF[s] + B k2 TF[s.^2] + TF[source]
% Ces exponentielles sont utiles pour résoudre l'éque diff et la faire
% progresser en temps:
k2=(kx.^2+ky.^2);
expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);


%% Début de la boucle
compteur=1; %Pour sauvegarder les champs de vitesse

%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining the simulation loop...'),'keepthis','timestamp');


in=old_nt+1;
while abs((mod(xs,L)-L/2))>0.01
      
    Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'équa diff pour le camphre
    Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing

    % Position et vitesse des sources
    [xsnew,ysnew,vsxnew,vsynew]=eval_posvit(1,inertie,dt,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); % Evolution de vitesse et position des nageurs
    
    % On actualise les variables, pour que les old soit toujours au temps
    % in-1 et les normales au temps in
    uxp_old=uxp;
    uyp_old=uyp;
    vsx_old=vsx;
    vsy_old=vsy;
    xs_old=xs;
    ys_old=ys;
    vsx=vsxnew;
    vsy=vsynew;
    xs=xsnew;
    ys=ysnew;
    
    
    % Calcul de la source de camphre à l'instant t, en Fourier
    %source_f=source0_f.*exp(-1i*xs*kx-1i*ys*ky);
    source_f=zeros(size(source0_f));
    for nn=1:npart
        source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    
    Sfcamp_old=Sfcamp; %On stocke avant de remplacer
    % calcul du terme d'advection
    Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias); %advection est l'interrupteur on/off
    Sfcamp=Sfcamp+source_f;
    Sfcamp=Sfcamp.*alias;
    if bbg==1
        Sfbg_old=Sfbg;
        Sfbg=Sscal_adams(advection,Cbg_f,vxext+real(ifft2(vxf)),vyext+real(ifft2(vyf)),kx,ky,alias);
        Sfbg=Sfbg.*alias;
    end
    
    % TF du champ de vitesse du fluide dû à Marangoni en t
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
    
    % Champ de vitesse du fluide total filtré et interpolé en t
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse du fluide tot filtrée sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
    
    % Composante Marangoni de la vitesse du nageur
    vx=real(ifft2((vxf).*gfilt_f));
    vy=real(ifft2((vyf).*gfilt_f));
    [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad,L);
    
    t=t+dt;
    in=in+1;
end
        vx2=real(ifft2(vxf));
        vy2=real(ifft2(vyf));
        vx2p=padarray(vxfilt,[30,30],'circular','both');
        vy2p=padarray(vyfilt,[30,30],'circular','both');
    s=length(vx2p);
    posxnag=mod(xs,L)*128/L+30;
    posynag=mod(ys,L)*128/L+30;
    angle=atan((ys-ys_old)/(xs-xs_old));
    if xs-xs_old<0
        angle=angle+pi;
    end
    vxprim=vx2p*cos(angle)+vy2p*sin(angle);
    vyprim=-vx2p*sin(angle)+vy2p*cos(angle);
    [X,Y]=meshgrid(1:size(vxprim,2),1:size(vxprim,1));
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-posxnag;
    pts(:,2)=Y(:)-posynag;
    R=[cos(angle), sin(angle);-sin(angle) cos(angle)];
    v=[s/2-posxnag, s/2-posynag];
    
    tt=v*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+posxnag;
    pts2(:,2)=pts2(:,2)+posynag;
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [Umoy,count]=bilinear_clement(vxprim,ptsf);
    [Vmoy,count]=bilinear_clement(vyprim,ptsf);
    xnag=94;
    ynag=94;
%% On sauvegarde tout
save(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_vfield.mat'),'X','Y','Umoy','Vmoy','xnag','ynag');


%% old

% %% Initialisations de la simu
% N=round(64/pi*L);%Résolution de la grille de simu
% chopvec=5; %On affiche une toutes les chopvec images
% nt=old_nt+50000;
% utot=zeros(N+60,N+60);
% vtot=zeros(N+60,N+60);
% counttot=zeros(N+60,N+60);
% make_grid; %Initialise la grille de simu (N*N) et une variable utile pour gérer l'aliasing
% [vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.
% 
% %% Paramètres physiques invariables
% 
% alpha=2; %Coefficient de sublimation
% sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
% Dcamp=0.15;% Coeff de diffusion du camphre
% 
% 
% %% Initialisation des tableaux de stockage de valeurs
% if old_nt==1 % Correspond à une simu jamais commencée
%     mx=zeros(nt,npart); %Tableaux des positions des nageurs
%     my=zeros(nt,npart);
%     muxp=zeros(nt,npart); % Tableaux des vitesses filtrées "sous le nageur"
%     muyp=zeros(nt,npart);
%     mvsx=zeros(nt,npart); % Tableaux des vitesses des nageurs
%     mvsy=zeros(nt,npart);
%     mvxnage=zeros(nt,npart); % Tableaux de la composante Marangoni de propulsion
%     mvynage=zeros(nt,npart);
%     mvfx=cell(200,1);   % Pour stocker quelques champs de vitesse, pas exploités en ce moment
%     mvfy=cell(200,1);
%     if bbg==1
%         mstdbg=zeros(nt,1);
%     end
%     if bbg>1
%         mxbg=zeros(nt,bbg);
%         mybg=zeros(nt,bbg);
%     end
% end
% if old_nt~=1 % Correspond à une simu à poursuivre
%     muxpb=zeros(nt,npart);
%     muypb=zeros(nt,npart);
%     mvsxb=zeros(nt,npart);
%     mvsyb=zeros(nt,npart);
%     mvxnageb=zeros(nt,npart);
%     mvynageb=zeros(nt,npart);
%     muxpb(1:old_nt,1:npart)=muxp(1:old_nt,1:npart);
%     muypb(1:old_nt,1:npart)=muyp(1:old_nt,1:npart);
%     mvsxb(1:old_nt,1:npart)=mvsx(1:old_nt,1:npart);
%     mvsyb(1:old_nt,1:npart)=mvsy(1:old_nt,1:npart);
%     mvxnageb(1:old_nt,1:npart)=mvxnage(1:old_nt,1:npart);
%     mvynageb(1:old_nt,1:npart)=mvynage(1:old_nt,1:npart);
%     muxp=muxpb;
%     muyp=muypb;
%     mvsx=mvsxb;
%     mvsy=mvsyb;
%     mvxnage=mvxnageb;
%     mvynage=mvynageb;
%     mxb=zeros(nt,npart);
%     myb=zeros(nt,npart);
%     mxb(1:old_nt,1:npart)=mx(1:old_nt,1:npart);
%     myb(1:old_nt,1:npart)=my(1:old_nt,1:npart);
%     mx=mxb;
%     my=myb;
%     if bbg==1
%         mstdbgb=zeros(nt,1);
%         mstdbgb(1:old_nt,1)=mstdbg;
%         mstdbg=mstdbgb;
%     end
%     if bbg>1
%         mxbgb=zeros(nt,bbg);
%         mybgb=zeros(nt,bbg);
%         mxbgb(1:old_nt,:)=mxbg;
%         mybgb(1:old_nt,:)=mybg;
%         mxbg=mxbgb;
%         mybg=mybgb;
%         clear mxbgb
%         clear mybgb
%     end
%     t=old_nt*dt;
% end
% 
% %% Début de la simu
% if old_nt==1
%     cpt=0; list=round(linspace(1000,nt,200)); % Pour stocker les chps de vit utiles pour calculer les spectres
% end
% % profil source de camphre (centré en pi), qui correspond à un nageur
% source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1
% % on centre la source en (0,0), translation de -pi en x et y
% source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);
% 
% % on definit le filtre dans l'espace de fourier
% gfilt_f=source0_f/sum(sum(source));
% 
% source=asrc*source; % permet de l'annuler si pas de Marangoni en ayant quand même défini le filtre.
% source0_f=asrc*source0_f; % Linéarité de la TF
% 
% if old_nt==1
%     % Positions aléatoires des nageurs
%     if rdomstart==1
%         xp=2*pi*rand(1,npart);
%         yp=2*pi*rand(1,npart);
%     elseif rdomstart==2
%         xp=(pi/2-0.1)*ones(1,npart);
%         yp=(pi/2-0.1)*ones(1,npart);
%     elseif rdomstart==0
%         xp=pi/4*ones(1,npart);
%         yp=pi/4*ones(1,npart);
%     elseif rdomstart==3
%         xp=pi;
%         yp=pi/2-0.1;
%     elseif rdomstart==4
%         xp=[L/2-sqrt((L/2)^2+(L/2/tan(theta))^2)-delai,L/2-L/2/tan(theta)];
%         yp=[L/2+0.00000001,0.00000001];
%         if theta==3.1416
%             xp=[L/8,7*L/8];
%             yp=[L/2+0.00000001,L/2+0.00000001];
%         end
%     elseif rdomstart==5
%         xp=pi+0.00001;
%         yp=pi/2-0.1;
%     elseif rdomstart==6
%         xp=pi+0.00001;
%         yp=pi+0.00001;
%     elseif rdomstart==7
%         xp=pi/2+0.0001;
%         yp=0.5;
%     end
%     if bbg==1
%         Cbg=zeros(N);
%     end
%     if bbg>1
%         xbg=rand(1,bbg)*L;
%         ybg=rand(1,bbg)*L;
%         vxbg=zeros(1,bbg);
%         vybg=zeros(1,bbg);
%     end
%     % vitesse initiale = vitesse locale de l'écoulement
%     if ecoulement==1
%         vxfilt=real(ifft2(vxextf.*gfilt_f)); %On filtre l'écoulement externe à la taille du nageur
%         vyfilt=real(ifft2(vyextf.*gfilt_f));
%         vsx=interp2(x,y,vxfilt,xp,yp,'spline'); %On interpole la vitesse filtrée à la position du nageur
%         vsy=interp2(x,y,vyfilt,xp,yp,'spline');
%         if bbg>1
%             vxbg=interp2(x,y,vxext,xbg,ybg,'spline');
%             vybg=interp2(x,y,vyext,xbg,ybg,'spline');
%         end
%         
%     end
%     if amp_ec==0 && npart==1
%         vsx=0.001; %Juste pour aider le sym breaking
%         vsy=0;
%     end
%     if amp_ec==0 && npart>1
%         angles=2*pi*rand(1,npart);
%         vsx=0.001*cos(angles);
%         vsy=0.001*sin(angles);
%         
%     end
%     if rdomstart==4
%         vsx=[1.554,1.554*cos(theta)];
%         vsy=[0,1.554*sin(theta)];
%     end
%     if rdomstart==6
%         vsx=0.000000000000001;
%         vsy=0;
%     end
%     % stockage de la position initiale
%     xs=xp;
%     ys=yp;
%     t=0;
% end
% 
% 
% %% Pas de temps 0
% 
% % en fourier d_t TF[s] = -(Dcamp*k2+alpha)*TF[s] + B k2 TF[s.^2] + TF[source]
% % Ces exponentielles sont utiles pour résoudre l'éque diff et la faire
% % progresser en temps:
% k2=(kx.^2+ky.^2);
% expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
% expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
% expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);
% 
% 
% %% Début de la boucle
% compteur=1; %Pour sauvegarder les champs de vitesse
% 
% %Initialize the clock
% dispstat('','init'); % One time only initialization
% dispstat(sprintf('Begining the simulation loop...'),'keepthis','timestamp');
% 
% 
% 
% a=round(rand(1,500)*(nt-old_nt-1))+old_nt+1;
% for in=old_nt+1:nt
%     if sum(in==a)~=0
%         vx2=real(ifft2(vxf));
%         vy2=real(ifft2(vyf));
%         vx2p=padarray(vxfilt,[30,30],'circular','both');
%         vy2p=padarray(vyfilt,[30,30],'circular','both');
%     s=length(vx2p);
%     posxnag=mod(mx(in-1,1),L)*128/L+30;
%     posynag=mod(my(in-1,1),L)*128/L+30;
%     angle=atan((my(in-1,1)-my(in-2,1))/(mx(in-1,1)-mx(in-2,1)));
%     if mx(in-1,1)-mx(in-2,1)<0
%         angle=angle+pi;
%     end
%     vxprim=vx2p*cos(angle)+vy2p*sin(angle);
%     vyprim=-vx2p*sin(angle)+vy2p*cos(angle);
%     [X,Y]=meshgrid(1:size(vxprim,2),1:size(vxprim,1));
%     pts=zeros(length(X).^2,2);
%     ptsf=zeros(length(X).^2,2);
%     pts(:,1)=X(:)-posxnag;
%     pts(:,2)=Y(:)-posynag;
%     R=[cos(angle), sin(angle);-sin(angle) cos(angle)];
%     v=[s/2-posxnag, s/2-posynag];
%     
%     tt=v*R;
%     pts2=pts*R;
%     pts2(:,1)=pts2(:,1)+posxnag;
%     pts2(:,2)=pts2(:,2)+posynag;
%     
%     ptsf(:,1)=pts2(:,2)-tt(2);
%     ptsf(:,2)=pts2(:,1)-tt(1);
%     
%     [im,count]=bilinear_clement(vxprim,ptsf);
%     utot=utot+im;
%     vxrot=im;
%     [im,count]=bilinear_clement(vyprim,ptsf);
%     vtot=vtot+im;
%     vyrot=im;
%     counttot=counttot+count;
%     
%     end
%     Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'équa diff pour le camphre
%     Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing
% 
%     % Position et vitesse des sources
%     [xsnew,ysnew,vsxnew,vsynew]=eval_posvit(1,inertie,dt,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); % Evolution de vitesse et position des nageurs
%     
%     % On actualise les variables, pour que les old soit toujours au temps
%     % in-1 et les normales au temps in
%     uxp_old=uxp;
%     uyp_old=uyp;
%     vsx_old=vsx;
%     vsy_old=vsy;
%     xs_old=xs;
%     ys_old=ys;
%     vsx=vsxnew;
%     vsy=vsynew;
%     xs=xsnew;
%     ys=ysnew;
%     
%     
%     % Calcul de la source de camphre à l'instant t, en Fourier
%     %source_f=source0_f.*exp(-1i*xs*kx-1i*ys*ky);
%     source_f=zeros(size(source0_f));
%     for nn=1:npart
%         source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
%     end
%     
%     Sfcamp_old=Sfcamp; %On stocke avant de remplacer
%     % calcul du terme d'advection
%     Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias); %advection est l'interrupteur on/off
%     Sfcamp=Sfcamp+source_f;
%     Sfcamp=Sfcamp.*alias;
%     if bbg==1
%         Sfbg_old=Sfbg;
%         Sfbg=Sscal_adams(advection,Cbg_f,vxext+real(ifft2(vxf)),vyext+real(ifft2(vyf)),kx,ky,alias);
%         Sfbg=Sfbg.*alias;
%     end
%     
%     % TF du champ de vitesse du fluide dû à Marangoni en t
%     [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
%     
%     % Champ de vitesse du fluide total filtré et interpolé en t
%     % filtrage en fourier, interp dans l'espace physique
%     [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
%     
%     %Donne la vitesse du fluide tot filtrée sur chacun des nageurs
%     [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
%     
%     % Composante Marangoni de la vitesse du nageur
%     vx=real(ifft2((vxf).*gfilt_f));
%     vy=real(ifft2((vyf).*gfilt_f));
%     [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad,L);
%     
%     t=t+dt;
%     
%     % On écrit dans les tableaux
%     muxp(in,1:npart)=uxp(1,1:npart);
%     muyp(in,1:npart)=uyp(1,1:npart);
%     mvsx(in,1:npart)=vsx(1,1:npart);
%     mvsy(in,1:npart)=vsy(1,1:npart);
%     mx(in,1:npart)=xs(1,1:npart);% position x
%     my(in,1:npart)=ys(1,1:npart);% position y
%     mvxnage(in,1:npart)=vxnage(1,1:npart);
%     mvynage(in,1:npart)=vynage(1,1:npart);
%     
% end
% 
% Umoy=utot./count;
% Vmoy=vtot./count;
% Umoy(count==0)=0;
% Vmoy(count==0)=0;
% %% On sauvegarde tout
% save(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_vfield.mat'),'X','Y','Umoy','Vmoy');
% 
