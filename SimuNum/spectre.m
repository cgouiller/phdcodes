run defaultfig;run manips;
cols=['b','r','g','k','c','y','m'];
cpt=1;
%for ii=45:50
for ii=[45,48,50,271]
    load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
        old_nt=nt;
        bbg=manipCat.bbg(ii);
    taup=manipCat.taup(ii);
    inertie=manipCat.inertie(ii);
    amp_ec=manipCat.amp_ec(ii);
    npart=manipCat.npart(ii)
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
    
    Dnag=5; %En mm, le diam�tre des nageurs voulus
    asrc=manipCat.asrc(ii); % Amplitude du flux de camphre lib�r�
    advection=1; %1 si avec advection, 0 si non
    
    
    param_ecexterne=manipCat.paramec(ii);
 

%% Initialisations de la simu
N=round(64/pi*L);%R�solution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images

make_grid; %Initialise la grille de simu (N*N) et une variable utile pour g�rer l'aliasing
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'�coulement externe et sa TF en fonction des choix de simu.

%% Param�tres physiques invariables

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associ�e au diam�tre des nageurs
Dcamp=0.15;% Coeff de diffusion du camphre



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

  
    
    % TF du champ de vitesse du fluide d� � Marangoni en t
    [vxf,vyf]=ec_marangoni(marangoni,Ccamp_f,kx,ky,A,satur);
    vx=real(ifft2(vxf));
    vy=real(ifft2(vyf));
Sptotx=zeros(N/2+1,1);
Sptoty=zeros(N/2+1,1);

for i=1:N
    
    [SpLinex,f]=pwelch(vx(i,:),hanning(N),round(N/2),N,1);
    Sptotx=Sptotx+SpLinex;
    [SpLiney,f]=pwelch(vx(i,:),hanning(N),round(N/2),N,1);
    Sptoty=Sptoty+SpLiney;
end
Spmeanx=Sptotx/N;
Spmeany=Sptoty/N;
Spmean=(Spmeanx+Spmeany)/2;
hold on;
loglog(f,Spmean,cols(cpt));
cpt=cpt+1;
hold off;
    directoryPyt=strcat('E:\Cl�ment\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
    save(strcat(directoryPyt,num2str(manipCat.video{ii}),'_Spvfield.mat'),'f','Spmean');
end
%legend({'7','15','25','45','70','100'})
legend({'7','45','100','150'})

set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
xlabel('k')
ylabel('Sp')

