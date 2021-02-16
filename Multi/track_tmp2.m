
fprintf('Video ');
fprintf(video(1:length(video)-1));
fprintf('\n');

%%
% get the list of images in the movie
load(strcat(directoryAnalyse,'directory.mat'));
load(strcat(directoryAnalyse,'\','positions.mat'))
load(strcat(directoryAnalyse,'\','trajectories.mat'))
%%

%initialisation of the timer for the movie
dispstat('','init');
dispstat(sprintf('Begining the process for the movie...'),'keepthis','timestamp');



% loop over the images to be considered (after the insertion of the glass
% bubbles)
for k=2:length(c)-1
    analyse=0;
     if isempty(tracks(tracks(:,3)==k,4)) || isempty(tracks(tracks(:,3)==k+1,4)) || isempty(tracks(tracks(:,3)==k-1,4)) || length(c(k).x)~=1 || length(tracks(tracks(:,3)==(k+1),4))>1 || length(tracks(tracks(:,3)==(k),4))>1 || length(tracks(tracks(:,3)==(k-1),4))>1
         analyse=1;
     elseif (tracks(tracks(:,3)==k,4))~=(tracks(tracks(:,3)==(k-1),4)) || (tracks(tracks(:,3)==k,4))~=(tracks(tracks(:,3)==(k+1),4))
    analyse=1;
     end
  
    if analyse==1
        s=0.7;
        ctmp=[];
        while s<1 && isempty(ctmp)
            
            
            %get current image
            fname=L(k).name;
            fnamecompl=strcat(directoryVid,fname);
            im=double(imread(fnamecompl));
            
            
            % Position of the camphor swimmers
            [ctmp,rtmp] = imfindcircles(im>250,[20 35],'ObjectPolarity','bright','Method','TwoStage','Sensitivity',s);
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
            s=s+0.05;
        end
    end
end

% save the position of the camphor swimmers along the movie
save(strcat(directoryAnalyse,'\','positions.mat'),'c')
%
dispstat('Finished.','keepprev');