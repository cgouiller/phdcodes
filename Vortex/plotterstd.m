clear all;
close all;
run('E:\Clément\Mixing\Analyse\Stationnaires\varNumber\Matlab\manipsvarnumber.m');




N=[5,10,15,22,30,40,49,59];


%% Spectres directs
figure;
axes('XScale','log','YScale','log');
c=parula(256);
for numVid=1:nombreVid
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'SpectreDirectBL2std.mat'));

    hold on;
    plot(f,Sp,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
    hold off;

end


legend({'N=5','N=10','N=15','N=22','N=30','N=40','N=49','N=59',},'Location','northeast','Interpreter','latex')
xlabel('k [mm$^{-1}$]','Interpreter','latex')
ylabel('$|\mathrm{TF}(\frac{C-<C>}{C_{std}})|^2$','Interpreter','latex')
grid
xlim([7e-3 6])
ylim([1e-2 60])
saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\Spectra.fig'))
close;



%% Profils moyens longitudinaux
figure;
c=parula(256);
for numVid=1:nombreVid
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    
    load(strcat(directoryAnalyse,'long_profilstd'));
    %meanProf=smooth(meanProf(:));
    
    hold on;
    plot(x,proflong,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
    hold off;
end

grid
xlabel('x [mm]','Interpreter','latex')
ylabel('$\frac{C-<C>}{C_{std}}$','Interpreter','latex')
legend({'N=5','N=10','N=15','N=22','N=30','N=40','N=49','N=59',},'Location','northeast','Interpreter','latex')
%title('Mean longitudinal concentration profile')
saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\Long_profiles.fig'))
close;
%% Champ de concentration moyen autour du nageur
for numVid=1:nombreVid
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    
    directoryAnalyse=strcat(basePathAnalyse,sete,video);
    load(strcat(directoryAnalyse,'\meanTrailstd.mat'));
        
    figure;
    imagesc(calib*(1:length(immoy))-0.5*calib*length(immoy),calib*(1:length(immoy))-0.5*calib*length(immoy),immoy,[-1.5 1.5])
    hold on;
    colormap parula(256)
    colorbar
    title(strcat('N=',num2str(video),' swimmers'));
    axis equal
    xlim([-30 30])
    ylim([-60 30])
    xlabel('x [mm]','Interpreter','latex')
    ylabel('y [mm]','Interpreter','latex')
    annotation('textbox',...
    [0.73 0.4 0.3 0.15],...
    'String',{'$\frac{C-<C>}{C_{std}}$'},...
    'FontSize',45,...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontName','Times New Roman');
saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\',num2str(N(numVid)),'meanTrail.fig'))
    close;
end


%% Tracé de la position et la valeur du max du profil

N=[5,10,15,22,30,40,49,59];
posmaxl=[];
valmaxl=[];
for numVid=1:nombreVid
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'etude_profstd.mat'));
   posmaxl=[posmaxl,posmax];
    valmaxl=[valmaxl,valmax];
end
figure;
plot(N,posmaxl,'+','MarkerSize',15,'LineWidth',3)
grid
xlabel('Number of swimmers','Interpreter','latex')
ylabel('Max pos in front of swimmer [mm]','Interpreter','latex')
saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\MaxPos=f(N).fig'))
close;

figure;
plot(N,valmaxl,'+','MarkerSize',15,'LineWidth',3)
grid
xlabel('Number of swimmers','Interpreter','latex')
ylabel('Max value in front of swimmer [a.u.]','Interpreter','latex')
saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\MaxVal=f(N).fig'))
close;

%% Tracé de l'aire de la zone de déplétion

N=[5,10,15,22,30,40,49,59];
airel=[];
for numVid=1:nombreVid
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'aire_ellstd.mat'));
   airel=[airel,aire];
    
end
figure;
plot(N,airel,'+','MarkerSize',15,'LineWidth',3)
grid
xlabel('Number of swimmers','Interpreter','latex')
ylabel('Depletion area [mm$^2$]','Interpreter','latex')
saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\Area=f(N).fig'))
close;

figure;
plot(N,valmaxl,'+','MarkerSize',15,'LineWidth',3)
grid
xlabel('Number of swimmers','Interpreter','latex')
ylabel('Max value in front of swimmer [a.u.]','Interpreter','latex')
saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\MaxVal=f(N).fig'))
close;


%% Tracé de Rcc
figure('units','normalized','outerposition',[0 0 1 1])
c=parula(256);
for numVid=1:nombreVid
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video);
    load(strcat(directoryAnalyse,'\autocorrelationstd.mat'));
    
    
    hold on;
    plot(dX,Rcc,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
    hold off;

end
grid
xlabel('$\Delta$ x [mm]','Interpreter','latex')
ylabel('$<\frac{(C(x)-<C>)(C(x+\Delta x)-<C>)}{<(C-<C>)^2>}>$','Interpreter','latex')
legend({'N=5','N=10','N=15','N=22','N=30','N=40','N=49','N=59'},'Location','northeast','Interpreter','latex')
ylim([-0.4 1.1])
fig=gcf;
set(fig,'PaperPositionMode','auto')
%export_fig(gcf,strcat(basePathAnalyse,sete,'Cstd=f(t).pdf'))
saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\Rcc=f(dX).fig'))
close;

%% Tracé de Rccu
figure('units','normalized','outerposition',[0 0 1 1])
c=parula(256);
for numVid=1:nombreVid
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video);
    load(strcat(directoryAnalyse,'\Piv_corr.mat'));
    
    dX=(X(1,2)-X(1,1))*calib*1:length(Rccu);

    hold on;
    plot(dX,Rccv,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
    hold off;

end
grid
xlabel('$\Delta$ x [mm]','Interpreter','latex')
ylabel('$<\frac{(C(x)-<C>)(C(x+\Delta x)-<C>)}{<(C-<C>)^2>}>$','Interpreter','latex')
legend({'N=5','N=10','N=15','N=22','N=30','N=40','N=49','N=59'},'Location','northeast','Interpreter','latex')
ylim([-0.4 1.1])
fig=gcf;
set(fig,'PaperPositionMode','auto')
%export_fig(gcf,strcat(basePathAnalyse,sete,'Cstd=f(t).pdf'))
saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\Rcc=f(dX).fig'))
close;

%% Tracé des histogrammes de vitesse



for numVid=1:8
    
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,set,video,'\');
    load(strcat(directoryAnalyse,'trajectories.mat'));
    v=tracks(:,8);
    v=v(isnan(v)==0);
    [counts,bins] = hist_maison(v,0,70,201,1);
    figure;
    hold on;
    plot(bins,counts,'LineWidth',3);
    %plot(H_bubfree(:,1),H_bubfree(:,2),'r:','LineWidth',3);
    
    hold off;
    
    xlim([0 70])
    xlabel('v [mm.s$^{-1}$]','Interpreter','latex')
    ylabel('PDF','Interpreter','latex')
    title(strcat('N=',videoCatalogue(numVid)))
    
end

    
  
    %saveas(gcf,strcat(basePathAnalyse,date,set,'\','PDFvitcompavecbubsamp'),'jpg')
    
%% Tracé de vitesses moyennes en fct du nb de nageurs
N=[5,10,15,22,30,40,49,59];
figure;

for numVid=1:8
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,set,video,'\');
    
    load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
    
   
    v=sample(:,8);
 
  

hold on;
plot(N(numVid),mean(v),'+','MarkerSize',4);
errorbar(N(numVid),mean(v),std(v),'r','LineWidth',3);
hold off;
    
    
    
end

grid
xlabel('Number of swimmers','Interpreter','latex')
ylabel('Mean velocity [mm.s$^{-1}$]','Interpreter','latex')

%saveas(gcf,strcat(basePathAnalyse,date,set,video,'\','PDFvitcompavecsansbub'),'jpg')



%% Histogrammes d'intensités
figure;
axes('YScale','log');

for numVid=1:nombreVid
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'histog_intstd.mat'));

hold on;
    plot(xcountx,countsax,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
hold off;
end
legend(strcat('N= ',videoCatalogue(1:nombreVid)));
grid
xlabel('grad(C)_x')
ylabel('PDF')
saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\hist_gradx.fig'))
close;
% xlim([-0.6 0.6])

figure;
axes('YScale','log');
for numVid=1:nombreVid
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'histog_intstd.mat'));

hold on;
    plot(xcounty,countsay,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
% errorbar(x(2:length(x)),countscf(i,2:length(x)),countstdcf(2:length(x)))
hold off;
end

legend(strcat('N= ',videoCatalogue(1:nombreVid)));

grid
xlabel('grad(C)_y')
ylabel('PDF')
saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\hist_grady.fig'))
close;
% xlim([-0.6 0.6])

figure;
for numVid=1:nombreVid
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'histog_intstd.mat'));

hold on;
    plot(xcountcf,countscf,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
hold off;
end
grid
legend(strcat('N= ',videoCatalogue(1:nombreVid)));
xlabel('$\frac{C-<C>}{C_{std}}$','Interpreter','latex')
ylabel('PDF')
xlim([-4 4])
saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\hist_Cfieldcor.fig'))
close;

%% Moment d'ordre 3 + et -


for numVid=1:nombreVid
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'histog_intstd.mat'));
    counts=(countsax+countsay)/2;
    x3PDFpos=counts(ceil(length(counts)/2)+1:length(counts)).*(xcountx(ceil(length(counts)/2)+1:length(counts)).^3);
    x3PDFneg=counts(1:ceil(length(counts)/2)-1).*(xcountx(1:ceil(length(counts)/2)-1).^3);

    for i=1:length(x3PDFpos)
        mom3pos(i)=sum(x3PDFpos(1:i));
        mom3neg(i)=-sum(x3PDFneg(length(x3PDFneg)+1-i:length(x3PDFneg)));
    end
    figure;
    hold on;
    plot(xcountx(ceil(length(counts)/2)+1:length(counts)),mom3pos,'r','LineWidth',3);
    plot(xcountx(ceil(length(counts)/2)+1:length(counts)),mom3neg,'b','LineWidth',3);
    hold off;
    legend('Positif','Negatif');
    grid
    xlabel('grad(C)','Interpreter','latex')
    ylabel('$\int x^3PDF$','Interpreter','latex')
    saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\sumx3pdf',video,'.fig'))

    figure;
    plot(xcountx,counts.*xcountx.^3,'LineWidth',3)
     grid
    xlabel('grad(C)','Interpreter','latex')
    ylabel('$x^3PDF$','Interpreter','latex')
    saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\x3pdf',video,'.fig'))

end
%% Moment d'ordre 3 en fonction de N


for numVid=1:nombreVid
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'histog_intstd.mat'));
    counts=(countsax+countsay)/2;
    x3PDFpos=counts(ceil(length(counts)/2)+1:length(counts)).*(xcountx(ceil(length(counts)/2)+1:length(counts)).^3);
    x3PDFneg=counts(1:ceil(length(counts)/2)-1).*(xcountx(1:ceil(length(counts)/2)-1).^3);

    for i=1:length(x3PDFpos)
        mom3pos(i)=sum(x3PDFpos(1:i));
        mom3neg(i)=-sum(x3PDFneg(length(x3PDFneg)+1-i:length(x3PDFneg)));
    end
    
    hold on;
    plot(xcountx(ceil(length(counts)/2)+1:length(counts)),(mom3pos+mom3neg)/2,'Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
    hold off;
    


end
legend(strcat('N= ',videoCatalogue(1:nombreVid)),'Location','southeast');
ylim([0 1.1])
grid
    xlabel('grad(C)','Interpreter','latex')
    ylabel('$\int x^3PDF$','Interpreter','latex')
        saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\sumx3pdf=f(N).fig'))

%% Moment d'ordre 4 + et -


for numVid=1:nombreVid
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'histog_intstd.mat'));
    counts=(countsax+countsay)/2;
    x4PDFpos=counts(ceil(length(counts)/2)+1:length(counts)).*(xcountx(ceil(length(counts)/2)+1:length(counts)).^4);
    x4PDFneg=counts(1:ceil(length(counts)/2)-1).*(xcountx(1:ceil(length(counts)/2)-1).^4);

    for i=1:length(x4PDFpos)
        mom4pos(i)=sum(x4PDFpos(1:i));
        mom4neg(i)=sum(x4PDFneg(length(x4PDFneg)+1-i:length(x4PDFneg)));
    end
    figure;
    hold on;
    plot(xcountx(ceil(length(counts)/2)+1:length(counts)),mom4pos,'r','LineWidth',3);
    plot(xcountx(ceil(length(counts)/2)+1:length(counts)),mom4neg,'b','LineWidth',3);
    hold off;
    legend('Positif','Negatif');
    grid
    xlabel('grad(C)','Interpreter','latex')
    ylabel('$\int x^4PDF$','Interpreter','latex')
    saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\sumx4pdf',video,'.fig'))

    figure;
    plot(xcountx,counts.*xcountx.^4,'LineWidth',3)
     grid
    xlabel('grad(C)','Interpreter','latex')
    ylabel('$x^4PDF$','Interpreter','latex')
    saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\x4pdf',video,'.fig'))

end

%% Moment d'ordre 4 en fonction de N


for numVid=1:nombreVid
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
    load(strcat(directoryAnalyse,'histog_intstd.mat'));
    counts=(countsax+countsay)/2;
    x4PDFpos=counts(ceil(length(counts)/2)+1:length(counts)).*(xcountx(ceil(length(counts)/2)+1:length(counts)).^4);
    x4PDFneg=counts(1:ceil(length(counts)/2)-1).*(xcountx(1:ceil(length(counts)/2)-1).^4);

    for i=1:length(x4PDFpos)
        mom4pos(i)=sum(x4PDFpos(1:i));
        mom4neg(i)=-sum(x4PDFneg(length(x4PDFneg)+1-i:length(x4PDFneg)));
    end
    
    hold on;
    plot(xcountx(ceil(length(counts)/2)+1:length(counts)),(mom4pos-mom4neg)/2,'Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
    hold off;
    


end
legend(strcat('N= ',videoCatalogue(1:nombreVid)),'Location','southeast');
%ylim([-0.05 0.1])
grid
    xlabel('grad(C)','Interpreter','latex')
    ylabel('$\int x^4PDF$','Interpreter','latex')
        saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\sumx4pdf=f(N).fig'))

%% Déterminer la longueur caract des corrélations

L_s50=zeros(1,11);
for numVid=2:11
    
    
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,set,video,'\processed\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    load(strcat(directoryAnalyse,'RccSp_final.mat'));
    k=1;
    while RcccorS(k)>0.5
        k=k+1;
    end
    L_s50(numVid)=dX(1,k);
    
    
end

%% PIV results
for numVid=2:11
    
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVidProcessed,date,sete,video,'\processed\');
    directoryAnalyse=strcat(basePathAnalyse,date,sete,video,'\');
    load(strcat(directoryAnalyse,'PIV_means.mat'));
    vitnorm=sqrt(Umoy.*Umoy+Vmoy.*Vmoy);
figure;
quiverC2D(X,Y,Umoy,Vmoy)
 cmap = colormap(jet(256)) ; %Create Colormap
 cbh = colorbar ; %Create Colorbar
 
%  set(cbh,'YTickLabel',round(linspace(51.2,256,5))./256*40)
title(videoCatalogue(numVid))
xlabel('Direction transverse [mm]')
ylabel('Direction du mouvement [mm]')
end


%%
legend(videoCatalogue(2:11));
title('histogramme de Cfield')
grid
xlabel('C')
ylabel('PDF')
xlim([-0.6 0.6])


%% Energie cinétique en fonction du temps
clear all;
run manips180913;


temps=[];
Ec=[];
Ecstd=[];
for numVid=1:14
    
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    load(strcat(directoryAnalyse,'trail.mat'));
    for i=2:length(tracks(:,1))
        if tracks(i,4)==tracks(i-1,4) && tracks(i-1,3)+1==tracks(i,3)
            tracks(i,9)=(tracks(i,1)-tracks(i-1,1))*fps;
            tracks(i,10)=(tracks(i,2)-tracks(i-1,2))*fps;
            tracks(i,11)=sqrt(tracks(i,9)*tracks(i,9)+tracks(i,10)*tracks(i,10));
                       
        end
    end
    if numVid==1
        deb1=5*60*20;
        fin1=5*60*20+1000;
        deb2=10*60*20;
        fin2=10*60*20+1000;
        tracks1=tracks(tracks(:,3)>deb1,:);
        tracks1=tracks1(tracks1(:,3)<fin1,:);
        tracks2=tracks(tracks(:,3)>deb2,:);
        tracks2=tracks2(tracks2(:,3)<fin2,:);
        temps=[temps,5*60+500/20,10*60+500/20];
        Ec=[Ec,mean(tracks1(:,11).^2),mean(tracks2(:,11).^2)];
        Ecstd=[Ecstd,std(tracks1(:,11).^2),std(tracks2(:,11).^2)];
    end
    if numVid>1
        deb=1;
        fin=1000;
        tracks=tracks(tracks(:,3)>deb,:);
        tracks=tracks(tracks(:,3)<fin,:);
        temps=[temps,str2num(video)*60+500/20];
        Ec=[Ec,mean(tracks(:,11).^2)];
        Ecstd=[Ecstd,std(tracks(:,11).^2)];
    end
    
    
    
    
end

    figure;
    errorbar(temps,Ec,Ecstd,'LineWidth',3)
    xlabel('temps [s]','Interpreter','latex')
    ylabel('\''Energie cin\''etique moyenne','Interpreter','latex')
   
grid
    
%%
axes('XScale','log','YScale','log');

for numVid=2:11
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,set,video,'\processed\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    directoryPiv=strcat(basePathAnalyse,date,set,video,'\PIV_fullimg\');
    clear SpMeanU;
    load(strcat(directoryPiv,'PIV_SpectreDirect_interp.mat'));


    hold on;
    color_line(fDirectU,SpMeanU,ones(1,length(fDirectU)).*(numVid-1),'LineWidth',3);
    

    hold off;

end
%legend(['5','10',videoCatalogue(2:14)]);
legend(videoCatalogue(2:11));
xlabel('Fréquence [mm^{-1}]')
ylabel('Densité de puissance')