%% Ordres de grandeur pour comparer la compressibilité obtenue par des champs de vitesse de la littérature (surfactant soluble, insoluble...) et l'expérience


%% Cas mécanique
R_nag=2.5e-3;
V_nag=60e-3;
x=(-5:0.01:5)*0.01; %de -5 à 5 cm
[X,Y]=meshgrid(x,x);
R=sqrt(X.^2+Y.^2);
T=atan(Y./X);
T(X<0)=T(X<0)+pi;
T=T-pi/2;

compr=zeros(size(R));
compr(R<R_nag)=NaN;

compr(isfinite(compr))=V_nag*2/(3*pi)*cos(T(isfinite(compr))).*(-(3*sqrt(1-R_nag^2./R(isfinite(compr)).^2))./(R(isfinite(compr)).^2/R_nag^2-1)+R_nag./(R(isfinite(compr)).*sqrt(R(isfinite(compr)).^2/R_nag^2-1)));
imagesc(x*100,x*100,compr,[-0.005 0.005]);colormap parula(256);colorbar;
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);
xlabel('X [cm]')
ylabel('Y [cm]')
axis equal

%% Cas chimique en 1/r
compr(isfinite(compr))=zeros(size(R);
%% cas chimique en r^-3/5
x=(-5:0.01:5); %en cm
[X,Y]=meshgrid(x,x);
R=sqrt(X.^2+Y.^2);


compr=zeros(size(R));
compr(R<0.25)=NaN;

compr(isfinite(compr))=(5*0.25^0.6)*0.4.*R(isfinite(compr)).^(-8/5);
imagesc(x,x,compr);colormap parula(256);colorbar;

xlim([-1.5 1.5]);
ylim([-1.5 1.5]);
xlabel('X [cm]')
ylabel('Y [cm]')
axis equal




