
fprintf('Video ');
fprintf(video(1:length(video)-1));
fprintf('\n');

%%
% get the list of images in the movie
load(strcat(directoryAnalyse,'directory.mat'));

c=struct(); % a structure to get the positions of the camphors


%%

%initialisation of the timer for the movie
dispstat('','init');
dispstat(sprintf('Begining the process for the movie...'),'keepthis','timestamp');



% loop over the images to be considered (after the insertion of the glass
% bubbles)
for k=startImg:length(L)
    if k>length(c)
        
        l(k)=0;
    end
    s=0.8;
    
    while l(k)<1 && s<1
        
        
    %get current image
    fname=L(k).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    
  
    % Position of the camphor swimmers
    [ctmp,rtmp] = imfindcircles(im>250,R_range,'ObjectPolarity','bright','Method','TwoStage','Sensitivity',0.9); 
    if isempty(ctmp)==0
        c(k).x=ctmp(:,1)*calib;
        c(k).y=ctmp(:,2)*calib;
        c(k).r=rtmp*calib;
        c(k).t=str2double(fname(1:7))/fps;
         
   

    end
    % Avancement dans le traitement
    if mod(k,1)==0
        dispstat(sprintf('Progress %i%%',round((k-startImg)*100/(length(L)-startImg))),'timestamp');
    end
    l(k)=length(c(k).x);
    s=s+0.03;
    end
end

% save the position of the camphor swimmers along the movie
save(strcat(directoryAnalyse,'\','positions.mat'),'c')
% 
dispstat('Finished.','keepprev');