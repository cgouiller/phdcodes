% if old_nt~=1 && exist('k')~=0
%     ff=k; %Pour �viter le conflit entre fr�quence du spectre et k utilis� comme variable pour boucle for
% end

%% Initialisations de la simu
N=round(64/pi*L);%R�solution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images

make_grid; %Initialise la grille de simu (N*N) et une variable utile pour g�rer l'aliasing
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'�coulement externe et sa TF en fonction des choix de simu.

%% Param�tres physiques invariables

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associ�e au diam�tre des nageurs
Dcamp=0.15;% Coeff de diffusion du camphre
Dbg=0.15;


%% Initialisation des tableaux de stockage de valeurs
if old_nt==1 % Correspond � une simu jamais commenc�e
    mx=zeros(nt,npart); %Tableaux des positions des nageurs
    my=zeros(nt,npart);
    muxp=zeros(nt,npart); % Tableaux des vitesses filtr�es "sous le nageur"
    muyp=zeros(nt,npart);
    mvsx=zeros(nt,npart); % Tableaux des vitesses des nageurs
    mvsy=zeros(nt,npart);
    mvxnage=zeros(nt,npart); % Tableaux de la composante Marangoni de propulsion
    mvynage=zeros(nt,npart);
    mvfx=cell(200,1);   % Pour stocker quelques champs de vitesse, pas exploit�s en ce moment
    mvfy=cell(200,1);
    if bbg~=0
        mstdbg=zeros(nt,1);
    end
end
if old_nt~=1 % Correspond � une simu � poursuivre
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
    if bbg~=0
        mstdbgb=zeros(nt,1);
        mstdbgb(1:old_nt,1)=msdtbg;
        mstdbg=mstdbgb;
    end
    t=old_nt*dt;
end

%% D�but de la simu
if old_nt==1
    cpt=0; list=round(linspace(1000,nt,200)); % Pour stocker les chps de vit utiles pour calculer les spectres
end
% profil source de camphre (centr� en pi), qui correspond � un nageur
source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalis�e � 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);

% on definit le filtre dans l'espace de fourier
gfilt_f=source0_f/sum(sum(source));

source=asrc*source; % permet de l'annuler si pas de Marangoni en ayant quand m�me d�fini le filtre.
source0_f=asrc*source0_f; % Lin�arit� de la TF

if old_nt==1
    % Positions al�atoires des nageurs
    if rdomstart==1
        xp=2*pi*rand(1,npart);
        yp=2*pi*rand(1,npart);
    elseif rdomstart==2
        xp=(pi/2-0.1)*ones(1,npart);
        yp=(pi/2-0.1)*ones(1,npart);
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
    end
    if bbg==1
        Cbg=zeros(N);
        
    end
    % vitesse initiale = vitesse locale de l'�coulement
    if ecoulement==1
        vxfilt=real(ifft2(vxextf.*gfilt_f)); %On filtre l'�coulement externe � la taille du nageur
        vyfilt=real(ifft2(vyextf.*gfilt_f));
        vsx=interp2(x,y,vxfilt,xp,yp,'spline'); %On interpole la vitesse filtr�e � la position du nageur
        vsy=interp2(x,y,vyfilt,xp,yp,'spline');
        
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
    % stockage de la position initiale
    xs=xp;
    ys=yp;
    t=0;
end


%% Pas de temps 0

% en fourier d_t TF[s] = -(Dcamp*k2+alpha)*TF[s] + B k2 TF[s.^2] + TF[source]
% Ces exponentielles sont utiles pour r�soudre l'�que diff et la faire
% progresser en temps:
k2=(kx.^2+ky.^2);
expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);
expdtbg=exp(-Dbg*dt*k2);
expdt05bg=exp(-Dbg*dt*k2/2);
expdt2bg=exp(-2*Dbg*dt*k2);
if old_nt==1
    
    
    % initialisation t=0 du champ de camphre (une source � la position de
    % chaque nageur)
    Ccamp0_f=zeros(size(source0_f));
    for nn=1:npart
        Ccamp0_f=Ccamp0_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    Ccamp_f=Ccamp0_f;
    if bbg~=0
        Cbg0_f=fft2(Cbg);
    end
    % TF du champ de vitesse Marangoni du fluide en t=0
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
    
    % Champ de vitesse total du fluide filtr� et interpol� en t=0
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse filtr�e sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
    if rdomstart==4
        uxp=vsx;
        uyp=vsy;
    end
    % Stockage pour les it�rations de Adams-Bashforth
    vsx_old=vsx;% vitesse des nageurs en t=0
    vsy_old=vsy;% vitesse des nageurs en t=0
    xs_old=xs;% position t=0
    ys_old=ys;% position en t=0
    uxp_old=uxp; % Vitesse du champ fluide Marangoni+ext�rieur en t=0 sous les nageurs
    uyp_old=uyp; % Vitesse du champ fluide Marangoni+ext�rieur en t=0 sous les nageurs
    
    
    
    
    %% Pas de temps en t=1/2
    
    % Source de camphre en t=1/2
    source_f=zeros(size(source0_f));
    for nn=1:npart
        source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    
    
    % Calcul du terme d'advection (nul si advection=0)
    Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
    if bbg~=0
        Sfbg=Sscal_adams(advection,Cbg0_f,vxext+real(ifft2(vxf)),vyext+real(ifft2(vyf)),kx,ky,alias);
        Sfbg_old=Sfbg;
    end
    Sfcamp=Sfcamp+source_f; % Puisqu'on a r�solu par un changement de variable, on revient � celle de d�part
    Sfcamp_old=Sfcamp;% Stockage pour Adams-Bashforth
    % calcul en t=1/2
    Ccamp_f=expdt05.*(Ccamp_f + dt*Sfcamp/2); % Propagation du r�sultat de l'�qua diff sur un demi pas de temps
    Ccamp_f=Ccamp_f.*alias; %pour �viter les vecteurs d'ondes trop grands (aliasing)
    if bbg~=0
        Cbg_f=expdt05bg.*(Cbg0_f + dt*Sfbg);
        Cbg_f=Cbg_f.*alias;
    end
    % calcul des positions et vitesses en t=1/2
    [xs,ys,vsx,vsy]=eval_posvit(0,inertie,dt/2,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); %0 car pas d'adams-bashforth ici
    
    
    
    
    % TF du champ de vitesse Marangoni en t=1/2
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
    
    
    % Champ de vitesse filtr� et interpol� en t=1/2
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse filtr�e sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
    
    
    % On ne change pas les old ici car pour 2 ce seront t=0 et t=1 les
    % importants
    %% scalaire en t=1
    
    source_f=zeros(size(source0_f));
    for nn=1:npart
        source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    
    % calcul du champ de camphreen t=1
    Ccamp=real(ifft2(Ccamp_f));
    if bbg~=0
        Cbg=real(ifft2(Cbg_f));
        Sfbg=Sscal_adams(advection,Cbg_f,vxext+real(ifft2(vxf)),vyext+real(ifft2(vyf)),kx,ky,alias);
        Sfbg=Sfbg.*alias;
    end
    % Calcul du terme d'advection du camphre (nul si advection=0)
    Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
    
    Sfcamp=Sfcamp+source_f;
    Sfcamp=Sfcamp.*alias;
    
    t=t+dt; % Le temps avance
    Ccamp_f=expdt.*Ccamp0_f + dt*expdt05.*Sfcamp; % Evolution de l'�qua dif de 1/2 � 1
    Ccamp_f=Ccamp_f.*alias; % Pour �viter l'aliasing
    
    if bbg~=0
        Cbg_f=expdtbg.*Cbg0_f + dt*expdt05bg.*Sfbg;
        Cbg_f=Cbg_f.*alias;
    end
    % calcul de la position et vitesse en dt, gr�ce � la vitesse en t=1/2. Les old sont
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
    if bbg~=0
        mstdbg(1,1)=std(std(real(ifft2(Cbg_f))));
    end
end
%% D�but de la boucle
compteur=1; %Pour sauvegarder les champs de vitesse

%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining the simulation loop...'),'keepthis','timestamp');




for in=old_nt+1:nt
    
    if in==200
        %Cbg_f=fft2(ones(N));
        Cbg_f=fft2(exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2));
    end
    % Affichage du pourcentage d'avanc�e de la simu et de toutes celles
    % lanc�es
    if (mod(in,1000)==0)
        prcent=[round((in-(old_nt+1))*100/(nt-old_nt+1)),round(100*(videocount+in-old_nt)/globalcount)];
        dispstat(sprintf('Progress video %d%% Progress total %d%%',prcent),'timestamp');
    end
    
    Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'�qua diff pour le camphre
    Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing
    if bbg~=0
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
    
    
    % Calcul de la source de camphre � l'instant t, en Fourier
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
    if bbg~=0
        Sfbg_old=Sfbg;
        Sfbg=Sscal_adams(advection,Cbg_f,vxext+real(ifft2(vxf)),vyext+real(ifft2(vyf)),kx,ky,alias);
        Sfbg=Sfbg.*alias;
    end
    
    % TF du champ de vitesse du fluide d� � Marangoni en t
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
    
    % Champ de vitesse du fluide total filtr� et interpol� en t
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse du fluide tot filtr�e sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L);
    
    % Composante Marangoni de la vitesse du nageur
    vx=real(ifft2((vxf).*gfilt_f));
    vy=real(ifft2((vyf).*gfilt_f));
    [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad,L);
    
    t=t+dt;
    
    % On �crit dans les tableaux
    muxp(in,1:npart)=uxp(1,1:npart);
    muyp(in,1:npart)=uyp(1,1:npart);
    mvsx(in,1:npart)=vsx(1,1:npart);
    mvsy(in,1:npart)=vsy(1,1:npart);
    mx(in,1:npart)=xs(1,1:npart);% position x
    my(in,1:npart)=ys(1,1:npart);% position y
    mvxnage(in,1:npart)=vxnage(1,1:npart);
    mvynage(in,1:npart)=vynage(1,1:npart);
    if bbg~=0
        mstdbg(in,1)=std(std(real(ifft2(Cbg_f))));
    end
    if old_nt==1 % Cette boucle que pour stocker des chps de vitesse e fluide qu'on n'utilise jamais
        if ismember(in,list)
            cpt=cpt+1;
            mvfx{cpt,1}=real(ifft2((vxf)));
            mvfy{cpt,1}=real(ifft2((vyf)));
        end
    end
    %% Affichage des champs
    if round(in/chopvec)*chopvec==in && affichage==1
        colormap parula(256);
        if bbg==0
            % Calcul du champ de camphre en t
            Ccamp=real(ifft2(Ccamp_f));% init en dt
            
            figure(1);
            pcolor(x,y,Ccamp);colorbar;shading flat;axis equal;caxis([0 1])
            hold on
            plot(modulo(xs,L),modulo(ys,L),'ok','markerfacecolor','r');
            quiver(x(1:3:N,1:3:N),y(1:3:N,1:3:N),vxext(1:3:N,1:3:N),vyext(1:3:N,1:3:N),'w');
            quiver(mod(xs,L),mod(ys,L),vxnage,vynage,'r')
            quiver(mod(xs,L),mod(ys,L),vsx,vsy,'k')
            [vxecext,vyecext]=vfiltnag(real(ifft2((vxextf).*gfilt_f)),real(ifft2((vyextf).*gfilt_f)),Npad,xs,ys,xpad,ypad,L);
            quiver(mod(xs,L),mod(ys,L),vxecext,vyecext,'w')
            title(strcat('Champ de camphre et nageurs, t=',int2str(in)));
            hold off
            pause(0.01) % Pour que l'affichage � l'�cran soit rafraichi
        else
            Cbg=real(ifft2(Cbg_f));% init en dt
            
            figure(1);
            pcolor(x,y,Cbg);colorbar;shading flat;axis equal;%caxis([0 1])
            hold on
            plot(modulo(xs,L),modulo(ys,L),'ok','markerfacecolor','r');
            quiver(x(1:3:N,1:3:N),y(1:3:N,1:3:N),vxext(1:3:N,1:3:N),vyext(1:3:N,1:3:N),'w');
            quiver(mod(xs,L),mod(ys,L),vxnage,vynage,'r')
            quiver(mod(xs,L),mod(ys,L),vsx,vsy,'k')
            [vxecext,vyecext]=vfiltnag(real(ifft2((vxextf).*gfilt_f)),real(ifft2((vyextf).*gfilt_f)),Npad,xs,ys,xpad,ypad,L);
            quiver(mod(xs,L),mod(ys,L),vxecext,vyecext,'w')
            
            
            hold off
            title(strcat('Champ de bbg et nageurs, t=',int2str(in)));
            pause(0.01) % Pour que l'affichage � l'�cran soit rafraichi
            
        end
    end
    
    
    
    
    if autosaves==1 && mod(in*1000/nt,1)==0 % Pour faire des sauvegardes interm�diaires, au cas o� par exemple l'ordi se met � jour de son propre chef pendant que �a tourne encore la nuit :P
        if exist(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\'))==0
            mkdir(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\'));
        end
        nts=nt; % On veut sauvegarder comme nt le pas de temps o� on s'est arr�t�, et pas celui pr�vu d'o� ce petit trick avec un autre nom nts
        nt=in; %Malgr� ce que dit matlab, nt est utilis� dans la sauvegarde !
        if bbg==0
            save(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'Sfcamp','mvxnage','mvynage','muxp','muyp','mvsx','mvsy','Ccamp_f','nt','mx','my','Dnag','taup','advection','ecoulement','param_ecexterne','dt','uxp','uyp','vsx','vsy','xs','ys','Sfcamp_old','xs_old','ys_old','vsx_old','vsy_old','uxp_old','uyp_old','satur');
        else
            save(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'Sfcamp','mvxnage','mvynage','muxp','muyp','mvsx','mvsy','Ccamp_f','nt','mx','my','Dnag','taup','advection','ecoulement','param_ecexterne','dt','uxp','uyp','vsx','vsy','xs','ys','Sfcamp_old','xs_old','ys_old','vsx_old','vsy_old','uxp_old','uyp_old','satur','mstdbg');
            
        end
        nt=nts;
    end
    
    
end



%% Mise en forme pour la mesure de MSD
% Formatage des trajectoires pour l'utilisation de msdanalyzer
% tracks = cell(npart, 1);
%
% for i = 1 : npart
%
%     % Time
%     time = (0 : nt-1)' * dt;
%
%     X=mx(1:nt,i);
%     Y=my(1:nt,i);
%
%     % Store
%     tracks{i} = [time X Y];
%
% end
% ma = msdanalyzer(2, 'space unit', 'time'); % Cr�e la classe n�cessaire � l'utilisation de msd analyzer
%
% ma = ma.addAll(tracks); %Ajoute les trajectoires � la classe
%
% %ma.plotTracks;
% ma = ma.computeMSD; %Calcule le MSD



%% Calcul du spectre du champ de vitesse
% if old_nt==1
%     j=1;
%     Spaddx=zeros(65,1);
%     Spaddy=zeros(65,1);
%     for j=1:200 %vf contient 200 champs de vitesse r�partis sur la simu dont on va moyenner les spectres
%         vfx=mvfx{j}; %On en garde qu'un � chaque fois (le num�ro j)
%         vfy=mvfy{j};
%         for k=1:128 %Somme de chaque ligne de chaque champ de vitesse
%             Spaddx=Spaddx+pwelch(vfx(k,:),hanning(128),round(128/2),128,1/(2*pi));
%             Spaddy=Spaddy+pwelch(vfy(k,:),hanning(128),round(128/2),128,1/(2*pi));
%         end
%
%     end
%     Spx=Spaddx/(128*200); %Normalisation
%     Spy=Spaddy/(128*200);
%     Sp=(Spx+Spy)/2;
%     [aaa,ff]=pwelch(vfy(k,:),hanning(128),round(128/2),128,1/(2*pi)); % juste pour r�cup�rer le vecteur fr�quence
% end
%
% k=ff;
%% On sauvegarde tout
if exist(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\'))==0
    mkdir(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\'));
end
%save(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'commit','muxp','muyp','mvsx','mvsy','Ccamp_f','nt','mx','my','Dnag','taup','advection','ecoulement','param_ecexterne','k','Spx','Spy','dt','uxp','uyp','vsx','vsy','xs','ys','Sfcamp_old');
save(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'Sfcamp','mvxnage','mvynage','muxp','muyp','mvsx','mvsy','Ccamp_f','nt','mx','my','Dnag','taup','advection','ecoulement','param_ecexterne','dt','uxp','uyp','vsx','vsy','xs','ys','Sfcamp_old','xs_old','ys_old','vsx_old','vsy_old','uxp_old','uyp_old','satur');


