nt=10e4;
nb=500;
profs=zeros(nb,200);
nbderepet=10;
liste=zeros(nbderepet,nb/nbderepet);
%% Initialisations de la simu
L = 2*pi; %Taille de la boîte
N=128;%Résolution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images

make_grid; %Initialise la grille de simu (N*N)
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.

%% Paramètres physiques

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
dt=taup/20;% Choix du pas de temps
if dt==0
    dt=0.2/20;
end
Dcamp=0.15;% Coeff de diffusion du camphre



%% Initialisation des tableaux de stockage de valeurs

mx=zeros(nt,npart);
my=zeros(nt,npart);
umar=zeros(nt,npart);
vmar=zeros(nt,npart);
muxp=zeros(nt,npart);
muyp=zeros(nt,npart);
mvsx=zeros(nt,npart);
mvsy=zeros(nt,npart);
mvfx=cell(200,1);
mvfy=cell(200,1);


%% Début de la simu
    
%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining the simulation loop...'),'keepthis','timestamp');
    
cpt=0;

% profil source de camphre (centré en pi), qui correspond à un nageur
source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);

% on definit le filtre dans l'espace de fourier
gfilt_f=source0_f/sum(sum(source));

source=asrc*source; % permet de l'annuler si pas de Marangoni en ayant quand même défini le filtre.
source0_f=asrc*source0_f; % Linéarité de la TF
for iii=1:nbderepet
    
    list=randi([nt/2/nbderepet,nt/nbderepet],[nb/nbderepet,1]);
    liste(iii,:)=list';
    if 1==1
        % Positions aléatoires des nageurs
        if rdomstart==1
            xp=2*pi*rand(1,npart);
            yp=2*pi*rand(1,npart);
        elseif rdomstart==2
            xp=0.1*ones(1,npart);
            yp=pi/4*ones(1,npart);
        elseif rdomstart==0
            xp=pi/4*ones(1,npart);
            yp=pi/4*ones(1,npart);
        elseif rdomstart==3
            xp=linspace(0.1,2*pi-0.1,npart)+0.01;
            yp=linspace(0.1,2*pi-0.1,npart)+0.01;
            
        end
        
        % vitesse initiale = vitesse locale de l'écoulement
        if ecoulement==1
            vxfilt=real(ifft2(vxextf.*gfilt_f)); %On filtre l'écoulement externe à la taille du nageur
            vyfilt=real(ifft2(vyextf.*gfilt_f));
            vsx=interp2(x,y,vxfilt,xp,yp,'spline'); %On interpole la vitesse filtrée à la position du nageur
            vsy=interp2(x,y,vyfilt,xp,yp,'spline');
            
        end
        if amp_ec==0 && npart==1
            vsx=0.001;
            vsy=0;
        end
        % stockage de la position initiale
        xs=xp;
        ys=yp;
        t=0;
    end
    
    
    %% Pas de temps 0
    
    % en fourier d_t TF[s] = -(Dcamp*k2+alpha)*TF[s] + B k2 TF[s.^2] + TF[source]
    
    k2=(kx.^2+ky.^2);
    expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
    expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
    expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);
    
    % initialisation t=0 du champ de camphre (une source à la position de
    % chaque nageur)
    Ccamp0_f=zeros(size(source0_f));
    for nn=1:npart
        Ccamp0_f=Ccamp0_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    Ccamp_f=Ccamp0_f;
    
    % positons et vitesse en t=0
    vsx_old=vsx;% vitesse en t=0
    vsy_old=vsy;% vitesse en t=0
    xs_old=xs;% position t=0
    ys_old=ys;% position en t=0
    
    % TF du champ de vitesse Marangoni en t=0
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A);
    
    % Champ de vitesse filtré et interpolé en t=0
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse filtrée sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad);
    
    % Stockage pour les itérations de Adams-Bashforth
    uxp_old=uxp;
    uyp_old=uyp;
    
    %% Pas de temps en t=1/2
    
    % Source de camphre en t=1/2
    source_f=zeros(size(source0_f));
    for nn=1:npart
        source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    
    % Calcul de la vitesse Marangoni (de propulsion) en t=1/2
    vx=real(ifft2((vxf)));
    vy=real(ifft2((vyf)));
    
    % Calcul du terme d'advection (nul si advection=0)
    Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
    
    Sfcamp=Sfcamp+source_f;
    Sfcamp_old=Sfcamp;% Stockage pour Adams-Bashforth
    % calcul en t=1/2
    Ccamp_f=expdt05.*(Ccamp_f + dt*Sfcamp/2); % Propagation du résultat de l'équa diff
    Ccamp_f=Ccamp_f.*alias; %pour éviter les vecteurs d'ondes trop grands (aliasing?)
    
    % calcul des positions et vitesses en t=1/2
    [xs,ys,vsx,vsy]=eval_posvit(0,inertie,dt/2,xs,ys,vsx,vsy,uxp,uyp,gfilt_f,vxextf,vyextf,Npad,xpad,ypad,uxp_old,vsx_old,uyp_old,vsy_old,vx,vy,taup); %0 car pas d'adams-bashforth ici
    
    % TF du champ de vitesse Marangoni en t=1/2
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A);
    
    
    % Champ de vitesse filtré et interpolé en t=1/2
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse filtrée sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad);
    
    % Nouvelle source de camphre en t=1/2 puisque les nageurs ont bougés
    source_f=zeros(size(source0_f));
    for nn=1:npart
        source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
    end
    
    % calcul du champ de camphreen t=1/2
    Ccamp=real(ifft2(Ccamp_f));
    
    % Calcul de la vitesse Marangoni en t=1/2
    vx=real(ifft2((vxf)));
    vy=real(ifft2((vyf)));
    
    % Calcul du terme d'advection (nul si advection=0)
    Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias);
    
    Sfcamp=Sfcamp+source_f;
    Sfcamp=Sfcamp.*alias;
    
    %% scalaire en t=1
    t=t+dt; % Le temps avance
    Ccamp_f=expdt.*Ccamp0_f + dt*expdt05.*Sfcamp; % Evolution de l'équa dif
    Ccamp_f=Ccamp_f.*alias; % Pour éviter l'aliasing
    
    % calcul de la position et vitesse en dt, grâce à la vitesse en t=1/2. Les old sont
    % ceux de t=0
    [xs,ys,vsx,vsy]=eval_posvit(0,inertie,dt,xs_old,ys_old,vsx,vsy,uxp,uyp,gfilt_f,vxextf,vyextf,Npad,xpad,ypad,uxp_old,vsx_old,uyp_old,vsy_old,vx,vy,taup); % 0 car pas d'adams-bashforth ici
    
    %Stockage du premier pas de temps
    mx(1,1:npart)=xs_old(1,1:npart);
    my(1,1:npart)=ys_old(1,1:npart);
    muxp(1,1:npart)=uxp_old(1,1:npart);
    muyp(1,1:npart)=uyp_old(1,1:npart);
    mvsx(1,1:npart)=vsx_old(1,1:npart);
    mvsy(1,1:npart)=vsy_old(1,1:npart);
    
    
    
    
  
    
    
    
    for in=1+1:nt/nbderepet
        
        
        % Affichage du pourcentage d'avancée de la simu
        if (mod(in,1000)==0)
            prcent=[round(((iii-1)*nt/nbderepet+in)*100/nt),round(100*(videocount+in-1)/globalcount)];
            dispstat(sprintf('Progress video %d%% Progress total %d%%',prcent),'timestamp');
        end
        
        %% On garde en mémoire pour l'itération adams-bashforth
        uxp_old=uxp;
        uyp_old=uyp;
        vsx_old=vsx;
        vsy_old=vsy;
        xs_old=xs;
        ys_old=ys;
        
        
        
        % TF du champ de vitesse Marangoni en t
        [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A);
        
        % Calcul du champ de camphre en t
        Ccamp=real(ifft2(Ccamp_f));% init en dt
        
        
        % Champ de vitesse filtré et interpolé en t
        % filtrage en fourier, interp dans l'espace physique
        [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
        
        
        %Donne la vitesse filtrée sur chacun des nageurs
        [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad);
        
        % Calcul de la source de camphre à l'instant t, en Fourier
        %source_f=source0_f.*exp(-1i*xs*kx-1i*ys*ky);
        source_f=zeros(size(source0_f));
        for nn=1:npart
            source_f=source_f+source0_f.*exp(-1i*xs(nn)*kx-1i*ys(nn)*ky);
        end
        
        % calcul des termes source
        Sfcamp = Sscal_adams(advection,Ccamp_f,vxext,vyext,kx,ky,alias); %advection est l'interrupteur on/off
        Sfcamp=Sfcamp+source_f;
        Sfcamp=Sfcamp.*alias;
        
        vx=real(ifft2(vxf));
        vy=real(ifft2(vyf));
        
        Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'équa diff
        Ccamp_f=Ccamp_f.*alias;%Eviter l'aliasing
        Sfcamp_old=Sfcamp;
        
        
        % Adams-Bashforth pour v et x
        % cas purement lagrangien
        [xs,ys,vsx,vsy]=eval_posvit(1,inertie,dt,xs_old,ys_old,vsx,vsy,uxp,uyp,gfilt_f,vxextf,vyextf,Npad,xpad,ypad,uxp_old,vsx_old,uyp_old,vsy_old,vx,vy,taup); %1 car adams-bashforth
        
        
        
        
        
        % On écrit dans les tableaux
        muxp((iii-1)*nt/nbderepet+in,1:npart)=uxp(1,1:npart);
        muyp((iii-1)*nt/nbderepet+in,1:npart)=uyp(1,1:npart);
        mvsx((iii-1)*nt/nbderepet+in,1:npart)=vsx(1,1:npart);
        mvsy((iii-1)*nt/nbderepet+in,1:npart)=vsy(1,1:npart);
        mx((iii-1)*nt/nbderepet+in,1:npart)=xs(1,1:npart);% position x
        my((iii-1)*nt/nbderepet+in,1:npart)=ys(1,1:npart);% position y
        vxfiltext=real(ifft2((vxextf).*gfilt_f));
        vyfiltext=real(ifft2((vyextf).*gfilt_f));
        vxfiltpext=padarray(vxfiltext,[10 10],'circular','both');
        vyfiltpext=padarray(vyfiltext,[10 10],'circular','both');
        xsm=modulo(mx((iii-1)*nt/nbderepet+in,1:npart),2*pi);
        ysm=modulo(my((iii-1)*nt/nbderepet+in,1:npart),2*pi);
        umar((iii-1)*nt/nbderepet+in,1:npart)=uxp-interp2(xpad,ypad,vxfiltpext,xsm,ysm,'spline');
        vmar((iii-1)*nt/nbderepet+in,1:npart)=uyp-interp2(xpad,ypad,vyfiltpext,xsm,ysm,'spline');
        
        if ismember(in,list)
            cpt=cpt+1;
            
            if sqrt((umar(in,1))^2+vmar(in,1)^2)~=0
            profs(cpt,:)=improfile(padarray(Ccamp,[120 120],'circular','both'),round(120+64/pi*[mod(xs,2*pi)-(umar(in,1)/sqrt((umar(in,1)+vmar(in,1))^2))*3 mod(xs,2*pi)+(umar(in,1))/sqrt((umar(in,1)+vmar(in,1))^2)*3]),round(120+64/pi*[mod(ys,2*pi)-(vmar(in,1))/sqrt((umar(in,1)+vmar(in,1))^2)*3 mod(ys,2*pi)+(vmar(in,1))/sqrt((umar(in,1)+vmar(in,1))^2)*3]),200);
            end
        end
        
        
    end
end



save(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_profiles.mat'),'profs','mx','my','umar','vmar','liste');


