clear all 
run manips
ii=118;
load(strcat('E:\Clément\SimuNum\Resultats\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'));

amp_ec=manipCat200320.amp_ec(ii);

L = 2*pi; %Taille de la boîte
N=128;%Résolution de la grille de simu
dx=L/N;
dy=L/N;
Dnag=5;
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
Npad=10;
x0=(0:(N-1))*dx; % gridx
y0=(0:(N-1))*dy; % gridy
[x,y]=meshgrid(x0,y0); % gridxy
x0pad=(-Npad:(N-1+Npad))*dx;
y0pad=(-Npad:(N-1+Npad))*dy;
[xpad,ypad]=meshgrid(x0pad,y0pad);
[vxext,vyext,vxextf,vyextf]=ec_extern(ecoulement,param_ecexterne,N,amp_ec,x,y); % Donne l'écoulement externe et sa TF en fonction des choix de simu.
source=exp(-((x-pi).^2+(y-pi).^2)/2/sig^2)/(2*pi*sig^2);% aire normalisée à 1


k =(2*pi/L)*[0:(N/2-1) (-N/2):-1]; % Wavenumber vector in either x or y
[kx,ky]=meshgrid(k,k); % Matrix of (x,y) Fourier wavenumbers
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);
% on definit le filtre dans l'espace de fourier
gfilt_f=source0_f/sum(sum(source));
vxfilt=real(ifft2((vxextf).*gfilt_f));
vyfilt=real(ifft2((vyextf).*gfilt_f));
vxfiltp=padarray(vxfilt,[10 10],'circular','both');
vyfiltp=padarray(vyfilt,[10 10],'circular','both');
xsm=modulo(mx,2*pi);
ysm=modulo(my,2*pi);
ufr=uxp-interp2(xpad,ypad,vxfiltp,xsm,ysm,'spline');
vfr=uyp-interp2(xpad,ypad,vyfiltp,xsm,ysm,'spline');

if param_ecexterne==1
    tanvx=amp_ec*sin(mx).*cos(my);
    tanvy=-amp_ec*cos(mx).*sin(my);
    normtan=sqrt(tanvx.^2+tanvy.^2);
    tanvx=tanvx./normtan;
    tanvy=tanvy./normtan;
end

prodscal=ufr.*tanvx+vfr.*tanvy;
figure;
plot(1:nt,prodscal);hold on;plot(1:nt,mx,'r');plot(1:nt,my,'k');
legend({'vm.t','x','y'},'Location','best')