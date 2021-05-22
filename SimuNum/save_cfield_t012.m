% if old_nt~=1 && exist('k')~=0
%     ff=k; %Pour éviter le conflit entre fréquence du spectre et k utilisé comme variable pour boucle for
% end
run manips
old_nt=1;
ii=165;
    %% Choix des paramètres de la simu
    bbg=manipCat.bbg(ii);
    taup=manipCat.taup(ii);
    inertie=manipCat.inertie(ii);
    amp_ec=manipCat.amp_ec(ii);
    npart=manipCat.npart(ii);
    A=manipCat.A(ii);
    nt=801;
    rdomstart=6;
    dt=manipCat.dt(ii);
    satur=manipCat.satur(ii);
    theta=manipCat.theta(ii);
    delai=manipCat.delai(ii);
    L=manipCat.L(ii);
    ecoulement=1;
    marangoni=1;
    if amp_ec==0
        ecoulement=0;
    end
    if A==0
        marangoni=0;
    end
    Dbg=manipCat.Dbg(ii);
    
    Dnag=5; %En mm, le diamètre des nageurs voulus
    asrc=manipCat.asrc(ii); % Amplitude du flux de camphre libéré
    advection=1; %1 si avec advection, 0 si non
    
    
    param_ecexterne=manipCat.paramec(ii);
%% Initialisations de la simu
N=round(64/pi*L);%Résolution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images

make_grid; %Initialise la grille de simu (N*N) et une variable utile pour gérer l'aliasing
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.

%% Paramètres physiques invariables

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
Dcamp=0.15;% Coeff de diffusion du camphre


%% Initialisation des tableaux de stockage de valeurs
if old_nt==1 % Correspond à une simu jamais commencée
    mx=zeros(nt,npart); %Tableaux des positions des nageurs
    my=zeros(nt,npart);
    muxp=zeros(nt,npart); % Tableaux des vitesses filtrées "sous le nageur"
    muyp=zeros(nt,npart);
    mvsx=zeros(nt,npart); % Tableaux des vitesses des nageurs
    mvsy=zeros(nt,npart);
    mvxnage=zeros(nt,npart); % Tableaux de la composante Marangoni de propulsion
    mvynage=zeros(nt,npart);
    mvfx=cell(200,1);   % Pour stocker quelques champs de vitesse, pas exploités en ce moment
    mvfy=cell(200,1);
    if bbg==1
        mstdbg=zeros(nt,1);
    end
    if bbg>1
       mxbg=zeros(nt,bbg);
       mybg=zeros(nt,bbg);
    end
end
if old_nt~=1 % Correspond à une simu à poursuivre
    muxpb=zeros(nt,npart);
    muypb=zeros(nt,npart);
    mvsxb=zeros(nt,npart);
    mvsyb=zeros(nt,npart);
    mvxnageb=zeros(nt,npart);
    mvynageb=zeros(nt,npart);
    muxpb(1:old_nt,1:npart)=muxp(1:old_nt,1:npart);
    muypb(1:old_nt,1:npart)=muyp(1:old_nt,1:npart);
    mvsxb(1:old_nt,1:npart)=mvsx(1:old_nt,1:npart);
    mvsyb(1:old_nt,1:npart)=mvsy(1:old_nt,1:npart);
    mvxnageb(1:old_nt,1:npart)=mvxnage(1:old_nt,1:npart);
    mvynageb(1:old_nt,1:npart)=mvynage(1:old_nt,1:npart);
    muxp=muxpb;
    muyp=muypb;
    mvsx=mvsxb;
    mvsy=mvsyb;
    mvxnage=mvxnageb;
    mvynage=mvynageb;
    mxb=zeros(nt,npart);
    myb=zeros(nt,npart);
    mxb(1:old_nt,1:npart)=mx(1:old_nt,1:npart);
    myb(1:old_nt,1:npart)=my(1:old_nt,1:npart);
    mx=mxb;
    my=myb;
    if bbg==1
        mstdbgb=zeros(nt,1);
        mstdbgb(1:old_nt,1)=mstdbg;
        mstdbg=mstdbgb;
    end
    if bbg>1
        mxbgb=zeros(nt,bbg);
        mybgb=zeros(nt,bbg);
        mxbgb(1:old_nt,:)=mxbg;
        mybgb(1:old_nt,:)=mybg;
        mxbg=mxbgb;
        mybg=mybgb;
        clear mxbgb
        clear mybgb
    end
    t=old_nt*dt;
end

%% Début de la simu
if old_nt==1
    cpt=0; list=round(linspace(1000,nt,200)); % Pour stocker les chps de vit utiles pour calculer les spectres
end
% profil source de camphre (centré en pi), qui correspond à un nageur
source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);

% on definit le filtre dans l'espace de fourier
gfilt_f=source0_f/sum(sum(source));

source=asrc*source; % permet de l'annuler si pas de Marangoni en ayant quand même défini le filtre.
source0_f=asrc*source0_f; % Linéarité de la TF

if old_nt==1
    % Positions aléatoires des nageurs
    if rdomstart==1
        xp=2*pi*rand(1,npart);
        yp=2*pi*rand(1,npart);
    elseif rdomstart==2
        xp=(L/2+0.0001)*ones(1,npart);
        yp=(L/2+0.0001)*ones(1,npart);
    elseif rdomstart==0
        xp=pi/4*ones(1,npart);
        yp=pi/4*ones(1,npart);
    elseif rdomstart==3
        xp=pi;
        yp=pi/2-0.1;
    elseif rdomstart==4
        xp=[L/2-sqrt((L/2)^2+(L/2/tan(theta))^2)-delai,L/2-L/2/tan(theta)];
        yp=[L/2+0.00000001,0.00000001];
        if theta==3.1416
            xp=[L/8,7*L/8];
            yp=[L/2+0.00000001,L/2+0.00000001];
        end
    elseif rdomstart==5
        xp=pi+0.00001;
        yp=pi/2-0.1;
    elseif rdomstart==6
        xp=pi+0.00001;
        yp=pi+0.00001;
    elseif rdomstart==7
        xp=pi/2+0.0001;
        yp=0.5;
    elseif rdomstart==8
        xp=0.001;
        yp=L/2+0.001;
    end
    if bbg==1
        Cbg=zeros(N);     
    end
    if bbg>1
        xbg=rand(1,bbg)*L;
        ybg=rand(1,bbg)*L;
        vxbg=zeros(1,bbg);
        vybg=zeros(1,bbg);
    end
    % vitesse initiale = vitesse locale de l'écoulement
    if ecoulement==1
        vxfilt=real(ifft2(vxextf.*gfilt_f)); %On filtre l'écoulement externe à la taille du nageur
        vyfilt=real(ifft2(vyextf.*gfilt_f));
        vsx=interp2(x,y,vxfilt,xp,yp,'spline'); %On interpole la vitesse filtrée à la position du nageur
        vsy=interp2(x,y,vyfilt,xp,yp,'spline');
        if bbg>1
            vxbg=interp2(x,y,vxext,xbg,ybg,'spline');
            vybg=interp2(x,y,vyext,xbg,ybg,'spline');
        end
        
    end
    if amp_ec==0 && npart==1
        vsx=0.001; %Juste pour aider le sym breaking
        vsy=0;
    end
    if amp_ec==0 && npart>1
        angles=2*pi*rand(1,npart);
        vsx=0.001*cos(angles);
        vsy=0.001*sin(angles);
        
    end
    if rdomstart==4
        vsx=[1.554,1.554*cos(theta)];
        vsy=[0,1.554*sin(theta)];
    end
    if rdomstart==6
        vsx=0.000000000000001;
        vsy=0;
    end
    if rdomstart==8
        vsx=10;
        vsy=0;
    end
    % stockage de la position initiale
    xs=xp;
    ys=yp;
    t=0;
end


%% Pas de temps 0

% en fourier d_t TF[s] = -(Dcamp*k2+alpha)*TF[s] + B k2 TF[s.^2] + TF[source]
% Ces exponentielles sont utiles pour résoudre l'éque diff et la faire
% progresser en temps:
k2=(kx.^2+ky.^2);
expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);
expdtbg=exp(-Dbg*dt*k2);
expdt05bg=exp(-Dbg*dt*k2/2);
expdt2bg=exp(-2*Dbg*dt*k2);
if old_nt==1
    
    
    % initialisation t=0 du champ de camphre (une source à la position de
    % chaque nageur)
    Ccamp0_f=zeros(size(source0_f));
    for nn=1:npart
        Ccamp0_f=Ccamp0_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    Ccamp_f=Ccamp0_f;
    if bbg==1
        Cbg0_f=fft2(Cbg);
    end
    % TF du champ de vitesse Marangoni du fluide en t=0
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
    
    % Champ de vitesse total du fluide filtré et interpolé en t=0
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse filtrée sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
    if rdomstart==4 || rdomstart==8
        uxp=vsx;
        uyp=vsy;
    end
    % Stockage pour les itérations de Adams-Bashforth
    vsx_old=vsx;% vitesse des nageurs en t=0
    vsy_old=vsy;% vitesse des nageurs en t=0
    xs_old=xs;% position t=0
    ys_old=ys;% position en t=0
    uxp_old=uxp; % Vitesse du champ fluide Marangoni+extérieur en t=0 sous les nageurs
    uyp_old=uyp; % Vitesse du champ fluide Marangoni+extérieur en t=0 sous les nageurs
    if bbg>1
    vxbg_old=vxbg;
    vybg_old=vybg;
    end
    
    
    %% Pas de temps en t=1/2
    if bbg>1
       xbg=xbg+vxbg*dt/2;
       ybg=ybg+vybg*dt/2;
       vxbg=interp2(x,y,real(ifft2(vxf+vxextf)),xbg,ybg,'spline')+sqrt(2*Dbg*dt/2)*randn(1,bbg)/(dt/2);
       vybg=interp2(x,y,real(ifft2(vyf+vyextf)),xbg,ybg,'spline')+sqrt(2*Dbg*dt/2)*randn(1,bbg)/(dt/2);
    end
    
    % Source de camphre en t=1/2
    source_f=zeros(size(source0_f));
    for nn=1:npart
        source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    
    
    % Calcul du terme d'advection (nul si advection=0)
    Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
    if bbg==1
        Sfbg=Sscal_adams(advection,Cbg0_f,vxext+real(ifft2(vxf)),vyext+real(ifft2(vyf)),kx,ky,alias);
        Sfbg_old=Sfbg;
    end
    Sfcamp=Sfcamp+source_f; % Puisqu'on a résolu par un changement de variable, on revient à celle de départ
    Sfcamp_old=Sfcamp;% Stockage pour Adams-Bashforth
    % calcul en t=1/2
    Ccamp_f=expdt05.*(Ccamp_f + dt*Sfcamp/2); % Propagation du résultat de l'équa diff sur un demi pas de temps
    Ccamp_f=Ccamp_f.*alias; %pour éviter les vecteurs d'ondes trop grands (aliasing)
    if bbg==1
        Cbg_f=expdt05bg.*(Cbg0_f + dt*Sfbg);
        Cbg_f=Cbg_f.*alias;
    end
    % calcul des positions et vitesses en t=1/2
    [xs,ys,vsx,vsy]=eval_posvit(0,inertie,dt/2,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); %0 car pas d'adams-bashforth ici
    
    
    
    % TF du champ de vitesse Marangoni en t=1/2
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
    
    
    % Champ de vitesse filtré et interpolé en t=1/2
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse filtrée sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
    
    
    % On ne change pas les old ici car pour 2 ce seront t=0 et t=1 les
    % importants
    %% scalaire en t=1
    if bbg>1
       xbg=xbg+vxbg*dt/2;
       ybg=ybg+vybg*dt/2;
       vxbg=interp2(x,y,real(ifft2(vxf+vxextf)),xbg,ybg,'spline')+sqrt(2*Dbg*dt/2)*randn(1,bbg)/(dt/2);
       vybg=interp2(x,y,real(ifft2(vyf+vyextf)),xbg,ybg,'spline')+sqrt(2*Dbg*dt/2)*randn(1,bbg)/(dt/2);
    end
    source_f=zeros(size(source0_f));
    for nn=1:npart
        source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    
    % calcul du champ de camphreen t=1
    Ccamp=real(ifft2(Ccamp_f));
    if bbg==1
        Cbg=real(ifft2(Cbg_f));
        Sfbg=Sscal_adams(advection,Cbg_f,vxext+real(ifft2(vxf)),vyext+real(ifft2(vyf)),kx,ky,alias);
        Sfbg=Sfbg.*alias;
    end
    % Calcul du terme d'advection du camphre (nul si advection=0)
    Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
    
    Sfcamp=Sfcamp+source_f;
    Sfcamp=Sfcamp.*alias;
    
    t=t+dt; % Le temps avance
    Ccamp_f=expdt.*Ccamp0_f + dt*expdt05.*Sfcamp; % Evolution de l'équa dif de 1/2 à 1
    Ccamp_f=Ccamp_f.*alias; % Pour éviter l'aliasing
    
    if bbg==1
        Cbg_f=expdtbg.*Cbg0_f + dt*expdt05bg.*Sfbg;
        Cbg_f=Cbg_f.*alias;
    end
    % calcul de la position et vitesse en dt, grâce à la vitesse en t=1/2. Les old sont
    % ceux de t=0
    [xs,ys,vsx,vsy]=eval_posvit(1,inertie,dt/2,xs_old,ys_old,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); %
    
    % Calcul de la vitesse Marangoni (de propulsion) en t=1
    % On en a besoin pour calculer le terme d'advection, mais on veut aussi
    % stocker ce qu'ils valent aux positions des nageurs pour connaitre la
    % direction de nage
    vx=real(ifft2((vxf))); %TF-1 du champ de vitesse marangoni du fluide en fourier
    vy=real(ifft2((vyf)));
    [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad,L);
    
    %Stockage du premier pas de temps (t=1)
    mx(1,1:npart)=xs(1,1:npart);
    my(1,1:npart)=ys(1,1:npart);
    muxp(1,1:npart)=uxp(1,1:npart);
    muyp(1,1:npart)=uyp(1,1:npart);
    mvsx(1,1:npart)=vsx(1,1:npart);
    mvsy(1,1:npart)=vsy(1,1:npart);
    mvxnage(1,1:npart)=vxnage(1,1:npart);
    mvynage(1,1:npart)=vynage(1,1:npart);
    if bbg==1
        mstdbg(1,1)=std(std(real(ifft2(Cbg_f))));
    end
    if bbg>1
        mxbg(1,1:bbg)=xbg;
        mybg(1,1:bbg)=ybg;
    end
end
%% Début de la boucle
compteur=1; %Pour sauvegarder les champs de vitesse

%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining the simulation loop...'),'keepthis','timestamp');




for in=old_nt+1:nt
    
    if in==200 && bbg==1
        %Cbg_f=fft2(ones(N));
        Cbg_f=fft2(exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2));
    end
    if bbg>1
        xbg=xbg+3/2*dt*vxbg-1/2*dt*vxbg_old;
        ybg=ybg+3/2*dt*vybg-1/2*dt*vybg_old;
        vxbg_old=vxbg;
        vybg_old=vybg;
        vxbg=interp2(x,y,real(ifft2(vxf+vxextf)),modulo(xbg,L),modulo(ybg,L),'spline')+sqrt(2*Dbg*dt)*randn(1,bbg)/dt;
        vybg=interp2(x,y,real(ifft2(vyf+vyextf)),modulo(xbg,L),modulo(ybg,L),'spline')+sqrt(2*Dbg*dt)*randn(1,bbg)/dt;
       % vxbg(abs(vxbg)>15)=vxbg_old(abs(vxbg)>15);
       % vybg(abs(vybg)>15)=vybg_old(abs(vybg)>15);

    end
        
        
    % Affichage du pourcentage d'avancée de la simu et de toutes celles
    % lancées

    
    Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'équa diff pour le camphre
    Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing
    if bbg==1
        Cbg_f=expdtbg.*(Cbg_f + 3/2*dt*Sfbg)-1/2*dt*expdt2bg.*Sfbg_old;
        Cbg_f=Cbg_f.*alias;
    end
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
    
    % On écrit dans les tableaux
    muxp(in,1:npart)=uxp(1,1:npart);
    muyp(in,1:npart)=uyp(1,1:npart);
    mvsx(in,1:npart)=vsx(1,1:npart);
    mvsy(in,1:npart)=vsy(1,1:npart);
    mx(in,1:npart)=xs(1,1:npart);% position x
    my(in,1:npart)=ys(1,1:npart);% position y
    mvxnage(in,1:npart)=vxnage(1,1:npart);
    mvynage(in,1:npart)=vynage(1,1:npart);
    if bbg==1
        mstdbg(in,1)=std(std(real(ifft2(Cbg_f))));
    end
    if bbg>1
        mxbg(in,1:bbg)=xbg;
        mybg(in,1:bbg)=ybg;
    end
    if old_nt==1 % Cette boucle que pour stocker des chps de vitesse e fluide qu'on n'utilise jamais
        if ismember(in,list)
            cpt=cpt+1;
            mvfx{cpt,1}=real(ifft2((vxf)));
            mvfy{cpt,1}=real(ifft2((vyf)));
        end
    end
 if in==10
     Ccamp10=real(ifft2(Ccamp_f));
 end
 if in==43
          Ccamp43=real(ifft2(Ccamp_f));

 end
 if in==800
          Ccamp800=real(ifft2(Ccamp_f));

 end
    
end

x=(-250:250)/250*L/2*sqrt(2);
C10=improfile(Ccamp10,[128,0],[128,0],501,'bilinear');
C43=improfile(Ccamp43,[128,0],[128,0],501,'bilinear');
C800=improfile(Ccamp800,[128,0],[128,0],501,'bilinear');
save('E:\Clément\MyCore\Analyse\SimuNum\Vortex\210108\vita\11_fields012.mat','Ccamp10','Ccamp43','Ccamp800','C10','C43','C800','x')

