clear all;
close all;
run('E:\Clément\Mixing\Matlab\manipsfinales.m');


%% Tracé de CMoy
massCat=[];
CMoyCat=[];
CMoyEt=[];
c=parula(256);
%figure;
list=[1:3,5,7,8,10:16,29:31];%[varR,varRold];
XCat=MCat(list);
for i=1:length(list)
    numVid=list(i);
    %determine the current video/set/parameters
    load_param;
    
            load(strcat(directoryAnalyse,'Conclin.mat'));

time=time(CMoy~=0);
CMoy=CMoy(CMoy~=0);
   
    if numVid==29
         CMoyCat=[CMoyCat,mean(CMoy)];
        CMoyEt=[CMoyEt,std(CMoy)];
    else
        CMoyCat=[CMoyCat,mean(CMoy(time>55*60&time<65*60))];
        CMoyEt=[CMoyEt,std(CMoy(time>55*60&time<65*60))];
    end
    
end

errorbar(XCat,CMoyCat,CMoyEt,'LineStyle','none')
xlabel('Poured glass bubbles mass [g]')
hold on;
plot(XCat,CMoyCat,'+b','LineWidth',3,'MarkerSize',15)
% plot(XCat(1:21),CMoyCat(1:21),'+k','LineWidth',3,'MarkerSize',15)
% plot(XCat(22:28),CMoyCat(22:28),'+r','LineWidth',3,'MarkerSize',15)
ylabel('<C> [a.u.]')
xlim([0 85])
ylim([-0.005 0.045])
%plot(XCat(8:9),CMoyCat(8:9),'+r','LineWidth',3,'MarkerSize',10)

%plot(XCat,CMoyMT(list),'+r','LineWidth',3,'MarkerSize',10)


% xlim([0 90])

% %% Tracé de CMoypos/neg
% massCat=[];
% CMoyCat=[];
% CMoyEt=[];
% 
% %figure;
% list=varN;
% XCat=NCat(list);
% for i=1:length(list)
%     numVid=list(i);
%     %determine the current video/set/parameters
%     load_param;
%     load(strcat(directoryAnalyse,'ConcBLtest.mat'));
%     if numVid~=29
%         CMoyCat=[CMoyCat,mean(CMoypos(CMoypos~=0&time>55*60&time<65*60))];
%         CMoyEt=[CMoyEt,std(CMoypos(CMoypos~=0&time>55*60&time<65*60))];
%     else
%         CMoyCat=[CMoyCat,mean(CMoypos~=0&CMoypos)];
%         CMoyEt=[CMoyEt,std(CMoypos~=0&CMoypos)];
%     end
%     %     figure;
%     %     grid
%     %     xlabel('temps [s]','Interpreter','latex')
%     %     ylabel('<C> [u.a.]','Interpreter','latex')
%     %    plot(time,CMoy,'+')
%     %     title(strjoin(massCatalogue(numVid)))
%     %    ylim([0 0.12])
%     
% end
% 
% errorbar(XCat,CMoyCat,CMoyEt,'LineStyle','none')
% xlabel('M')
% hold on;
% plot(XCat,CMoyCat,'+k','LineWidth',3,'MarkerSize',10)
% 
% ylabel('<C> val neg')



%% Tracé de Cstd


CstdCat=[];
CstdCatMod=[];
CstdEt=[];

 list=varRold;
%list=[34:54,varRold];
 XCat=RCat(list);

% xlist=1:20:1340;
%     ylist=xlist;

for i=1:length(list)
    
    %numVid=list(i);
    numVid=list(i);
    %determine the current video/set/parameters
    load_param;
   % Lbg=dir(strcat(directoryBg,format));
% a typical image to get its size
% 
%    
% vals1=[];
% 
% imbg=load(strcat(directoryAnalyse,'im0'));
% imbg=imbg.im0;
% 
% immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));
%loop over the images of the background
% for k=1:length(Lbg)
%     %get the current image
%     fname=Lbg(k).name;
%     fnamecompl=strcat(directoryBg,fname);
%     im=double(imread(fnamecompl));
%     im=im(round(centerCellYBg-radiusCellPxBg):round(centerCellYBg+radiusCellPxBg),round(centerCellXBg-radiusCellPxBg):round(centerCellXBg+radiusCellPxBg));
%       im=(im)./imbg;
%       Cfield=real(-nanlog(im));
%       Cfield=immask.*Cfield;
%       sizecf=length(Cfield);
%     CfieldSq=Cfield(ceil(sizecf/2-sqrt(2)*sizecf/4):floor(sizecf/2+sqrt(2)*sizecf/4),ceil(sizecf/2-sqrt(2)*sizecf/4):floor(sizecf/2+sqrt(2)*sizecf/4));
%      val1=[];
%      
%      for ii=1:length(xlist)
%          for jj=1:length(ylist)
%              val1=[val1,CfieldSq(ii,jj)];
%              
%          end 
%      end
%      vals1=[vals1;val1];
%      
%     
% end
% %divide the resulting image by the number of images
% %save(strcat(directoryAnalyse,'\im0'),'im0')
% mean(var(vals1))

    load(strcat(directoryAnalyse,'Conclin.mat'));
  %  Cstd=Cstd/0.035;%Normalisation par radeau de bdv dans la cuve (8mg).
    
% figure;
% plot(time,CMoy)
% hold on;
% plot([0,5400],[mean(CMoy(time>55*60&time<65*60)),mean(CMoy(time>55*60&time<65*60))],'-r')
% title(num2str(numVid));
  %  Cstd=Cstd-0.0155; %Correction de la variance due à l'éclairage
    
%         CstdCatMod=[CstdCatMod,sqrt(mean(Cstd)^2-mean(var(vals1)))];
        CstdCat=[CstdCat,mean(Cstd(time>55*60&time<65*60))];
       % CstdEt=[CstdEt,std(Cstd)];
     

    
end
plot(XCat,CstdCat,'+k','LineWidth',3,'MarkerSize',15)
figure;
 plot(XCat(1:7),CstdCat(1:7),'+b','LineWidth',3,'MarkerSize',15)
 hold on;
  plot(XCat(8:14),CstdCat(8:14),'+k','LineWidth',3,'MarkerSize',15)
   plot(XCat(15:21),CstdCat(15:21),'+r','LineWidth',3,'MarkerSize',15)
   
    plot(XCat(1:7),stdlist(1:7),'ob','LineWidth',3,'MarkerSize',15)
 hold on;
  plot(XCat(8:14),stdlist(8:14),'ok','LineWidth',3,'MarkerSize',15)
   plot(XCat(15:21),stdlist(15:21),'or','LineWidth',3,'MarkerSize',15)
%   plot(XCat(22:28),CstdCat(22:28),'+g','LineWidth',3,'MarkerSize',15)

%plot(XCat(8:9),CstdCat(8:9),'+r','LineWidth',3,'MarkerSize',10)
legend({'8mg_1','8mg_2','8mg_3','8mg_1 ss bdv','8mg_2 ss bdv','8mg_3 ss bdv'})
% ylim(1)=0;
% xlim(1)=0;
 ylabel('Cstd')
 xlabel('R [mm]')
% %xlim([0 75])
 hold on;
 errorbar(XCat,CstdCat,CstdEt,'LineStyle','none')
ylim([0 0.06])
xlim([0 4.5])
%% Spectres directs
figure;
axes('XScale','log','YScale','log');
c=parula(256);
list=[];
list=varNold;
%list(1)=[];
XCat=NCat(list);
leg='N=';
for i=1:length(list)
    numVid=list(i);
    %if MCat(numVid)>0
    load_param;
    load(strcat(directoryAnalyse,'SpectreDirectBL.mat'));
%     load(strcat(directoryAnalyse,'meanTrailc.mat'));
  %  figure;
    name = [leg num2str(XCat(i))];
%     
%     Sp2=zeros(928,1);
%     
%     %loop over each line
%     immoy(isnan(immoy))=0;
%     for j = 1:length(immoy)
%                 %calculate spectrum for the spatially reduced Cfield
%         line=immoy(:,j);
%                 N=round(length(line));
%         [SpLine,f2]=pwelch(line,hanning(N),round(N/2),N,1/calib);
%                 Sp2=Sp2+SpLine;
%     end
%     
%     
%     Sp2=Sp2/length(immoy);
%     loglog(f,Sp);hold on;
%    % loglog(f2,Sp2*Sp(round(N/16))/Sp2(round(N/16)),'r')
%        loglog(f2,Sp2,'r')

    
    hold on;
    %plot(f,-gradient(log(Sp),log(f)),'-','Color',c(round(255*XCat(i)/max(XCat)+1),:),'LineWidth',3,'DisplayName',name);
    plot(f,Sp,'-','Color',c(round(255*XCat(i)/max(XCat)+1),:),'LineWidth',3,'DisplayName',name);
    hold off;
   % end
end


%legend({'N=7','N=11','N=15','N=22','N=30','N=45'},'Location','northeast','Interpreter','latex')
legend({'R=1mm','R=1.5mm','R=2mm','R=2.5mm','R=3mm','R=3.5mm','R=4mm'},'Location','northeast','Interpreter','latex')
xlabel('k [mm$^{-1}$]','Interpreter','latex')
ylabel('$|\mathrm{TF}(C)|^2$','Interpreter','latex')
grid
legend show
%xlim([7e-3 6])
%ylim([1e-2 60])
%saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\Spectra.fig'))
%close;


%% Profils moyens longitudinaux
%figure;
c=parula(256);

listtot=[34:54,varRold];
XCat=RCat(listtot);
valmaxl=[];
posmaxl=[];

if list(1)==29
    list(1:2)=[];
end
for i=1:0.5:4
    list=listtot(RCat(listtot)==i);
    
%XCat=RCat(list);
%leg='R=';
figure;
    
    for ii=1:length(list)
    %determine the current video/set/parameters
    numVid=list(ii);
    load_param;
    if numVid>33
    load(strcat(directoryAnalyse,'long_profil'));
    else
            load(strcat(directoryAnalyse,'long_profilC'));
    end

    %    load(strcat(directoryAnalyse,'ConcBLtest.mat'));

    %meanProf=smooth(meanProf(:));
    %name = [leg num2str(XCat(i))];
    
    %plot(x,(proflong-nanmean(CMoy))./(nanmean(CMoy)-nanmean(CMoyneg(CMoyneg~=0))),'-','Color',c(round(256*XCat(i)/max(XCat)),:),'LineWidth',3,'DisplayName',name);
    %plot(x,(proflong),'-','Color',c(round(256*XCat(i)/max(XCat)),:),'LineWidth',3,'DisplayName',name);
    if ii==1
    plot(x,proflong,'-b')
    hold on;
    elseif ii==2
    plot(x,proflong,'-k')
    elseif ii==3
    plot(x,proflong,'-r')
    elseif ii==4
    plot(x,proflong,'-g')
    hold off;
    end

    
    legend({'8mg_1','8mg_2','8mg_3','40mg'})
title(num2str(i))
    [valmax,posmax]=max(proflong);
valmaxl=[valmaxl,valmax];
posmaxl=[posmaxl,posmax];
    end


end
figure;
 plot(XCat(1:7),valmaxl(1:7),'+b','LineWidth',3,'MarkerSize',15)
 hold on;
  plot(XCat(8:14),valmaxl(8:14),'+k','LineWidth',3,'MarkerSize',15)
   plot(XCat(15:21),valmaxl(15:21),'+r','LineWidth',3,'MarkerSize',15)
   plot(XCat(22:28),valmaxl(22:28),'+g','LineWidth',3,'MarkerSize',15)

%grid
%xlabel('x [mm]','Interpreter','latex')
%ylabel('$\frac{C-<C>_{\infty}}{<C>_{\infty}}$','Interpreter','latex')
%ylabel('C cor shift','Interpreter','latex')

%ylabel('$\frac{C-<C>}{<C>}$','Interpreter','latex')
%legend show
% %title('Mean longitudinal concentration profile')
% saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\Long_profiles.fig'))
% close;
%% Champ de concentration moyen autour du nageur
list=varRold;
for i=1:length(list)
    numVid=list(i);%1:nombreVid
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
date=strjoin(dateCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,date,sete,video);
    load(strcat(directoryAnalyse,'meanTraillin2.mat'));

    figure;
    imagesc(calib*(1:length(immoy))-0.5*calib*length(immoy),calib*(1:length(immoy))-0.5*calib*length(immoy),immoy',[-0.05 0.1])
    hold on;
    colormap parula(256)
    colorbar
    title(strcat('R=',num2str(RCat(numVid)),' mm'));
    axis equal
    ylim([-30 30])
    xlim([-60 30])
    xlabel('x [mm]','Interpreter','latex')
    ylabel('y [mm]','Interpreter','latex')
    annotation('textbox',...
    [0.73 0.4 0.3 0.15],...
    'String',{'$C$'},...
    'FontSize',45,...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontName','Times New Roman');
axis equal;
matlab2tikz();
pause;
%saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\',num2str(N(numVid)),'meanTrail.fig'))
   % close;
end


% %% Tracé de la position et la valeur du max du profil
%
% N=[5,10,15,22,30,40,49,59];
% posmaxl=[];
% valmaxl=[];
% for numVid=1:nombreVid
%     %determine the current video/set/parameters
%     video=strjoin(videoCatalogue(numVid));
%     sete=strjoin(setCatalogue(numVid));
%     directoryAnalyse=strcat(basePathAnalyse,sete,video,'\');
%     load(strcat(directoryAnalyse,'etude_profstd.mat'));
%    posmaxl=[posmaxl,posmax];
%     valmaxl=[valmaxl,valmax];
% end
% figure;
% plot(N,posmaxl,'+','MarkerSize',15,'LineWidth',3)
% grid
% xlabel('Number of swimmers','Interpreter','latex')
% ylabel('Max pos in front of swimmer [mm]','Interpreter','latex')
% saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\MaxPos=f(N).fig'))
% close;
%
% figure;
% plot(N,valmaxl,'+','MarkerSize',15,'LineWidth',3)
% grid
% xlabel('Number of swimmers','Interpreter','latex')
% ylabel('Max value in front of swimmer [a.u.]','Interpreter','latex')
% saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\MaxVal=f(N).fig'))
% close;

%% Tracé de l'aire de la zone de déplétion


airel=[];
varNoldlong=[616,443,343,303,292,167];
varRoldlong=[245,325,342,343,422,400,382];
list=[varRold];

if list(1)==29
    list(1)=[];
end
XCat=RCat(list);
incmlist=[];
incplist=[];
longlist=[];
larglist=[];
%plot(XCat,varRoldlong*0.18/sizeim,'+')
for i=1:length(list)
   numVid=list(i);
   
    load_param;
    load(strcat(directoryAnalyse,'aire_ell.mat'));
    airel=[airel,aire];
%   
     incmlist=[incmlist,incmoins];
     incplist=[incplist,incplus];
%     longlist=[longlist,longueur];
%     larglist=[larglist,largeur];
   
end
airel=airel/10000;
%  longlist=longlist*calib;
%  larglist=larglist*calib;
% hold on;
% figure;
%  plot(XCat(1:7),airel(1:7),'+b','LineWidth',3,'MarkerSize',15)
%  hold on;
%   plot(XCat(8:14),airel(8:14),'+k','LineWidth',3,'MarkerSize',15)
%    plot(XCat(15:20),airel(15:20),'+r','LineWidth',3,'MarkerSize',15)
plot(XCat,airel,'+b','LineWidth',3,'MarkerSize',15)
  %errorbar(XCat,airel,incmlist,incplist,'LineStyle','none','LineWidth',1)

% plot(XCat,longlist,'+','MarkerSize',15,'LineWidth',3)
% hold on;
% plot(XCat,larglist,'+r','MarkerSize',15,'LineWidth',3)
xlim([0 max(XCat)*1.1])
xlabel('N')
ylim([0 max(airel+incplist)*1.5])
grid
ylabel('Aire [cm2]','Interpreter','latex')
% figure;
% plot(XCat,longlist./larglist,'+k','MarkerSize',15,'LineWidth',3)
% xlabel('M [mg]')
% grid
% ylabel('Longueur/Largeur','Interpreter','latex')
% xlim([0 max(XCat)])

%ylabel('Aire de la zone d\''epl\''et\''ee [cm$^2$]','Interpreter','latex')
% saveas(gcf,strcat(basePathAnalyse,sete,'Figures\std\MaxVal=f(N).fig'))
% close;


% %% Tracé de Rcc
% figure('units','normalized','outerposition',[0 0 1 1])
% c=parula(256);
% for numVid=1:nombreVid
%     %determine the current video/set/parameters
%     video=strjoin(videoCatalogue(numVid));
%     sete=strjoin(setCatalogue(numVid));
%     directoryAnalyse=strcat(basePathAnalyse,sete,video);
%     load(strcat(directoryAnalyse,'\autocorrelationstd.mat'));
%
%
%     hold on;
%     plot(dX,Rcc,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
%     hold off;
%
% end
% grid
% xlabel('$\Delta$ x [mm]','Interpreter','latex')
% ylabel('$<\frac{(C(x)-<C>)(C(x+\Delta x)-<C>)}{<(C-<C>)^2>}>$','Interpreter','latex')
% legend({'N=5','N=10','N=15','N=22','N=30','N=40','N=49','N=59'},'Location','northeast','Interpreter','latex')
% ylim([-0.4 1.1])
% fig=gcf;
% set(fig,'PaperPositionMode','auto')
% %export_fig(gcf,strcat(basePathAnalyse,sete,'Cstd=f(t).pdf'))
% saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\Rcc=f(dX).fig'))
% close;
%
% %% Tracé de Rccu
% figure('units','normalized','outerposition',[0 0 1 1])
% c=parula(256);
% for numVid=1:nombreVid
%     %determine the current video/set/parameters
%     video=strjoin(videoCatalogue(numVid));
%     sete=strjoin(setCatalogue(numVid));
%     directoryAnalyse=strcat(basePathAnalyse,sete,video);
%     load(strcat(directoryAnalyse,'\Piv_corr.mat'));
%
%     dX=(X(1,2)-X(1,1))*calib*1:length(Rccu);
%
%     hold on;
%     plot(dX,Rccv,'-','Color',c(round(256*numVid/nombreVid),:),'LineWidth',3);
%     hold off;
%
% end
% grid
% xlabel('$\Delta$ x [mm]','Interpreter','latex')
% ylabel('$<\frac{(C(x)-<C>)(C(x+\Delta x)-<C>)}{<(C-<C>)^2>}>$','Interpreter','latex')
% legend({'N=5','N=10','N=15','N=22','N=30','N=40','N=49','N=59'},'Location','northeast','Interpreter','latex')
% ylim([-0.4 1.1])
% fig=gcf;
% set(fig,'PaperPositionMode','auto')
% %export_fig(gcf,strcat(basePathAnalyse,sete,'Cstd=f(t).pdf'))
% saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\Rcc=f(dX).fig'))
% close;

%% Tracé des histogrammes de vitesse


list=[34:54];
%list=varN;
XCat=RCat(list);
%XCat(1)=[];
xlabel('m')
vlist=[];
for i=1:length(list)
    numVid=list(i);
    
    %determine the current video/set/parameters
    load_param;
    if numVid~=29
            load(strcat(directoryAnalyse,'trajectories.mat'));
v=tracks(:,8);
v=v(v<100);
        vlist=[vlist,mean(v(isnan(v)==0))];
    end
    
    %[counts,bins] = hist_maison(v,0,70,201,1);
%     figure;
%     hold on;
%     color_line(bins,counts,'LineWidth',3);
    %plot(H_bubfree(:,1),H_bubfree(:,2),'r:','LineWidth',3);
    
%     hold off;
%     
%     xlim([0 70])
%     xlabel('v [mm.s$^{-1}$]','Interpreter','latex')
%     ylabel('PDF','Interpreter','latex')
%     title(strcat('N=',videoCatalogue(numVid)))
    
end

plot(XCat(1:7)',vlist(1:7),'+b','MarkerSize',15,'LineWidth',3)
hold on;
plot(XCat(8:14)',vlist(8:14),'+k','MarkerSize',15,'LineWidth',3)
plot(XCat(15:21)',vlist(15:21),'+r','MarkerSize',15,'LineWidth',3)

xlabel('R')
ylabel('<v> [mm/s]')
ylim([0 30])
xlim([0 4.1])


%saveas(gcf,strcat(basePathAnalyse,date,set,'\','PDFvitcompavecbubsamp'),'jpg')

% %% Tracé de vitesses moyennes en fct du nb de nageurs
% N=[5,10,15,22,30,40,49,59];
% figure;
%
% for numVid=1:8
%     %determine the current video/set/parameters
%     video=strjoin(videoCatalogue(numVid));
%     set=strjoin(setCatalogue(numVid));
%     directoryAnalyse=strcat(basePathAnalyse,set,video,'\');
%
%     load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
%
%
%     v=sample(:,8);
%
%
%
% hold on;
% plot(N(numVid),mean(v),'+','MarkerSize',4);
% errorbar(N(numVid),mean(v),std(v),'r','LineWidth',3);
% hold off;
%
%
%
% end
%
% grid
% xlabel('Number of swimmers','Interpreter','latex')
% ylabel('Mean velocity [mm.s$^{-1}$]','Interpreter','latex')
%
% %saveas(gcf,strcat(basePathAnalyse,date,set,video,'\','PDFvitcompavecsansbub'),'jpg')
%


%% Histogrammes d'intensités
c=parula(256);

%gradients
figure;
%axes('YScale','log');
list=[varNold];
for i=1:length(list)
    numVid=list(i);
    load_param;
    load(strcat(directoryAnalyse,'histog.mat'));
    name = ['N= ' num2str(NCat(numVid))];
    hold on;
    plot(xcountx,xcountx.^0.*countsax,'-','Color',c(round(256*NCat(numVid)/max(NCat)),:),'LineWidth',3,'DisplayName',name);
    hold off;
end
legend show
grid
xlabel('valeurs')
ylabel('PDF')

%Cfield

figure;
for i=1:length(varN)
    numVid=varN(i);
    load_param;
    load(strcat(directoryAnalyse,'histog.mat'));
    name = ['N= ' num2str(NCat(numVid))];
    hold on;
    plot(xcountcf,countscf,'-','Color',c(round(256*RCat(numVid)/max(NCat)),:),'LineWidth',3,'DisplayName',name);
    hold off;
end
grid
%legend(strcat('N= ',videoCatalogue(1:nombreVid)));
xlabel('$C$','Interpreter','latex')
ylabel('PDF')
xlim([-4 4])
% saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\hist_Cfieldcor.fig'))
% close;

%% Moment d'ordre 3 + et -


for i=1:length(varN)
    numVid=varN(i);
    load_param;
    load(strcat(directoryAnalyse,'histog_int.mat'));
    counts=(countsax+countsay)/2;
    x3PDFpos=counts(ceil(length(counts)/2)+1:length(counts)).*(xcountx(ceil(length(counts)/2)+1:length(counts)).^3);
    x3PDFneg=counts(1:ceil(length(counts)/2)-1).*(xcountx(1:ceil(length(counts)/2)-1).^3);
    
    for j=1:length(x3PDFpos)
        mom3pos(j)=sum(x3PDFpos(1:j));
        mom3neg(j)=-sum(x3PDFneg(length(x3PDFneg)+1-j:length(x3PDFneg)));
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
    %saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\sumx3pdf',video,'.fig'))
    
    figure;
    plot(xcountx,counts.*xcountx.^3,'LineWidth',3)
    grid
    xlabel('grad(C)','Interpreter','latex')
    ylabel('$x^3PDF$','Interpreter','latex')
    saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\x3pdf',video,'.fig'))
    
end
%% Moment d'ordre 3 en fonction de N


for i=1:length(varN)
    numVid=varN(i);
    load_param;
    load(strcat(directoryAnalyse,'histog_int.mat'));
    counts=(countsax+countsay)/2;
    x3PDFpos=counts(ceil(length(counts)/2)+1:length(counts)).*(xcountx(ceil(length(counts)/2)+1:length(counts)).^3);
    x3PDFneg=counts(1:ceil(length(counts)/2)-1).*(xcountx(1:ceil(length(counts)/2)-1).^3);
    
    for j=1:length(x3PDFpos)
        mom3pos(j)=sum(x3PDFpos(1:j));
        mom3neg(j)=-sum(x3PDFneg(length(x3PDFneg)+1-j:length(x3PDFneg)));
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
%saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\sumx3pdf=f(N).fig'))

%% Moment d'ordre 4 + et -


for i=1:length(varN)
    numVid=varN(i);
    load_param;
    load(strcat(directoryAnalyse,'histog_int.mat'));
    counts=(countsax+countsay)/2;
    x4PDFpos=counts(ceil(length(counts)/2)+1:length(counts)).*(xcountx(ceil(length(counts)/2)+1:length(counts)).^4);
    x4PDFneg=counts(1:ceil(length(counts)/2)-1).*(xcountx(1:ceil(length(counts)/2)-1).^4);
    
    for j=1:length(x4PDFpos)
        mom4pos(j)=sum(x4PDFpos(1:j));
        mom4neg(j)=sum(x4PDFneg(length(x4PDFneg)+1-j:length(x4PDFneg)));
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
    % saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\sumx4pdf',video,'.fig'))
    
    figure;
    plot(xcountx,counts.*xcountx.^4,'LineWidth',3)
    grid
    xlabel('grad(C)','Interpreter','latex')
    ylabel('$x^4PDF$','Interpreter','latex')
    %saveas(gcf,strcat(basePathAnalyse,'varNumber\Figures\std\x4pdf',video,'.fig'))
    
end

%% Moment d'ordre 4 en fonction de N


for i=1:length(varN)
    numVid=varN(i);
    load_param;
    load(strcat(directoryAnalyse,'histog_int.mat'));
    counts=(countsax+countsay)/2;
    x4PDFpos=counts(ceil(length(counts)/2)+1:length(counts)).*(xcountx(ceil(length(counts)/2)+1:length(counts)).^4);
    x4PDFneg=counts(1:ceil(length(counts)/2)-1).*(xcountx(1:ceil(length(counts)/2)-1).^4);
    
    for j=1:length(x4PDFpos)
        mom4pos(j)=sum(x4PDFpos(1:j));
        mom4neg(j)=-sum(x4PDFneg(length(x4PDFneg)+1-j:length(x4PDFneg)));
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

% %% Déterminer la longueur caract des corrélations
%
% L_s50=zeros(1,11);
% for numVid=2:11
%
%
%     %determine the current video/set/parameters
%     video=strjoin(videoCatalogue(numVid));
%     set=strjoin(setCatalogue(numVid));
%     directoryVid=strcat(basePathVid,date,set,video,'\processed\');
%     directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
%     load(strcat(directoryAnalyse,'RccSp_final.mat'));
%     k=1;
%     while RcccorS(k)>0.5
%         k=k+1;
%     end
%     L_s50(numVid)=dX(1,k);
%
%
% end

% %% PIV results
% for numVid=2:11
%
%     video=strjoin(videoCatalogue(numVid));
%     sete=strjoin(setCatalogue(numVid));
%     directoryVid=strcat(basePathVidProcessed,date,sete,video,'\processed\');
%     directoryAnalyse=strcat(basePathAnalyse,date,sete,video,'\');
%     load(strcat(directoryAnalyse,'PIV_means.mat'));
%     vitnorm=sqrt(Umoy.*Umoy+Vmoy.*Vmoy);
% figure;
% quiverC2D(X,Y,Umoy,Vmoy)
%  cmap = colormap(jet(256)) ; %Create Colormap
%  cbh = colorbar ; %Create Colorbar
%
% %  set(cbh,'YTickLabel',round(linspace(51.2,256,5))./256*40)
% title(videoCatalogue(numVid))
% xlabel('Direction transverse [mm]')
% ylabel('Direction du mouvement [mm]')
% end
%
%
% %%
% legend(videoCatalogue(2:11));
% title('histogramme de Cfield')
% grid
% xlabel('C')
% ylabel('PDF')
% xlim([-0.6 0.6])


% %% Energie cinétique en fonction du temps
% clear all;
% run manips180913;
%
%
% temps=[];
% Ec=[];
% Ecstd=[];
% for numVid=1:14
%
%     %determine the current video/set/parameters
%     video=strjoin(videoCatalogue(numVid));
%     set=strjoin(setCatalogue(numVid));
%     directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
%     load(strcat(directoryAnalyse,'trail.mat'));
%     for i=2:length(tracks(:,1))
%         if tracks(i,4)==tracks(i-1,4) && tracks(i-1,3)+1==tracks(i,3)
%             tracks(i,9)=(tracks(i,1)-tracks(i-1,1))*fps;
%             tracks(i,10)=(tracks(i,2)-tracks(i-1,2))*fps;
%             tracks(i,11)=sqrt(tracks(i,9)*tracks(i,9)+tracks(i,10)*tracks(i,10));
%
%         end
%     end
%     if numVid==1
%         deb1=5*60*20;
%         fin1=5*60*20+1000;
%         deb2=10*60*20;
%         fin2=10*60*20+1000;
%         tracks1=tracks(tracks(:,3)>deb1,:);
%         tracks1=tracks1(tracks1(:,3)<fin1,:);
%         tracks2=tracks(tracks(:,3)>deb2,:);
%         tracks2=tracks2(tracks2(:,3)<fin2,:);
%         temps=[temps,5*60+500/20,10*60+500/20];
%         Ec=[Ec,mean(tracks1(:,11).^2),mean(tracks2(:,11).^2)];
%         Ecstd=[Ecstd,std(tracks1(:,11).^2),std(tracks2(:,11).^2)];
%     end
%     if numVid>1
%         deb=1;
%         fin=1000;
%         tracks=tracks(tracks(:,3)>deb,:);
%         tracks=tracks(tracks(:,3)<fin,:);
%         temps=[temps,str2num(video)*60+500/20];
%         Ec=[Ec,mean(tracks(:,11).^2)];
%         Ecstd=[Ecstd,std(tracks(:,11).^2)];
%     end
%
%
%
%
% end
%
%     figure;
%     errorbar(temps,Ec,Ecstd,'LineWidth',3)
%     xlabel('temps [s]','Interpreter','latex')
%     ylabel('\''Energie cin\''etique moyenne','Interpreter','latex')
%
% grid
%
% %%
% axes('XScale','log','YScale','log');
%
% for numVid=2:11
%     %determine the current video/set/parameters
%     video=strjoin(videoCatalogue(numVid));
%     set=strjoin(setCatalogue(numVid));
%     directoryVid=strcat(basePathVid,date,set,video,'\processed\');
%     directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
%     directoryPiv=strcat(basePathAnalyse,date,set,video,'\PIV_fullimg\');
%     clear SpMeanU;
%     load(strcat(directoryPiv,'PIV_SpectreDirect_interp.mat'));
%
%
%     hold on;
%     color_line(fDirectU,SpMeanU,ones(1,length(fDirectU)).*(numVid-1),'LineWidth',3);
%
%
%     hold off;
%
% end
% %legend(['5','10',videoCatalogue(2:14)]);
% legend(videoCatalogue(2:11));
% xlabel('Fréquence [mm^{-1}]')
% ylabel('Densité de puissance')