%% Permet juste de charger tous les paramètres
    basePathVid=strjoin(basePathVidCatalogue(numVid));
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    startImg=startImgCatalogue(numVid);
    date=strjoin(dateCatalogue(numVid));
    % build paths and create directories
    directoryVid=strcat(basePathVid,date,sete,video);
    
    directoryAnalyse=strcat(basePathAnalyse,date,sete,video);
    directoryPyt=strcat('E:\Clément\MyCore\Analyse\Multi\',date,sete,video);
    if exist(directoryAnalyse)==0
        mkdir(directoryAnalyse);
        fprintf('Répertoire d\''analyse créé')
    end
    if exist(directoryPyt)==0
        mkdir(directoryPyt);
        fprintf('Répertoire d\''analyse créé')
    end
    if exist(strcat(directoryAnalyse,'directory.mat'))==0
      L=dir(strcat(directoryVid,'*.tif'));
      save(strcat(directoryAnalyse,'directory.mat'),'L');
      fprintf('L calculé et sauvegardé')
    end

%     x0=[hgxcat(numVid),hdxcat(numVid),bdxcat(numVid),bgxcat(numVid)];
%     y0=[hgycat(numVid),hdycat(numVid),bdycat(numVid),bgycat(numVid)];
    fps=fpscat(numVid);
    calib=calibCat(numVid);
    %R_range contient les tailles min et max des cercles qui seront
    %détectés dans camphre_findpos_rom
    R_range=[floor(Rdetect(numVid)*0.85/calib) ceil(Rdetect(numVid)*1.1/calib)];