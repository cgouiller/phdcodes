
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
    if k>=length(c)
        c(k).x=[];
        c(k).y=[];
        c(k).t=[];
        c(k).r=[];
        l(k)=0;
    end
    s=0.84;
   
    while l(k)<1 && s<1
        
        
    %get current image
    fname=L(k).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    
  
    % Position of the camphor swimmers
    if numVid<93 || numVid>95
        [ctmp,rtmp] = imfindcircles(im>250,R_range,'ObjectPolarity','bright','Method','TwoStage','Sensitivity',s); 
    else
        [ctmp,rtmp] = imfindcircles(im>200,[25 35],'ObjectPolarity','bright','Method','TwoStage','Sensitivity',s); 
    end
    if isempty(ctmp)==0
        c(k).x=ctmp(:,1);
        c(k).y=ctmp(:,2);
        c(k).r=rtmp;
        c(k).t=str2double(fname(1:7))/fps;
         
   

    end
    % Avancement dans le traitement
    if mod(k,1)==0
        dispstat(sprintf('Progress %i%%',round((k-startImg)*100/(length(L)-startImg))),'timestamp');
    end
    l(k)=length(c(k).x);
    s=s+0.05;
    end
end

% save the position of the camphor swimmers along the movie
save(strcat(directoryAnalyse,'\','positions.mat'),'c')
% 
dispstat('Finished.','keepprev');