%% Calcul des fonctions de structure

param='sur 100 images sans corrections de bg';
directoryVid=strcat(basePathVid,date,set,video,'\');
directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');

load(strcat(directoryAnalyse,'Conc.mat'));
L=dir(strcat(directoryVid,'*.tif'));
endCorr=length(L);

%% Initialisations diverses

%CfieldSq est le carré inscrit dans la cuve, dans lequel on va étudier les
%corrélations



% initialization of the timestamp
dispstat('','init');
dispstat(sprintf('Begining the process for the movie...'),'keepthis','timestamp');

%variables
count=0;
S1=0;
S2=0;
S3=0;
S4=0;
% dC2MoyTtot=0;
dC2MoyStot=0;
sizesquare=zeros(sizeim,sizeim);
sizesquaresq=sizesquare(ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4),ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4));
CfieldSqtot=zeros(length(sizesquaresq),length(sizesquaresq));

% get the frames processed  that are the closest to the starting and ending
% time of the stationnary zone
% while mod(startCorr-1,saut) ~=0
%     startCorr=startCorr+1;
% end
% while mod(endCorr-1,saut) ~=0
%     endCorr=endCorr-1;
% end

indices=1:((endCorr-startCorr)/saut);
a=load(strcat(directoryAnalyse,num2str(video),'_positions.mat'));
c=a.c;
    
imbg=load(strcat(directoryAnalyse,'imbg'));
imbg=imbg.im0;

%% big loop over 20 images in the range of processed image in the stationnary zone
for k=round(linspace(startCorr,endCorr,100))%startCorr:round(length(indices)/Nstationary)*saut:endCorr
    count=count+1;
    fname=L(k+startImgCatalogue(numVid)).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));

    pos=[];
    pos=[c(k).x,c(k).y,c(k).r];
    pos=pos/calib;
    Cfield=calc_Cfield(im,imbg,pos);
    
    CfieldSq=Cfield(ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4),ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4));
    Xr=1:length(CfieldSq);
%     % get current image
%     fnamecompl=strcat(directoryVid,num2str(k,'%05i'),'.mat');
%     im=load(fnamecompl);
%     Cfield=im.Cfield;
    
    
    
    % Get the increments
    [S1t,S2t,S3t,S4t] = linCorrNew(CfieldSq);
    
    S1=S1+S1t;
    S2=S2+S2t;
    S3=S3+S3t;
    S4=S4+S4t;
    
    
    %Pour faire la moyenne spatiale
    CMoyS=nanmean(nanmean(CfieldSq));
    dCS=CfieldSq-CMoyS;
    dC2S=dCS.*dCS;
    dC2MoyS=nanmean(nanmean(dC2S));
    dC2MoyStot=dC2MoyStot+dC2MoyS;
    
%     %Pour faire la moyenne temporelle
%     CfieldSq(isnan(CfieldSq))=0;
%     CfieldSqtot=CfieldSqtot+CfieldSq;
% timer
dispstat(sprintf('Progress %d%%',round((k-startCorr)*100/(endCorr-startCorr))),'timestamp');
    
end

% CfieldSqMoy=CfieldSqtot'/count;

% for k=startCorr:round(length(indices)/Nstationary)*saut:endCorr
%     dCT=CfieldSq-CfieldSqMoy;
%     dC2T=dCT.*dCT;
%     dC2MoyT=nanmean(nanmean(dC2T));
%     dC2MoyTtot=dC2MoyTtot+dC2MoyT;
% end

% vecteurs
S1=S1'/count;
S2=S2'/count;
S3=S3'/count;
S4=S4'/count;

% scalaires
dC2MoyST=dC2MoyStot'/count;
% dC2MoyTT=dC2MoyTtot'/count;

% vecteur position
dX=(Xr-1)*calib;

%% Save EVERTYHING !!
ppath=strcat(directoryAnalyse,'Corr100.mat');
save(ppath,'dX','S1','S2','S3','S4','dC2MoyST','param');

% 
% fileID=fopen(strcat(directoryAnalyse,'correlations.txt'),'w');
% fprintf(fileID,'#1-dX(mm) \t 2-5-S1234');
% for i=1:length(dX)
%     fprintf(fileID,'%6.8f \t %6.8f \t %6.8f \t %6.8f \t %6.8f',dX(i),S1(i),S2(i),S3(i),S4(i));
%     fprintf(fileID,'\n');
% end
% fclose(fileID);


dispstat('Finished.','keepprev');