%% Pour le repère de Frénet:
L = 2*pi; %Taille de la boîte
N=128;%Résolution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images
make_grid; %Initialise la grille de simu (N*N)
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.
alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
dt=taup/20;% Choix du pas de temps
if dt==0
    dt=0.2/20;
end
Dcamp=0.15;% Coeff de diffusion du camphre
% profil source de camphre (centré en pi), qui correspond à un nageur
source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);

% on definit le filtre dans l'espace de fourier
gfilt_f=source0_f/sum(sum(source));

vxfiltfr=real(ifft2((vxextf).*gfilt_f));
vyfiltfr=real(ifft2((vyextf).*gfilt_f));
vxfiltpfr=padarray(vxfilt,[Npad Npad],'circular','both');
vyfiltpfr=padarray(vyfilt,[Npad Npad],'circular','both');
xsmfr=modulo(mx,2*pi);
ysmfr=modulo(my,2*pi);
vxfr=interp2(xpad,ypad,vxfiltp,xsmfr,ysmfr,'spline');
vyfr=interp2(xpad,ypad,vyfiltp,xsmfr,ysmfr,'spline');

save(strcat(fname(1:end-4),'_frenet.mat'),'vxfr','vyfr')
