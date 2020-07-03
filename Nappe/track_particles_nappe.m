clear c
dispstat('','init');
dispstat(sprintf('Beginning the particle detection...'),'keepthis','timestamp');
for k=1:length(L)
   % disp(round(100*k/length(L)))
    %get current image
    fname=L(k).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    
    %crop the image around the free surface of water
    
            R_range=[floor((diamvid(numVid)/2)*0.85) ceil((diamvid(numVid)/2)*1.15)];

    
    
    % Position of the camphor swimmers
    [ctmp,rtmp] = imfindcircles(im,R_range,'ObjectPolarity','bright','Method','TwoStage');
    while length(ctmp)==0
        R_range(2)=R_range(2)+5;
            [ctmp,rtmp] = imfindcircles(im,R_range,'ObjectPolarity','bright','Method','TwoStage');

    end
    c(k).x=ctmp(:,1);
    c(k).y=ctmp(:,2);
    c(k).r=rtmp;
    c(k).t=str2double(fname(4:7))/fps;
    
    % Avancement dans le traitement
    if mod(k,10)==0
   dispstat(sprintf('Progress %d%%',round(k*100/length(L))),'timestamp');
    end

end

% save the position of the camphor swimmers along the movie
save(strcat(directoryVid,'\','positions_2.mat'),'c')
% 

