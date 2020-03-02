% fabrique la grille kx ky k

% Define grid and wavenumbers
dx=L/N;
dy=L/N;
x0=(0:(N-1))*dx; % gridx
y0=(0:(N-1))*dy; % gridy
[x,y]=meshgrid(x0,y0); % gridxy
Npad=10;
x0pad=(-Npad:(N-1+Npad))*dx;
y0pad=(-Npad:(N-1+Npad))*dy;
[xpad,ypad]=meshgrid(x0pad,y0pad);

k =(2*pi/L)*[0:(N/2-1) (-N/2):-1]; % Wavenumber vector in either x or y
[kx,ky]=meshgrid(k,k); % Matrix of (x,y) Fourier wavenumbers
%kmax=max(max(k));%sqrt((pi/dx)^2+(pi/dy)^2); % maximum wavenumbe
normk=sqrt((kx.^2+ky.^2));
kmax=max(max(normk));
alias=ones(size(kx));
w=zeros(size(normk));

for i=1:size(alias,1);
    for j=1:size(alias,2);
        if normk(i,j)<kmax/3 % 2*kmax/3 avant 0.33 mais c'est 2/3*N/2=N/3;
            alias(i,j)=1;
        else
            alias(i,j)=0;
        end
        
        if normk(i,j)<5
            w(i,j)=1;
        end
        
    end
end
clear normk k
w(1,1)=0;
%disp('makegrid');



