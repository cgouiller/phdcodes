run defaultfig;run manips;
cols=['b','r','g','k','c','y','m'];
cpt=1;
%for ii=[617,639,591,640,618,619,620]
for ii=[617,640,619,620]

    ii
    load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
    old_nt=nt;
    bbg=manipCat.bbg(ii);
    taup=manipCat.taup(ii);
    inertie=manipCat.inertie(ii);
    amp_ec=manipCat.amp_ec(ii);
    npart=manipCat.npart(ii);
    A=manipCat.A(ii);
    nt=manipCat.nt(ii);
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
    
    %% Paramètres physiques invariables
    
    alpha=2; %Coefficient de sublimation
    sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
    Dcamp=0.15;% Coeff de diffusion du camphre
    Dbbg=0.015;
    t=old_nt*dt;
    
    
    %% Début de la simu
    sigbbg=sqrt(Dbg*dt);
    
    % profil source de camphre (centré en pi), qui correspond à un nageur
    source=exp(-((x-pi).^2+(y-pi).^2)/2/sigbbg^2)/(2*pi*sigbbg^2);% aire normalisée à 1
    % on centre la source en (0,0), translation de -pi en x et y
    source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);
    
    % on definit le filtre dans l'espace de fourier
    gfilt_f=source0_f/sum(sum(source));
    % TF du champ de vitesse du fluide dû à Marangoni en t
            Sptot=zeros(N/2+1,1);
nbimg=50;
    for img=linspace(length(mx(:,1))/2,length(mx(:,1)),nbimg)
        source_f=zeros(size(source0_f));
        for nn=1:bbg
            source_f=source_f+source0_f.*exp(-1i*mod(mxbg(round(img),nn),L)*kx-1i*mod(mybg(round(img),nn),L)*ky);
        end
        Cfield=real(ifft2(source_f));
        
        for i=1:N
            
            [SpLine,f]=pwelch(Cfield(i,:),hanning(N),round(N/2),N,1);
            Sptot=Sptot+SpLine;
            
        end
    end
    Spmean=Sptot/(N*nbimg);
    hold on;
    loglog(f,Spmean,cols(cpt));
    cpt=cpt+1;
    hold off;
    directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
    save(strcat(directoryPyt,num2str(manipCat.video{ii}),'_Spbbg.mat'),'f','Spmean');
end
%legend({'7','15','30','45','70','100','150'})
legend({'7','45','100','150'})

set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
xlabel('k')
ylabel('Sp')

