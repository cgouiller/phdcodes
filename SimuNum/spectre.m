run defaultfig;run manips;
cols=['b','r','g','k','c','y','m'];
cpt=1;
for ii=[45,48,50,271]
    load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
    old_nt=nt;
    nt=old_nt+5000;
    bbg=manipCat.bbg(ii);
    taup=manipCat.taup(ii);
    inertie=manipCat.inertie(ii);
    amp_ec=manipCat.amp_ec(ii);
    npart=manipCat.npart(ii)
    A=manipCat.A(ii);
    rdomstart=manipCat.randomstart(ii);
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
    
    cptsp=0;
    k2=(kx.^2+ky.^2);
expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);
    % TF du champ de vitesse du fluide dû à Marangoni en t
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
    vx=real(ifft2(vxf));
    vy=real(ifft2(vyf));
    Sptotx=zeros(N/2+1,1);
    Sptoty=zeros(N/2+1,1);
    for in=old_nt+1:nt
        
        
        % Affichage du pourcentage d'avancée de la simu et de toutes celles
        % lancées
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

        if mod(in,50)==0
            for i=1:N
                
                [SpLinex,f]=pwelch(vx(i,:),hanning(N),round(N/2),N,1);
                Sptotx=Sptotx+SpLinex;
                [SpLiney,f]=pwelch(vx(i,:),hanning(N),round(N/2),N,1);
                Sptoty=Sptoty+SpLiney;
            end
            cptsp=cptsp+1;
        end
    end
    
    
    Spmeanx=Sptotx/(N*cptsp);
    Spmeany=Sptoty/(N*cptsp);
    Spmean=(Spmeanx+Spmeany)/2;
    hold on;
    loglog(f,Spmean,cols(cpt));
    cpt=cpt+1;
    hold off;
    directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
    save(strcat(directoryPyt,num2str(manipCat.video{ii}),'_Spvfield.mat'),'f','Spmean');
end
%legend({'7','15','25','45','70','100'})
legend({'7','45','100','150'})

set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
xlabel('k')
ylabel('Sp')

