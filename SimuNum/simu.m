if old_nt~=1
        ff=k; %Pour éviter le conflit entre fréquence du spectre et k utilisé comme variable pour boucle for
end

%% Initialisations de la simu
L = 2*pi; %Taille de la boîte
N=128;%Résolution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images

make_grid; %Initialise la grille de simu (N*N)
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.
cylindric_coord; % Initialise une grille utile pour passer les trajectoires en coord cylindriques

%% Paramètres physiques

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
dt=taup/20;% Choix du pas de temps
if dt==0
    dt=0.2/20;
end
Dcamp=0.15;% Coeff de diffusion du camphre



%% Initialisation des tableaux de stockage de valeurs
if old_nt==1
    mx=zeros(nt,npart);
    my=zeros(nt,npart);
    muxp=zeros(nt,npart);
    muyp=zeros(nt,npart);
    mvsx=zeros(nt,npart);
    mvsy=zeros(nt,npart);
    mvfx=cell(200,1);
    mvfy=cell(200,1);
end
if old_nt~=1
    muxp=zeros(nt-old_nt+1,npart);
    muyp=zeros(nt-old_nt+1,npart);
    mvsx=zeros(nt-old_nt+1,npart);
    mvsy=zeros(nt-old_nt+1,npart);
    mxb=zeros(nt,npart);
    myb=zeros(nt,npart);
    mxb(1:old_nt,1:npart)=mx;
    myb(1:old_nt,1:npart)=my;
    mx=mxb;
    my=myb;
    
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
   elseif rdomstart==0
       xp=pi/4*ones(1,npart);
       yp=pi/4*ones(1,npart);
   end

% vitesse initiale = vitesse locale de l'écoulement
if ecoulement==1
    vxfilt=real(ifft2(vxextf.*gfilt_f)); %On filtre l'écoulement externe à la taille du nageur
    vyfilt=real(ifft2(vyextf.*gfilt_f));
    vsx=interp2(x,y,vxfilt,xp,yp,'spline'); %On interpole la vitesse filtrée à la position du nageur
    vsy=interp2(x,y,vyfilt,xp,yp,'spline');
elseif ecoulement==0
    vsx=zeros(1,npart);
    vsy=zeros(1,npart);
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

if old_nt==1
    
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
    
    
    
    compteur=1; %Pour sauvegarder les champs de vitesse
    
end
%% Début de la boucle

%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining the simulation loop...'),'keepthis','timestamp');




for in=old_nt+1:nt
    
    
    % Affichage du pourcentage d'avancée de la simu
    if (mod(in,100)==0)
        dispstat(sprintf('Progress %d%%',round((in-(old_nt+1))*100/(nt-old_nt+1))),'timestamp');
    end
    
    
    % On écrit dans les tableaux
    muxp(in-old_nt+1,1:npart)=uxp(1,1:npart);
    muyp(in-old_nt+1,1:npart)=uyp(1,1:npart);
    mvsx(in-old_nt+1,1:npart)=vsx(1,1:npart);
    mvsy(in-old_nt+1,1:npart)=vsy(1,1:npart);
    mx(in,1:npart)=xs(1,1:npart);% position x
    my(in,1:npart)=ys(1,1:npart);% position y
    
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
    
    
    
    %% On garde en mémoire pour l'itération adams-bashforth
    uxp_old=uxp;
    uyp_old=uyp;
    vsx_old=vsx;
    vsy_old=vsy;
    xs_old=xs;
    ys_old=ys;
    if old_nt==1
        if ismember(in,list)
            cpt=cpt+1;
            mvfx{cpt,1}=real(ifft2((vxf)));
            mvfy{cpt,1}=real(ifft2((vyf)));
        end
    end
    %% Affichage des champs
    if round(in/chopvec)*chopvec==in && affichage==1
        colormap parula(256);
        
        
        figure(1);
        pcolor(x,y,Ccamp);colorbar;shading flat;axis equal;caxis([0 1])
        hold on
        plot(modulo(xs,2*pi),modulo(ys,2*pi),'ok','markerfacecolor','r');
        hold off
        title(strcat('Champ de camphre et nageurs, t=',int2str(in)));
        pause(0.01) % Pour que l'affichage à l'écran soit rafraichi
    end
    
    
    t=t+dt;
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
% ma = msdanalyzer(2, 'space unit', 'time'); % Crée la classe nécessaire à l'utilisation de msd analyzer
% 
% ma = ma.addAll(tracks); %Ajoute les trajectoires à la classe
% 
% %ma.plotTracks;
% ma = ma.computeMSD; %Calcule le MSD



%% Calcul du spectre du champ de vitesse
if old_nt==1
    j=1;
    Spaddx=zeros(65,1);
    Spaddy=zeros(65,1);
    for j=1:200 %vf contient 200 champs de vitesse répartis sur la simu dont on va moyenner les spectres
        vfx=mvfx{j}; %On en garde qu'un à chaque fois (le numéro j)
        vfy=mvfy{j};
        for k=1:128 %Somme de chaque ligne de chaque champ de vitesse
            Spaddx=Spaddx+pwelch(vfx(k,:),hanning(128),round(128/2),128,1/(2*pi));
            Spaddy=Spaddy+pwelch(vfy(k,:),hanning(128),round(128/2),128,1/(2*pi));
        end
        
    end
    Spx=Spaddx/(128*200); %Normalisation
    Spy=Spaddy/(128*200);
    Sp=(Spx+Spy)/2;
    [aaa,ff]=pwelch(vfy(k,:),hanning(128),round(128/2),128,1/(2*pi)); % juste pour récupérer le vecteur fréquence
end

k=ff;
%% On sauvegarde tout
mkdir(strcat('E:\Clément\SimuNum\Resultats2\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\'));
save(strcat('E:\Clément\SimuNum\Resultats2\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'),'Ccamp_f','nt','mx','my','Dnag','taup','advection','ecoulement','param_ecexterne','k','Spx','Spy','dt','uxp','uyp','uxp_old','uyp_old','vsx_old','vsx','vsy_old','vsy','xs','xs_old','ys','ys_old','Sfcamp_old');


