%% Initialisations de la simu
L = 2*pi; %Taille de la boîte
N=128;%Résolution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images

make_grid; %Initialise la grille de simu (N*N) et une variable utile pour gérer l'aliasing
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.

%% Paramètres physiques invariables

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
Dcamp=0.15;% Coeff de diffusion du camphre



%% Initialisation des tableaux de stockage de valeurs

    muxpb=zeros(nt,npart);
    muypb=zeros(nt,npart);
    mvsxb=zeros(nt,npart);
    mvsyb=zeros(nt,npart);
    mvxnageb=zeros(nt,npart);
    mvynageb=zeros(nt,npart);
    muxpb(1:nt,1:npart)=muxp(1:nt,1:npart);
    muypb(1:nt,1:npart)=muyp(1:nt,1:npart);
    mvsxb(1:nt,1:npart)=mvsx(1:nt,1:npart);
    mvsyb(1:nt,1:npart)=mvsy(1:nt,1:npart);
    mvxnageb(1:nt,1:npart)=mvxnage(1:nt,1:npart);
    mvynageb(1:nt,1:npart)=mvynage(1:nt,1:npart);
    muxp=muxpb;
    muyp=muypb;
    mvsx=mvsxb;
    mvsy=mvsyb;
    mvxnage=mvxnageb;
    mvynage=mvynageb;
    
    mxb=zeros(nt,npart);
    myb=zeros(nt,npart);
    mxb(1:nt,1:npart)=mx(1:nt,1:npart);
    myb(1:nt,1:npart)=my(1:nt,1:npart);
    mx=mxb;
    my=myb;
    
    t=nt*dt;

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
decalage=(pi/2)/50;
decx=[0,decalage,decalage,decalage,0];
decy=[decalage,decalage,0,-decalage,-decalage];
vxforc=zeros(5,1);
vyforc=zeros(5,1);
for kkk=1:5
    load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
    for in=nt+1:nt+5000
        
        
        
        
        Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'équa diff pour le camphre
        
        Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing
        
        % Position et vitesse des sources
        %[xsnew,ysnew,vsxnew,vsynew]=eval_posvit(1,inertie,dt,xs,ys,vsx,vsy,uxp,uyp,uxp_old,vsx_old,uyp_old,vsy_old,taup); % Evolution de vitesse et position des nageurs
        xsnew=mx(nt)+decx(kkk);
        ysnew=my(nt)+decy(kkk);
        vsxnew=0;
        vsynew=0;
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
        
        
        % TF du champ de vitesse du fluide dû à Marangoni en t
        [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
        
        % Champ de vitesse du fluide total filtré et interpolé en t
        % filtrage en fourier, interp dans l'espace physique
        [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
        
        %Donne la vitesse du fluide tot filtrée sur chacun des nageurs
        [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad);
        
        % Composante Marangoni de la vitesse du nageur
        vx=real(ifft2((vxf+vxextf).*gfilt_f));
        vy=real(ifft2((vyf+vyextf).*gfilt_f));
        [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad);
        
        t=t+dt;
        
        
        
    end
    xeq=mx(nt);
    yeq=my(nt);
    vxforc(kkk)=vxnage;
    vyforc(kkk)=vynage;
    Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'équa diff pour le camphre
    Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing
    Ccampfin=real(ifft2(Ccamp_f));
    if kkk==1
        Ccamph=Ccampfin;
    end
    if kkk==2
        Ccamphd=Ccampfin;
        
    end
    if kkk==3
        Ccampd=Ccampfin;
        
    end
    if kkk==4
        Ccampbd=Ccampfin;
        
    end
    if kkk==5
        Ccampb=Ccampfin;
        
    end
end

%% On sauvegarde tout

directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');

save(strcat(directoryPyt,manipCat.video{ii},'_stab.mat'),'decx','decy','vxforc','vyforc','Ccamph','Ccamphd','Ccampd','Ccampbd','Ccampb','xeq','yeq');


