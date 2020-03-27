
fprintf('Video ');
fprintf(video(1:length(video)-1));
fprintf('\n');


%%
% get all files in the background directory
Lbg=dir(strcat(directoryBg,format));
% a typical image to get its size
fname=Lbg(1).name;
fnamecompl=strcat(directoryBg,fname);
im0=imread(fnamecompl);

im0=zeros(size(im0));

%timer initialisation for the background
dispstat('','init');
dispstat(sprintf('Beginning the process for the background...'),'keepthis','timestamp');

%loop over the images of the background
for k=1:length(Lbg)
    %get the current image
    fname=Lbg(k).name;
    fnamecompl=strcat(directoryBg,fname);
    im=double(imread(fnamecompl));
   
    im0=im0+im;
    
    if mod(k,10)==0
        dispstat(sprintf('Progress %d%%',round(k*100/length(Lbg))),'timestamp');
    end
    
end
%divide the resulting image by the number of images
im0=im0/k;
%crop it around the free surface of water
im0=im0(round(centerCellYBg-radiusCellPxBg):round(centerCellYBg+radiusCellPxBg),round(centerCellXBg-radiusCellPxBg):round(centerCellXBg+radiusCellPxBg));
save(strcat(directoryAnalyse,'\im0'),'im0')
dispstat('Finished.','keepprev');


%%
% get the list of images in the movie
          load(strcat(directoryAnalyse,'directory.mat'));

c=struct(); % a structure to get the positions of the camphors

% create a mask of nans out of the free surface of water and ones inside
immask=nanOutCircle(ones(length(im0)),round(length(im0)/2),round(length(im0)/2),round(length(im0)/2));

%%

%initialisation of the timer for the movie
dispstat('','init');
dispstat(sprintf('Begining the process for the movie...'),'keepthis','timestamp');



% loop over the images to be considered (after the insertion of the glass
% bubbles)

for k=startImg:length(L)
    
    %get current image
    fname=L(k).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    
    %crop the image around the free surface of water
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    im=nanOutCircle(im,radiusCellPx,radiusCellPx,radiusCellPx);
    % Position of the camphor swimmers
    [ctmp,rtmp] = imfindcircles(im,R_range,'ObjectPolarity','dark','Method','TwoStage'); % Sensi augmentée à 0.87 pour les R=1 mm
    c(k).x=ctmp(:,1)*calib;
    c(k).y=ctmp(:,2)*calib;
    c(k).r=rtmp*calib;
    c(k).t=str2double(fname(1:7))/fps;
        %imagesc(im);hold on;title(length(c(k).x));plot(c(k).x/calib,c(k).y/calib,'+w')

    % Avancement dans le traitement
    if mod(k,1)==0
        dispstat(sprintf('Progress %i%%',round((k-startImg)*100/(length(L)-startImg))),'timestamp');
    end
pause(0.001)
end

% save the position of the camphor swimmers along the movie
save(strcat(directoryAnalyse,'\','positions.mat'),'c')
% 
dispstat('Finished.','keepprev');