%% Permet juste de charger tous les paramètres
    basePathVid=strjoin(basePathVidCatalogue(numVid));
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    startImg=startImgCatalogue(numVid);
    date=strjoin(dateCatalogue(numVid));
    % build paths and create directories
    directoryVid=strcat(basePathVid,date,sete,video);
    if numVid==51
            directoryVid=strcat(basePathVid,video);
    end

    directoryBg=strcat(basePathVid,date,sete,video,'bg\');
    directoryAnalyse=strcat(basePathAnalyse,date,sete,video);
    directoryAnalysePyt=strcat('E:\Clément\MyCore\Analyse\Mixing\',date,sete,video);
    if exist(directoryAnalyse)==0
        mkdir(directoryAnalyse);
        fprintf('Répertoire d\''analyse créé')
    end
    if exist(strcat(directoryAnalyse,'directory.mat'))==0
      L=dir(strcat(directoryVid,'*.tif'));
      save(strcat(directoryAnalyse,'directory.mat'),'L');
      fprintf('L calculé et sauvegardé')
    end
    directoryPivfull=strcat(basePathAnalyse,sete,video,'pivfull\');
   directoryPivmean=strcat(basePathAnalyse,date,sete,video,'PIV_mean\');
      directoryPivmean2=strcat(basePathAnalyse,date,sete,video,'PIV_mean2\');

%     if exist(directoryPivfull)==0
%         mkdir(directoryPivfull)
%         fprintf('directoryPivfull créé')
%     end
%     if exist(directoryPivmean)==0
%         mkdir(directoryPivmean)
%         fprintf('directoryPivmean créé')
%     end

      radiusCellPx=radiusCellPxCat(numVid);
    centerCellX=centerCellXCat(numVid)+radiusCellPx;
    centerCellY=centerCellYCat(numVid)+radiusCellPx;
    centerCellXBg=centerCellXBgCat(numVid)+radiusCellPx;
    centerCellYBg=centerCellYBgCat(numVid)+radiusCellPx;
    centerCellXSolo=centerCellXBgCat(numVid)+radiusCellPx;
    centerCellYSolo=centerCellYBgCat(numVid)+radiusCellPx;
    
    radiusCellPxBg=radiusCellPx;
    shiftX=centerCellX-centerCellXBg;
    shiftY=centerCellY-centerCellYBg;
    calib=calibCat(numVid);
   sizeim=2*radiusCellPx;
    %R_range contient les tailles min et max des cercles qui seront
    %détectés dans camphre_findpos_rom
    R_range=[floor(RCat(numVid)*0.95/calib) ceil(RCat(numVid)*1.05/calib)];