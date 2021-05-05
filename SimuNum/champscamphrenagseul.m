% L=2*pi;
% N=128;
% 
% dx=L/N;
% dy=L/N;
% x0=(0:(N-1))*dx; % gridx
% y0=(0:(N-1))*dy; % gridy
% [x,y]=meshgrid(x0,y0);
% Npad=10;
% x0pad=(-Npad:(N-1+Npad))*dx;
% y0pad=(-Npad:(N-1+Npad))*dy;
% [xpad,ypad]=meshgrid(x0pad,y0pad);
% 
% k =(2*pi/L)*[0:(N/2-1) (-N/2):-1]; % Wavenumber vector in either x or y
% [kx,ky]=meshgrid(k,k); % Matrix of (x,y) Fourier wavenumbers
% load('E:\Clément\SimuNum\Resultats\201119\vita\07.mat')
% Ccampbase=real(ifft2(Ccamp_f.*exp(1i*(mx(end)+pi)*kx+1i*(my(end)+pi)*ky)));
% s=length(Ccampbase);
% theta=atan(mvsy(end)/mvsx(end));
% 
% [X,Y]=meshgrid(1:size(Ccampbase,2),1:size(Ccampbase,1));
% pts=zeros(length(X).^2,2);
% ptsf=zeros(length(X).^2,2);
% pts(:,1)=X(:)-65;
% pts(:,2)=Y(:)-65;
% R=[cos(theta), sin(theta);-sin(theta) cos(theta)];
% v=[s/2-65, s/2-65];
% 
% tt=v*R;
% pts2=pts*R;
% pts2(:,1)=pts2(:,1)+65;
% pts2(:,2)=pts2(:,2)+65;
% 
% ptsf(:,1)=pts2(:,2)-tt(2);
% ptsf(:,2)=pts2(:,1)-tt(1);
% 
% [Cfield,count]=bilinear_clement(Ccampbase,ptsf);
% 
% save('E:\Clément\MyCore\Analyse\SimuNum\Vortex\campnagseul48.mat','Cfield','x','y')
% 
% load('E:\Clément\SimuNum\Resultats\201127\vara\02.mat')
% L=2*pi;
% N=128;
% 
% dx=L/N;
% dy=L/N;
% x0=(0:(N-1))*dx; % gridx
% y0=(0:(N-1))*dy; % gridy
% [x,y]=meshgrid(x0,y0);
% Npad=10;
% x0pad=(-Npad:(N-1+Npad))*dx;
% y0pad=(-Npad:(N-1+Npad))*dy;
% [xpad,ypad]=meshgrid(x0pad,y0pad);
% 
% k =(2*pi/L)*[0:(N/2-1) (-N/2):-1]; % Wavenumber vector in either x or y
% [kx,ky]=meshgrid(k,k); % Matrix of (x,y) Fourier wavenumbers
% load('E:\Clément\SimuNum\Resultats\210108\vita\02.mat')
% Ccampbase=real(ifft2(Ccamp_f.*exp(1i*(mx(end)+pi)*kx+1i*(my(end)+pi)*ky)));
% s=length(Ccampbase);
% theta=atan(mvsy(end)/mvsx(end));
% 
% [X,Y]=meshgrid(1:size(Ccampbase,2),1:size(Ccampbase,1));
% pts=zeros(length(X).^2,2);
% ptsf=zeros(length(X).^2,2);
% pts(:,1)=X(:)-65;
% pts(:,2)=Y(:)-65;
% R=[cos(theta), sin(theta);-sin(theta) cos(theta)];
% v=[s/2-65, s/2-65];
% 
% tt=v*R;
% pts2=pts*R;
% pts2(:,1)=pts2(:,1)+65;
% pts2(:,2)=pts2(:,2)+65;
% 
% ptsf(:,1)=pts2(:,2)-tt(2);
% ptsf(:,2)=pts2(:,1)-tt(1);
% 
% [Cfield,count]=bilinear_clement(Ccampbase,ptsf);
% 
% save('E:\Clément\MyCore\Analyse\SimuNum\Vortex\campnagseul05.mat','Cfield','x','y')

%% 210223
L=2*pi;
N=128;

dx=L/N;
dy=L/N;
x0=(0:(N-1))*dx; % gridx
y0=(0:(N-1))*dy; % gridy
[x,y]=meshgrid(x0,y0);
Npad=10;
x0pad=(-Npad:(N-1+Npad))*dx;
y0pad=(-Npad:(N-1+Npad))*dy;
[xpad,ypad]=meshgrid(x0pad,y0pad);

k =(2*pi/L)*[0:(N/2-1) (-N/2):-1]; % Wavenumber vector in either x or y
[kx,ky]=meshgrid(k,k); % Matrix of (x,y) Fourier wavenumbers
load('E:\Clément\SimuNum\Resultats\201119\vita\01.mat')
Ccampbase=real(ifft2(Ccamp_f.*exp(1i*(mx(end)+pi)*kx+1i*(my(end)+pi)*ky)));
s=length(Ccampbase);
theta=atan(mvsy(end)/mvsx(end))-pi/2;

[X,Y]=meshgrid(1:size(Ccampbase,2),1:size(Ccampbase,1));
pts=zeros(length(X).^2,2);
ptsf=zeros(length(X).^2,2);
pts(:,1)=X(:)-65;
pts(:,2)=Y(:)-65;
R=[cos(theta), sin(theta);-sin(theta) cos(theta)];
v=[s/2-65, s/2-65];

tt=v*R;
pts2=pts*R;
pts2(:,1)=pts2(:,1)+65;
pts2(:,2)=pts2(:,2)+65;

ptsf(:,1)=pts2(:,2)-tt(2);
ptsf(:,2)=pts2(:,1)-tt(1);

[Cfield,count]=bilinear_clement(Ccampbase,ptsf);

save('E:\Clément\MyCore\Analyse\SimuNum\Vortex\35.mat','Cfield','x','y')

L=2*pi;
N=128;

dx=L/N;
dy=L/N;
x0=(0:(N-1))*dx; % gridx
y0=(0:(N-1))*dy; % gridy
[x,y]=meshgrid(x0,y0);
Npad=10;
x0pad=(-Npad:(N-1+Npad))*dx;
y0pad=(-Npad:(N-1+Npad))*dy;
[xpad,ypad]=meshgrid(x0pad,y0pad);

k =(2*pi/L)*[0:(N/2-1) (-N/2):-1]; % Wavenumber vector in either x or y
[kx,ky]=meshgrid(k,k); % Matrix of (x,y) Fourier wavenumbers
load('E:\Clément\SimuNum\Resultats\210108\vita\11.mat')
Ccampbase=real(ifft2(Ccamp_f.*exp(1i*(mx(end)+pi)*kx+1i*(my(end)+pi)*ky)));
s=length(Ccampbase);
theta=atan(mvsy(end)/mvsx(end))-pi/2;

[X,Y]=meshgrid(1:size(Ccampbase,2),1:size(Ccampbase,1));
pts=zeros(length(X).^2,2);
ptsf=zeros(length(X).^2,2);
pts(:,1)=X(:)-65;
pts(:,2)=Y(:)-65;
R=[cos(theta), sin(theta);-sin(theta) cos(theta)];
v=[s/2-65, s/2-65];

tt=v*R;
pts2=pts*R;
pts2(:,1)=pts2(:,1)+65;
pts2(:,2)=pts2(:,2)+65;

ptsf(:,1)=pts2(:,2)-tt(2);
ptsf(:,2)=pts2(:,1)-tt(1);

[Cfield,count]=bilinear_clement(Ccampbase,ptsf);

save('E:\Clément\MyCore\Analyse\SimuNum\Vortex\165.mat','Cfield','x','y')

L=2*pi;
N=128;

dx=L/N;
dy=L/N;
x0=(0:(N-1))*dx; % gridx
y0=(0:(N-1))*dy; % gridy
[x,y]=meshgrid(x0,y0);
Npad=10;
x0pad=(-Npad:(N-1+Npad))*dx;
y0pad=(-Npad:(N-1+Npad))*dy;
[xpad,ypad]=meshgrid(x0pad,y0pad);

k =(2*pi/L)*[0:(N/2-1) (-N/2):-1]; % Wavenumber vector in either x or y
[kx,ky]=meshgrid(k,k); % Matrix of (x,y) Fourier wavenumbers
load('E:\Clément\SimuNum\Resultats\201119\vita\03.mat')
Ccampbase=real(ifft2(Ccamp_f.*exp(1i*(mx(end)+pi)*kx+1i*(my(end)+pi)*ky)));
s=length(Ccampbase);
theta=atan(mvsy(end)/mvsx(end))-pi/2;

[X,Y]=meshgrid(1:size(Ccampbase,2),1:size(Ccampbase,1));
pts=zeros(length(X).^2,2);
ptsf=zeros(length(X).^2,2);
pts(:,1)=X(:)-65;
pts(:,2)=Y(:)-65;
R=[cos(theta), sin(theta);-sin(theta) cos(theta)];
v=[s/2-65, s/2-65];

tt=v*R;
pts2=pts*R;
pts2(:,1)=pts2(:,1)+65;
pts2(:,2)=pts2(:,2)+65;

ptsf(:,1)=pts2(:,2)-tt(2);
ptsf(:,2)=pts2(:,1)-tt(1);

[Cfield,count]=bilinear_clement(Ccampbase,ptsf);

save('E:\Clément\MyCore\Analyse\SimuNum\Vortex\37.mat','Cfield','x','y')


L=2*pi;
N=128;

dx=L/N;
dy=L/N;
x0=(0:(N-1))*dx; % gridx
y0=(0:(N-1))*dy; % gridy
[x,y]=meshgrid(x0,y0);
Npad=10;
x0pad=(-Npad:(N-1+Npad))*dx;
y0pad=(-Npad:(N-1+Npad))*dy;
[xpad,ypad]=meshgrid(x0pad,y0pad);

k =(2*pi/L)*[0:(N/2-1) (-N/2):-1]; % Wavenumber vector in either x or y
[kx,ky]=meshgrid(k,k); % Matrix of (x,y) Fourier wavenumbers
load('E:\Clément\SimuNum\Resultats\210108\vita\07.mat')
Ccampbase=real(ifft2(Ccamp_f.*exp(1i*(mx(end)+pi)*kx+1i*(my(end)+pi)*ky)));
s=length(Ccampbase);
theta=atan(mvsy(end)/mvsx(end))-pi/2;

[X,Y]=meshgrid(1:size(Ccampbase,2),1:size(Ccampbase,1));
pts=zeros(length(X).^2,2);
ptsf=zeros(length(X).^2,2);
pts(:,1)=X(:)-65;
pts(:,2)=Y(:)-65;
R=[cos(theta), sin(theta);-sin(theta) cos(theta)];
v=[s/2-65, s/2-65];

tt=v*R;
pts2=pts*R;
pts2(:,1)=pts2(:,1)+65;
pts2(:,2)=pts2(:,2)+65;

ptsf(:,1)=pts2(:,2)-tt(2);
ptsf(:,2)=pts2(:,1)-tt(1);

[Cfield,count]=bilinear_clement(Ccampbase,ptsf);

save('E:\Clément\MyCore\Analyse\SimuNum\Vortex\161.mat','Cfield','x','y')


