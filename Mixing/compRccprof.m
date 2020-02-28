%% Compare les échelles caractéristiques issues de Rcc avec les tailles caractéristique de zone de déplétion moyenne par exemple

clear all;
basePathAnalyse='E:\Laurent\Mixing\Analyse\';
run('E:\Laurent\Mixing\Matlab\manips180329.m');
load('E:\Laurent\Mixing\Analyse\180329\varNumber_large\echellesRcc')
run('E:\Laurent\Mixing\Analyse\180329\varNumber_large\dataetudeprof.m')

L_inred=[L_in(5:9),L_in(11)];
largell=[78,71,60,56,46,41]; %N=10,15,20,30,40,60
longell=[161,149,128,108,70,48];
aireell=sqrt(largell.*longell);
meanv=zeros(1,11);
for numVid=2:11
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    load(strcat(directoryAnalyse,'sample.mat'))
    meanv(numVid)=nanmean(sample(:,11));
end
N=[0;2;3;5;10;15;20;30;40;50;60];


Prof=[];
asym=[];
for numVid=2:11
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVidProcessed,date,set,video,'\processed\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    load(strcat(directoryAnalyse,'meanTrail.mat'));
    Prof=[Prof, improfile(immoy,round(length(immoy)/2)*ones(length(immoy),1),1:length(immoy))];
    temp=improfile(immoy,round(length(immoy)/2)*ones(length(immoy),1),1:length(immoy));
    asym=[asym, nanmean(((temp(isnan(temp)==0)-nanmean(temp))/var(temp(isnan(temp)==0))).^3)];
%     hold on;
%     color_line((1:length(immoy)).*calib,Prof,ones(1,length(1:length(immoy))).*numVid);
%     hold off;

end

pentesim=[0,-1.94,-1.81,-1.97,-1.79,-1.61,-1.56,-1.57,-1.44,-1.39,-1.35];
pentesimseuil=[0,-1.7,-1.5,-1.72,-1.66,-1.4,-1.3,-1.25,-1.07,-0.89,-0.99];
