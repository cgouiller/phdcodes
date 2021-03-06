nb=100;
lensim=5e3;
nt=old_nt+lensim;
profs=zeros(nb,200);
list=old_nt+1+round(rand([1,nb])*(lensim-2));
cpt=1;
%% Initialisations de la simu
L = 2*pi; %Taille de la bo�te
N=128;%R�solution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images

make_grid; %Initialise la grille de simu (N*N) et une variable utile pour g�rer l'aliasing
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'�coulement externe et sa TF en fonction des choix de simu.

%% Param�tres physiques invariables

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associ�e au diam�tre des nageurs
Dcamp=0.15;% Coeff de diffusion du camphre



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
    
    t=old_nt*dt;


%% D�but de la simu
% profil source de camphre (centr� en pi), qui correspond � un nageur
source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalis�e � 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);

% on definit le filtre dans l'espace de fourier
gfilt_f=source0_f/sum(sum(source));

source=asrc*source; % permet de l'annuler si pas de Marangoni en ayant quand m�me d�fini le filtre.
source0_f=asrc*source0_f; % Lin�arit� de la TF





% en fourier d_t TF[s] = -(Dcamp*k2+alpha)*TF[s] + B k2 TF[s.^2] + TF[source]
% Ces exponentielles sont utiles pour r�soudre l'�que diff et la faire
% progresser en temps:
k2=(kx.^2+ky.^2);
expdt=exp(-alpha*dt)*exp(-Dcamp*dt*k2);% on a mis la reaction dedans
expdt05=exp(-alpha*dt/2)*exp(-Dcamp*dt*k2/2);
expdt2=exp(-2*alpha*dt)*exp(-2*Dcamp*dt*k2);

%% D�but de la boucle

%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining the simulation loop...'),'keepthis','timestamp');




for in=old_nt+1:nt
    
    
    % Affichage du pourcentage d'avanc�e de la simu et de toutes celles
    % lanc�es
    if (mod(in,1000)==0)
        prcent=[round((in-(old_nt+1))*100/(nt-old_nt+1)),round(100*(videocount+in-old_nt)/globalcount)];
        dispstat(sprintf('Progress video %d%% Progress total %d%%',prcent),'timestamp');
    end
    
    Ccamp_f=expdt.*(Ccamp_f + 3/2*dt*Sfcamp)-1/2*dt*expdt2.*Sfcamp_old;% Evolution de l'�qua diff pour le camphre
    
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
    
    
    % TF du champ de vitesse du fluide d� � Marangoni en t
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A);
    
    % Champ de vitesse du fluide total filtr� et interpol� en t
    % filtrage en fourier, interp dans l'espace physique
    [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f);
    
    %Donne la vitesse du fluide tot filtr�e sur chacun des nageurs
    [uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad);
    
    % Composante Marangoni de la vitesse du nageur
    vx=real(ifft2((vxf).*gfilt_f));
    vy=real(ifft2((vyf).*gfilt_f));
    [vxnage,vynage]=vfiltnag(vx,vy,Npad,xs,ys,xpad,ypad);
    
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
    
    Ccamp=real(ifft2(Ccamp_f.*alias));
    if ismember(in,list)
        profs(cpt,:)=improfile(padarray(Ccamp,[120 120],'circular','both'),round(121+64/pi*[mod(xs,2*pi)-(vxnage/sqrt((vxnage^2+vynage^2)))*3 mod(xs,2*pi)+(vxnage)/sqrt((vxnage^2+vynage^2))*3]),round(121+64/pi*[mod(ys,2*pi)-(vynage)/sqrt((vxnage^2+vynage^2))*3 mod(ys,2*pi)+(vynage)/sqrt((vxnage^2+vynage^2))*3]),200);
        cpt=cpt+1;
    end
    
end



%% On sauvegarde tout
meanprof=mean(profs,1);
stdprof=std(profs,1);

directoryPyt=strcat('E:\Cl�ment\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
save(strcat(directoryPyt,manipCat.video{ii},'_prof.mat'),'meanprof','stdprof','old_nt');


