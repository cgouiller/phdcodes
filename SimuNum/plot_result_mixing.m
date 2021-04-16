%% Graphs
run manips
run defaultfig
% for i=1:8
%     figure;
%     %load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd1.mat'))
%     %plot(Cstd,'b')
%     hold on;
%     load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd3.mat'))
%     plot(Cstd,'r')
%     %load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd10.mat'))
%     %plot(Cstd,'k')
%     %legend({'1','3','10'})
%     xlabel('temps')
%     ylabel('Cstd/<C>_{spat}')
% end
% for i=1:6
%     figure;
%     %load(strcat('E:\Clément\SimuNum\Resultats\210408\mixd\0',num2str(i),'_cstd1.mat'))
%     %plot(Cstd,'b')
%     hold on;
%     load(strcat('E:\Clément\SimuNum\Resultats\210408\mixd\0',num2str(i),'_cstd3.mat'))
%     plot(Cstd,'r')
%     %load(strcat('E:\Clément\SimuNum\Resultats\210408\mixd\0',num2str(i),'_cstd10.mat'))
%     %plot(Cstd,'k')
%     %legend({'1','3','10'})
%     xlabel('temps')
%     ylabel('Cstd/<C>_{spat}')
% end
nlist=[30,7,70,100,150,1,15,45,3,5,10,12,20,25];
unlist=[];
troislist=[];
dixlist=[];
unlister=[];
troislister=[];
dixlister=[];
figure;
for i=1:8
    load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd1.mat'))
    unlist=[unlist,mean(Cstd(200:end))];
    unlister=[unlister,std(Cstd(200:end))/sqrt(length(Cstd(200:end)))];
    load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd3.mat'))
    troislist=[troislist,mean(Cstd(200:end))];
    troislister=[troislister,std(Cstd(200:end))/sqrt(length(Cstd(200:end)))];
    load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd10.mat'))
    dixlist=[dixlist,mean(Cstd(200:end))];
    dixlister=[dixlister,std(Cstd(200:end))/sqrt(length(Cstd(200:end)))];
    
end
for i=1:6
%     load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd1.mat'))
%     unlist=[unlist,mean(Cstd(200:end))];
%     unlister=[unlister,std(Cstd(200:end))/sqrt(length(Cstd(200:end)))];
    load(strcat('E:\Clément\SimuNum\Resultats\210408\mixd\0',num2str(i),'_cstd3.mat'))
    troislist=[troislist,mean(Cstd(20:end))];%200
    troislister=[troislister,std(Cstd(20:end))/sqrt(length(Cstd(20:end)))];%200
%     load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd10.mat'))
%     dixlist=[dixlist,mean(Cstd(200:end))];
%     dixlister=[dixlister,std(Cstd(200:end))/sqrt(length(Cstd(200:end)))];
    
end
%errorbar(nlist,unlist,unlister,'+b','MarkerSize',12)
hold on;
errorbar(nlist,troislist,troislister,'or','MarkerSize',12)
%errorbar(nlist,dixlist,dixlister,'xk','MarkerSize',12)
%legend({'1','3','10'})
ylim([0,3])
xlim([0,155])
xlabel('Nombre de nageurs')
ylabel('<Cstd/<C>>')


coll=['b','r','k','g',':','c','m','y'];
figure;hold on;
D=zeros(1,length(coll));
for i=[6,2,7,1,8,3,4,5]
    load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_msd.mat'))
  plot(tau,MeanSD,coll(i))
  p=polyfit(tau(tau>3),MeanSD(tau>3),1);
  D(i)=p(1);
end
for i=[1,2,3,4,5,6]
    load(strcat('E:\Clément\SimuNum\Resultats\210408\mixd\0',num2str(i),'_msd.mat'))
  p=polyfit(tau(tau>3),MeanSD(tau>3),1);
  D(i+8)=p(1);
end
legend({'1','7','15','30','45','70','100','150'});
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
plot([2*10^0,2*10^1],[0.3,3],'--k')
ylabel('MSD')
xlabel('Delta t')
grid;
figure;plot(nlist,D,'+');hold on;plot([0,150],[0.015,0.015],':k')
xlabel('Nombre de nageurs')
ylabel('Coef de diffusion temps long des bbg')
% %% Images et champs typiques
% ii=591;
% run manips;
% bbg=manipCat.bbg(ii);
% taup=manipCat.taup(ii);
% inertie=manipCat.inertie(ii);
% amp_ec=manipCat.amp_ec(ii);
% npart=manipCat.npart(ii);
% A=manipCat.A(ii);
% nt=manipCat.nt(ii);
% rdomstart=manipCat.randomstart(ii);
% dt=manipCat.dt(ii);
% satur=manipCat.satur(ii);
% theta=manipCat.theta(ii);
% delai=manipCat.delai(ii);
% L=manipCat.L(ii);
% ecoulement=1;
% marangoni=1;
% if amp_ec==0
%     ecoulement=0;
% end
% if A==0
%     marangoni=0;
% end
% Dbg=manipCat.Dbg(ii);
% 
% Dnag=5; %En mm, le diamètre des nageurs voulus
% asrc=manipCat.asrc(ii); % Amplitude du flux de camphre libéré
% advection=1; %1 si avec advection, 0 si non
% 
% 
% param_ecexterne=manipCat.paramec(ii);
% load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
% figure;
% plot(mod(mxbg(end,:),2*pi),mod(mybg(end,:),2*pi),'+')
% for factelarg=[1,3,10];
%     sigbbg=factelarg*sqrt(Dbg*dt);
%     N=round(64/pi*L);%Résolution de la grille de simu
%     chopvec=5; %On affiche une toutes les chopvec images
%     
%     make_grid; %Initialise la grille de simu (N*N) et une variable utile pour gérer l'aliasing
%     
%     %% Paramètres physiques invariables
%     
%     alpha=2; %Coefficient de sublimation
%     sig=sqrt(4*pi*(Dnag/2)^2/(90)^2); %Calcule la largeur de gaussienne associée au diamètre des nageurs
%     Dcamp=0.15;% Coeff de diffusion du camphre
%     
%     
%     % profil source de camphre (centré en pi), qui correspond à un nageur
%     source=exp(-((x-pi).^2+(y-pi).^2)/2/sigbbg^2)/(2*pi*sigbbg^2);% aire normalisée à 1
%     % on centre la source en (0,0), translation de -pi en x et y
%     source0_f=fft2(source).*exp(1i*pi*kx+1i*pi*ky);
%     
%     % on definit le filtre dans l'espace de fourier
%     gfilt_f=source0_f/sum(sum(source));
%     
%     k=length(mxbg(:,1));
%     
%     source_f=zeros(size(source0_f));
%     for nn=1:bbg
%         source_f=source_f+source0_f.*exp(-1i*mxbg(k,nn)*kx-1i*mybg(k,nn)*ky);
%     end
%     Cfield=real(ifft2(source_f));
%     figure;
%     imagesc(Cfield)
%     title(num2str(factelarg))
%     
% end
% %% Champs de conc moyen
% N=128;
% n=2;
% [X,Y]=meshgrid(1:N,1:N);
% 
% X=X-mean(mean(X));
% Y=Y-mean(mean(Y));
% for ii=591:nombreVid
%     if sum(manipCat.set{ii}=='mixd')==4 && exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_meanTrail.mat'))
%         figure;
%         npart=manipCat.npart(ii);
%         load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_meanTrail.mat'))
%         imagesc(immoy(40:88,1:84),[0,900]);axis equal;
%         hold on;plot(64,25,'+w')
%         title(num2str(npart))
%     end
% end
% 

