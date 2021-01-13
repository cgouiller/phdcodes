load('E:\Clément\SimuNum\Resultats\201112\vita\02.mat')
Ccampbase=real(ifft2(Ccamp_f.*exp(1i*(xsref-pi)*kx+1i*(ysref-pi)*ky)));
s=length(Ccampbase);
theta=atan(vsy/vsx);

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

[Ccamprefdroit,count]=bilinear_clement(Ccampbase,ptsf);

Ccamprefsym=zeros(128,128);
for i=1:64
    for j=1:128
        Ccamprefsym(i,j)=(Ccamprefdroit(i,j)+Ccamprefdroit(128-i,j))/2;
        Ccamprefsym(128-i,j)=(Ccamprefdroit(i,j)+Ccamprefdroit(128-i,j))/2;
    end
end
Ccampref=Ccamprefsym;
save('E:\Clément\MyCore\Analyse\SimuNum\Vortex\Cfieldmarang1.mat','Ccampref')