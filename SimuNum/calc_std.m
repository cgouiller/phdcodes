load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'mxbg','mybg');
for factelarg=1%[1,10,100]%[1,3,10];
sigbbg=sqrt((2*pi)^2/(10000*pi));%sqrt(Dbg*dt)/2;
N=256;%Résolution de la grille de simu
chopvec=5; %On affiche une toutes les chopvec images

make_grid; %Initialise la grille de simu (N*N) et une variable utile pour gérer l'aliasing

%% Paramètres physiques invariables

alpha=2; %Coefficient de sublimation
sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
Dcamp=0.15;% Coeff de diffusion du camphre


% profil source de camphre (centré en pi), qui correspond à un nageur
source=exp(-((x-pi).^2+(y-pi).^2)/2/sigbbg^2)/(2*pi*sigbbg^2);% aire normalisée à 1
% on centre la source en (0,0), translation de -pi en x et y
source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);

nred=100;
Cstd=zeros(1,length(mxbg(:,1))/nred);
cpt=1;
for k=1:nred:length(mxbg(:,1))
    
    source_f=zeros(size(source0_f));
    for nn=1:bbg
        source_f=source_f+source0_f.*exp(-1i*mod(mxbg(k,nn),L)*kx-1i*mod(mybg(k,nn),L)*ky);
    end
    Cfield=real(ifft2(source_f));
    Cfieldligne=reshape(Cfield,[numel(Cfield),1]);
    Cstd(cpt)=std(Cfieldligne)/mean(mean(Cfield));
    cpt=cpt+1;
    
end
time=(1:length(Cstd))*nred*dt/(0.0985^2/0.15);
save(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_cstd',num2str(factelarg),'.mat'),'Cstd','time');
end
    