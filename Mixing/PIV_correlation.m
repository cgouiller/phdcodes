
%Information message, saved with datas
param='sur 200 images sans corrections de bg';

%Determine path
directoryVid=strcat(basePathVid,date,set,video,'\');
directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
directoryPiv=strcat(basePathAnalyse,date,set,video,'\PIV_fullimg_noisy\');


L=dir(strcat(directoryPiv,'*.mat'));


%% Initializations

% initialization of the timestamp
dispstat('','init');
dispstat(sprintf('Begining the process for the movie...'),'keepthis','timestamp');

%variables
count=0;
S1u=0;
S2u=0;
S3u=0;
S4u=0;
S1v=0;
S2v=0;
S3v=0;
S4v=0;
 calxy=0.000151943077255372; %Pour PIV_fullimg
 caluv=0.00303886154510745;
% dC2MoyStot=0;
% sizesquare=zeros(sizeim,sizeim); %sizeim is the size of the circle, which is savev in the manips file
% sizesquaresq=sizesquare(ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4),ceil(sizeim/2-sqrt(2)*sizeim/4):floor(sizeim/2+sqrt(2)*sizeim/4)); %Square of interest
% CfieldSqtot=zeros(length(sizesquaresq),length(sizesquaresq));


% %Load position of swimmers
% a=load(strcat(directoryAnalyse,num2str(video),'_positions.mat'));
% c=a.c;
%     
% %Load background image
% imbg=load(strcat(directoryAnalyse,'imbg'));
% imbg=imbg.im0;

%Beginning and end of the study
% startCorr=round(startCatalogue(numVid)*fps);
% endCorr=round(endCatalogue(numVid)*fps);

%% big loop over 200 images in the range of processed image in the stationnary zone

for k=1:length(L)
    count=count+1;
    
    %Calculate the concentration field
    fname=L(k).name;
    load(strcat(directoryPiv,fname));
    
    X=(x-max(max(x))/2)*calxy*1000;%en mm
    Y=(y-max(max(y))/2)*calxy*1000;%en mm
    
    
    U=u*caluv*1000;%en mm/s
    V=v*caluv*1000;%en mm/s

    
    
    % Get the moments of the image
    [S1t,S2t,S3t,S4t] = linCorrNew(U-nanmean(nanmean(U)));
    
    S1u=S1u+S1t;
    S2u=S2u+S2t;
    S3u=S3u+S3t;
    S4u=S4u+S4t;
    
     [S1t,S2t,S3t,S4t] = linCorrNew(V-nanmean(nanmean(V)));
    
    S1v=S1v+S1t;
    S2v=S2v+S2t;
    S3v=S3v+S3t;
    S4v=S4v+S4t;
    
%     %Pour faire la moyenne spatiale
%     CMoyS=nanmean(nanmean(CfieldSq));
%     dCS=CfieldSq-CMoyS;
%     dC2S=dCS.*dCS;
%     dC2MoyS=nanmean(nanmean(dC2S));
%     dC2MoyStot=dC2MoyStot+dC2MoyS;
    

    

% timer
dispstat(sprintf('Progress %d%%',round((k)*100/(500))),'timestamp');
    
end




% vecteurs
S1u=S1u'/count;
S2u=S2u'/count;
S3u=S3u'/count;
S4u=S4u'/count;
S1v=S1v'/count;
S2v=S2v'/count;
S3v=S3v'/count;
S4v=S4v'/count;

% scalaires
% dC2MoyST=dC2MoyStot'/count;


% vecteur position
% Xr=1:length(CfieldSq);
% dX=(Xr-1)*calib;

%% Save EVERTYHING !!
ppath=strcat(directoryAnalyse,'Piv_corr.mat');
save(ppath,'X','Y','S1u','S2u','S3u','S4u','S1v','S2v','S3v','S4v','param');




dispstat('Finished.','keepprev');