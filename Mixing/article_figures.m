%% Tracé des figures de l'article de mixing (début 2020)

run manipsfinales;numVid=25;load_param;

%% Image typique
numVid=25;load_param;
    
    load(strcat(directoryAnalyse,'directory.mat'));
    imbg=load(strcat(directoryAnalyse,'im0.mat'));
imbg=imbg.im0;

       immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));


    k=18279;
    
    fname=L(k).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        
        im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
        im=im.*immask;
        X=((1:length(im)-1))*calib;
        Y=X;
        imagesc(X,Y,im);colormap gray(256);colorbar;axis square;
        ylim([min(Y)-0.0000001 max(Y)+0.0000001]);
        xlim([min(X)-0.0000001 max(X)+0.0000001]);
          xlabel('X [mm]');ylabel('Y [mm]');
          
%% Image referee 8mg
mean(CMoy(time>55*60&time<65*60))
numVid=40;load_param;
    
    load(strcat(directoryAnalyse,'directory.mat'));
    imbg=load(strcat(directoryAnalyse,'im0.mat'));
imbg=imbg.im0;

       immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));


    k=10000;
    
    fname=L(k).name;
        fnamecompl=strcat('Y:\cgouiller\Mixing\190620\varSize\5\',fname);
        im=double(imread(fnamecompl));
        
        im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
        im=im.*immask;
        X=((1:length(im)-1))*calib;
        Y=X;
        load('E:\Clément\Mixing\Analyse\190620\varSize\5\Conclin.mat')
        im=im/mean(CMoy(time>55*60&time<65*60));
        imagesc(X,Y,im);colormap gray(256);colorbar;axis square;
        ylim([min(Y)-0.0000001 max(Y)+0.0000001]);
        xlim([min(X)-0.0000001 max(X)+0.0000001]);
          xlabel('X [mm]');ylabel('Y [mm]');
          %%
       numVid=40;load_param;
 imbg=load(strcat(directoryAnalyse,'im0'));
    imbg=imbg.im0;
     load(strcat(directoryAnalyse,'directory.mat'));

    immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));

   
    load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
   
    
    a=load(strcat(directoryAnalyse,'positions.mat'));
    c=a.c;
 

    k=10000;
    
    fname=L(k).name;
        fnamecompl=strcat('Y:\cgouiller\Mixing\190620\varSize\5\',fname);
        im=double(imread(fnamecompl));
        
        im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
        im=im.*immask;
         X=((1:length(im)-1))*calib;
        Y=X;
 pos=[c(k).x,c(k).y,c(k).r];
        pos=pos/calib;
        Cfield=calc_Cfield2(im,imbg,pos,immask);
        load('E:\Clément\Mixing\Analyse\190620\varSize\5\Conclin.mat')

        Cfieldnorm=Cfield/mean(CMoy(time>55*60&time<65*60)); %en g/m^2 d'après calibration
       % Cfieldtrue=Cfieldtrue-nanmean2(Cfieldtrue);
        imagesc(X,Y,Cfieldnorm);colormap parula(256);colorbar;hold on;axis equal;
     
        caxis([-0.0000001 6.00000001]);axis equal;ylim([min(Y)-0.0000001 max(Y)+0.0000001]);
        xlim([min(X)-0.0000001 max(X)+0.0000001]);
          xlabel('X [mm]');ylabel('Y [mm]');
        annotation('textbox',...
    [0.73 0.4 0.3 0.15],...
    'String',{'C/$\bar{<C>}$'},...
    'FontSize',30,...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontName','Times New Roman');

 %% Cfield
       numVid=25;load_param;
 imbg=load(strcat(directoryAnalyse,'im0'));
    imbg=imbg.im0;
     load(strcat(directoryAnalyse,'directory.mat'));

    immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));

   
    load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
   
    
    a=load(strcat(directoryAnalyse,'positions.mat'));
    c=a.c;
 

    k=18279;
    
    fname=L(k).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        
        im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
        im=im.*immask;
         X=((1:length(im)-1))*calib;
        Y=X;
 pos=[c(k).x,c(k).y,c(k).r];
        pos=pos/calib;
        Cfield=calc_Cfield2(im,imbg,pos,immask);
        Cfieldtrue=Cfield/0.0140; %en g/m^2 d'après calibration
       % Cfieldtrue=Cfieldtrue-nanmean2(Cfieldtrue);
        imagesc(X,Y,Cfieldtrue);colormap parula(256);colorbar;hold on;axis equal;
     
        caxis([-0.0000001 10.0000001]);axis equal;ylim([min(Y)-0.0000001 max(Y)+0.0000001]);
        xlim([min(X)-0.0000001 max(X)+0.0000001]);
          xlabel('X [mm]');ylabel('Y [mm]');
        annotation('textbox',...
    [0.73 0.4 0.3 0.15],...
    'String',{'C [g.m$^{-2}$]'},...
    'FontSize',30,...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontName','Times New Roman');
        
%% Calibration
massCat=[];
CMoyCat=[];
CMoyEt=[];
c=parula(256);
%figure;
list=[1:3,5,7,8,10:16,29:31];%[varR,varRold];
list=[6,9,11];
XCat=MCat(list);
for i=1:length(list)
    numVid=list(i);
    %determine the current video/set/parameters
    load_param;
    
            load(strcat(directoryAnalyse,'Conc.mat'));
            %load(strcat(directoryAnalyse,'Conclin.mat'));

time=time(CMoy~=0);
CMoy=CMoy(CMoy~=0);
   CMoyMean=mean(CMoy(time>55*60&time<65*60));
    if numVid==29
         CMoyCat=[CMoyCat,mean(CMoy)];
        CMoyEt=[CMoyEt,std(CMoy)];
    else
        CMoyCat=[CMoyCat,mean(CMoy(time>55*60&time<65*60))];
        CMoyEt=[CMoyEt,std(CMoy(time>55*60&time<65*60))];
    end
    if MCat(numVid)>12
        figure;plot(time/60,CMoy/CMoyMean,'+');ylim([0 1.3]);xlabel('temps [min]');ylabel('<I>_{x,y}(t)/<I>_{x,y,t}')
    end
end

%errorbar(XCat,CMoyCat,CMoyEt,'LineStyle','none')
xlabel('Poured glass bubbles mass [mg]')
hold on;
plot(XCat,CMoyCat,'+b','LineWidth',3,'MarkerSize',15)
ylabel('<C> [arb.units]')
xlim([0 85])
ylim([-0.005 0.045])
   

%% Cstd=f(N)

list=varNold;
XCat=NCat(list);
CstdCat=[];
CstdEt=[];
CstdCatNorm=[];
CstdEtNorm=[];
test=[];
for i=1:length(list)
    numVid=list(i);
    %determine the current video/set/parameters
    load_param;
    
            load(strcat(directoryAnalyse,'Conclin.mat'));
CstdCat=[CstdCat,mean(Cstd(time>55*60&time<65*60))];
CstdCatNorm=[CstdCatNorm,mean(Cstd(time>55*60&time<65*60))/mean(CMoy(time>55*60&time<65*60))];

CstdEt=[CstdEt,std((Cstd(time>55*60&time<65*60)))];
CstdEtNorm=[CstdEtNorm,std((Cstd(time>55*60&time<65*60)))/mean(CMoy(time>55*60&time<65*60))];
test=[test,mean(Cstd(time>55*60&time<65*60))/mean(CMoy(time>55*60&time<65*60))*(std(Cstd(time>55*60&time<65*60))/mean(Cstd(time>55*60&time<65*60))+std(CMoy(time>55*60&time<65*60))/mean(CMoy(time>55*60&time<65*60)))];%C'est comme ça que ça a été mis dans l'article
    
end

errorbar(XCat,CstdCat,CstdEt,'LineStyle','none')
xlabel('N []')
hold on;
%plot(XCat,CstdCat,'+b','LineWidth',3,'MarkerSize',15)
ylabel('C_{std} [arb.units]')
xlim([0 50])
ylim([0 0.06])

%% Cstd=f(R)

list=varR;
XCat=RCat(list);
CstdCat=[];
CstdCatNorm=[];
CstdEt=[];
for i=1:length(list)
    numVid=list(i);
    %determine the current video/set/parameters
    load_param;
    
            load(strcat(directoryAnalyse,'Conclin.mat'));
CstdCat=[CstdCat,mean(Cstd(time>55*60&time<65*60))];
CstdCatNorm=[CstdCatNorm,mean(Cstd(time>55*60&time<65*60))/mean(CMoy(time>55*60&time<65*60))];

CstdEt=[CstdEt,std((Cstd(time>55*60&time<65*60)))];

    
end

errorbar(XCat,CstdCat,CstdEt,'LineStyle','none')
xlabel('R [mm]')
hold on;
plot(XCat,CstdCat,'+b','LineWidth',3,'MarkerSize',15)
ylabel('C_{std} [arb.units]')
xlim([0 4.5])
ylim([0 0.06])
%%
clear all;



run('E:\Clément\Mixing\Matlab\manips180913.m');
timetot=(1:217000)/(20*60);
Cstdtot=NaN(1,217000);
timefilt=[];
Cstdfilt=[];
Cstdfiltstd=[];


for numVid=1:12
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,sete,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,date,sete,video,'\');
 %   L=dir(strcat(directoryVid,'*.tif'));
    Cstd=[];
    load(strcat(directoryAnalyse,'Conc.mat'));
    Cstdtot(str2num(video)*60*20+startImgCatalogue(numVid):str2num(video)*60*20+length(time)+startImgCatalogue(numVid)-1)=Cstd;
    for k=1:floor(length(Cstd)/300)
        Cstdfilt=[Cstdfilt,mean(Cstd((k-1)*300+1:k*300))];
        Cstdfiltstd=[Cstdfiltstd,std(Cstd((k-1)*300+1:k*300))];
        timefilt=[timefilt,str2num(video)+(150+300*(k-1))/20/60];
    end
    
end
Cstdfilt=Cstdfilt/Cstdfilt(1);
plot(timefilt,Cstdfilt,'+k','LineWidth',2,'MarkerSize',12)
%errorbar(timefilt,Cstdfilt,Cstdfiltstd,'LineStyle','none')
xlabel('Time [min]','Interpreter','latex')
ylabel('$C_{std}$','Interpreter','latex')
xlim([0 125])
ylim([0 1.05])
% hold on;
% % create a new pair of axes inside current figure
% axes('position',[.65 .65 .25 .25])
% box on % put box around new pair of axes
% indexOfInterest = timefilt<10; % range of t near perturbation
% plot(timefilt(indexOfInterest),Cstdfilt(indexOfInterest),'+k','LineWidth',2,'MarkerSize',12) % plot on new axes
% axis tight
% xlim([0 10])
% ylim([0 1.05])

%% Champ de conc moyen
numVid=25;load_param; %1

 load(strcat(directoryAnalyse,'meanTraillin2.mat'));
immoy(isnan(immoy))=0;
immoy=nanCircle(immoy,round(length(immoy)/2),round(length(immoy)/2),round(2.5/calib));
 calibc=0.0140;
 min=0;
 max=5;

 % immoycor(immoycor<(min+(max-min)/256))=min+(max-min)/256+0.000000001;
 x=calib*(1:length(immoy))-0.5*calib*length(immoy);
 y=calib*(1:length(immoy))-0.5*calib*length(immoy);
 
 
  % immoycor=((immoy-mean25))'/0.0140;
 immoycor=((immoy)/calibc)';
 %immoycor(immoycor<0)=0;
  %immoycor=immoycor+5/256;

 [xtest,ytest]=meshgrid(x(310:1236),y(619:1236));
 immoycor(xtest.*xtest+ytest.*ytest<RCat(numVid)*RCat(numVid))=0;
    figure;
    imagesc(x(310:1236),y(619:1236),immoycor(619:1236,310:1236),[min max])
    hold on;

%perso=[1 1 1;parula(255)];
    colorbar
       axis equal
    %ylim([-30 30])
   % xlim([-60 30])
    xlabel('X [mm]','Interpreter','latex')
    ylabel('Y [mm]','Interpreter','latex')
    annotation('textbox',...
    [0.73 0.4 0.3 0.15],...
    'String',{'$C$ [mg.m$^{-2}$]'},...
    'FontSize',45,...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontName','Times New Roman');
title(strcat('N=',num2str(NCat(numVid))))
 %set(b,'AlphaData',~isnan(immoycor))
   % colormap(perso)
colormap parula(256);

%% PIV
clear all;
run manipsfinales;
load('E:\Clément\Mixing\Analyse\190405\commun\15\PIV_mean2.mat')
numVid=25;
load_param;
x=X(85:189,47:117);
y=Y(85:189,47:117);
Umoy(countsu+countsv<14142/20)=NaN;% on garde ceux où y a au moins 5% de data
Vmoy(countsu+countsv<14142/20)=NaN;
up=Umoy(85:189,47:117);
vp=Vmoy(85:189,47:117);

up(isfinite(up)==0 | isfinite(vp)==0)=NaN;

vp(isfinite(up)==0 | isfinite(vp)==0)=NaN;

n=4; % plus n grand plus résolution faible
Xp=x(1:n:size(x,1),1:n:size(x,2));
Yp=y(1:n:size(x,1),1:n:size(x,2));
Up=up(1:n:size(x,1),1:n:size(x,2));
Vp=vp(1:n:size(x,1),1:n:size(x,2));

%Choix des bornes


quiverC2D(Xp,Yp,Up,Vp)
xlabel('Transverse direction [mm]')
ylabel('Swimming direction [mm]')
axis equal
colormap parula(64)
colorbar
I = sqrt(Up.^2 + Vp.^2);
labels=0:4:20;
empl=labels*64/max(max(I));
colorbar('YTick',empl,...
         'YTickLabel',{num2str(labels(1)),num2str(labels(2)),num2str(labels(3)),num2str(labels(4)),num2str(labels(5)),num2str(labels(6))})
         annotation('textbox',...
    [0.73 0.4 0.3 0.15],...
    'String',{'Speed [mm.s$^{-1}$]'},...
    'FontSize',20,...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontName','Times New Roman');

%% Spectre =f(N)
figure;
   Markers = {'+','o','*','x','v','d','^','s','>','<'};
axes('XScale','log','YScale','log');
c=parula(256);
list=varNold;
XCat=NCat(list);
leg='N=';
for i=1:length(list)
    numVid=list(i);
    
    load_param;
    load(strcat(directoryAnalyse,'SpectreDirectBL.mat'));
    name = [leg num2str(XCat(i))];

    
    hold on;
    plot(f,Sp,strcat(Markers{i}),'Color',c(round(255*XCat(i)/max(XCat)+1),:),'LineWidth',2,'DisplayName',name);
    hold off;
end

xlim([0.007 6])
ylim([8e-3 50])
xlabel('k [mm$^{-1}$]','Interpreter','latex')
ylabel('$|\mathrm{TF}(C)|^2$','Interpreter','latex')
grid
legend show

%% Spectre =f(R)
figure;
   Markers = {'+','o','*','x','v','d','^','s','>','<'};
axes('XScale','log','YScale','log');
c=parula(256);
list=varRold;
XCat=RCat(list);
leg='R=';
for i=1:length(list)
    numVid=list(i);
    
    load_param;
    load(strcat(directoryAnalyse,'SpectreDirectBL.mat'));
    name = [leg num2str(XCat(i)) ' mm'];

    
    hold on;
    plot(f,Sp,strcat(Markers{i}),'Color',c(round(255*XCat(i)/max(XCat)+1),:),'LineWidth',2,'DisplayName',name);
    hold off;
end

xlim([0.007 6])
ylim([8e-3 50])
xlabel('k [mm$^{-1}$]','Interpreter','latex')
ylabel('$|\mathrm{TF}(C)|^2$','Interpreter','latex')
grid
legend show


%% Comparaison modèle/exp - rayon


R=[1;1.5;2;2.5;3;3.5;4];
Vmoy=[28.03;38.39;49.02;57.67;64.7;68.23;74.34]*0.001;

%Cas asym
for i=1:length(R)
    L_suba(i)=sqrt((5e-9*(R(i)./4).^2*3e-3)./(pi*sqrt(10^(-4))*(Vmoy(i))*6e-7));
    L_subap(i)=sqrt(10^(-4)*L_suba(i)/Vmoy(i));
end
Asub=pi*L_suba.*L_subap*10000; %en cm^2

airel=[];

list=[varRold];

XCat=RCat(list);
incmlist=[];
incplist=[];

for i=1:length(list)
   numVid=list(i);
   
    load_param;
    load(strcat(directoryAnalyse,'aire_ellipse3.mat'));
    airel=[airel,aire];
%   
     incmlist=[incmlist,incmoins];
     incplist=[incplist,incplus];

   
end
plot(R,Asub,'+b','MarkerSize',15,'LineWidth',3,'DisplayName','Sublimation totale');
hold on; 
plot(XCat,airel,'+g','MarkerSize',15,'LineWidth',3,'DisplayName','Expérience');
legend show

xlim([0 max(XCat)*1.1])
xlabel('R [mm]')
%ylim([0 max(airel+incplist)*1.5])
grid
ylabel('Aire [cm$^2$]','Interpreter','latex')


%% Comparaison modèle/exp - nombre de nageurs
run defaultfig; run manipsfinales;
airel=[];

list=[varRold];

XCat=RCat(list);
incmlist=[];
incplist=[];

for i=1:length(list)
   numVid=list(i);
   
    load_param;
    load(strcat(directoryAnalyse,'aire_ellipse3.mat'));
    airel=[airel,aire];
%   
     incmlist=[incmlist,incmoins];
     incplist=[incplist,incplus];

   
end

plot(XCat,airel,'+g','MarkerSize',15,'LineWidth',3,'DisplayName','Expérience');
legend show

xlim([0 max(XCat)*1.1])
xlabel('N []')
%ylim([0 max(airel+incplist)*1.5])
grid
ylabel('Aire [cm$^2$]','Interpreter','latex')