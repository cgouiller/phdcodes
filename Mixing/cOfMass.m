%% Pour l'étude d'effets collectifs, trace le déplacement du centre de masse des nageurs

clear all;

fprintf('Center of Mass Analysis...');
fprintf('\n');

run('E:\Laurent\Mixing\Matlab\manips180329.m');
param='que sur la zone stationnaire et valeurs en mm';
%%
for numVid=2:11
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVidProcessed,date,set,video,'\processed\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    
    a=load(strcat(directoryAnalyse,num2str(video),'_positions.mat'));
    c=a.c;
    numberFrame=length(c);
    cOfMassX=zeros(numberFrame,1);
    cOfMassY=zeros(numberFrame,1);
    cOfMassXstd=zeros(numberFrame,1);
    cOfMassYstd=zeros(numberFrame,1);
    time=zeros(numberFrame,1);
    
    for i=1:numberFrame
        cOfMassX(i)=mean(c(i).x);
        cOfMassY(i)=mean(c(i).y);
        cOfMassXstd(i)=std(c(i).x);
        cOfMassYstd(i)=std(c(i).y);
        time(i)=c(i).t;
    end
  
    save(strcat(directoryAnalyse,'cOfMass.mat'),'time','param','cOfMassX','cOfMassY','cOfMassXstd','cOfMassYstd')

    
end
