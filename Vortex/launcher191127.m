clear all;

run('E:\Clément\Vortex\Matlab\manips191127.m');
%%
for numVid=1%:nombreVid
    
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    date=strjoin(dateCatalogue(numVid));
    startImg=startImgCatalogue(numVid);
    basePathVid=basePathVidCatalogue{numVid};
    % build paths and create directories
    directoryVid=strcat(basePathVid,date,sete,video);
    %directoryBg=strcat(basePathVid,date,sete,'bg\');
    directoryAnalyse=strcat(basePathAnalyse,date,sete,video);
    mkdir(directoryAnalyse);
%     directoryPivfull=strcat(basePathAnalyse,sete,video,'\PIV_fullimg\');
%     directoryPivmean=strcat(basePathAnalyse,sete,video,'\PIV_mean\');
%     mkdir(directoryPivfull);
%     mkdir(directoryPivmean);
radiusCellPx=radiusCellPxCat(numVid);
    centerCellX=centerCellXCat(numVid)+radiusCellPx;
    centerCellY=centerCellYCat(numVid)+radiusCellPx;

    %  centerCellXBg=centerCellXBgCat(numVid)+radiusCellPx;
  %  centerCellYBg=centerCellYBgCat(numVid)+radiusCellPx;
 %   radiusCellPxBg=radiusCellPx;
 %   shiftX=centerCellX-centerCellXBg;
   % shiftY=centerCellY-centerCellYBg;
    
    %R_range contient les tailles min et max des cercles qui seront
    %détectés dans camphre_findpos_rom
    R_range=[floor(RCat(numVid)*0.95/calib) ceil(RCat(numVid)*1.05/calib)];
    
%     
     track_particles; % Création de l'image de background (im0) et tracking de particules (sauvegardé dans positions.mat)
%     concentration; %Evolution des différents champs scalaires, obtenus à la fois par Beer-Lambert (ConcBL.mat) et par interpolation linéaire (Conclin.mat)
%     spectre; %Calcule avec pwelch le spectre moyen du champ de concentration réduit dans le carré, (C-CMoySq)/CstdSq
%     constr_traject;%Se servant des positions obtenues par track_particles en déduit les trajectoires sauvegardées dans trajectories.mat
%     filtrage_traj;%Regarde dans trajectories.mat quelles particules sont assez éloignées des bords ainsi que des autres
%     concmoyautournag; %Trace le champ de concentration moyen en bulles de verre autour des particules sélectionnees par le filtrage
%     calc_profil; %Calcule le profil longitudinal moyen dans la direction de nage, proflong, sauvegardé dans long_profil.mat
%aire_ellipse%Calcul l'aire de la zone de déplétion avec seuil à -0.5 sur (C-<C>)/<C>
%etude_proflong%Trouve la valeur du max du profil et sa position
%calc_Rcc %Calcule S1, S2, S3 et S4
%corRcc % Déduit Rcc de S2
%hist_intensite %Calcule les histogrammes de (C-<C>)/<C> et des gradients de <C> normalisés par racine(grad_x^2+grad_y^2)
%PIV_pretreatment_fullimg;
%PIV_pretreatment_mean;
%PIV_treatment_mean
%PIV_correlation;
% load(strcat(directoryAnalyse,'\PIV_mean'));
% Umoy((isnan(Umoy)==1))=0;
% Vmoy((isnan(Vmoy)==1))=0;
% Umoy(countsu+countsv<50)=0;
% Vmoy(countsu+countsv<50)=0;
% X=X*calib;%en mm
% Y=Y*calib;%en mm
% figure;
% colormap parula(256);
% colorbar;
% quiverC2D(X,Y,Umoy,Vmoy)
% title(strcat('N=',num2str(N(numVid)),' nageurs'))
% axis square;
% xlabel('Direction transverse [mm]','Interpreter','latex')
% ylabel('Direction de nage [mm]','Interpreter','latex')
% 
% 
% valeurs=[0,1,2,3,4,5,6];
% cc=colorbar;
% set(cc,'YTick',256/6*valeurs,'YTickLabel',{'0','1','2','3','4','5','6'});
% 
% pause;
% saveas(gcf,strcat(directoryAnalyse,'\PIV_meanfig'),'fig')
% close;
end


