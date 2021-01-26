 load(strcat(directoryAnalyse,'trajectories.mat'))
d=sqrt((tracks(:,1)-tracks(1,1)).^2+(tracks(:,2)-tracks(1,2)).^2)*calib;
[MeanSD,mdx,tau]=msd(d',1/fps,1:round(length(d)/2));
save(strcat(directoryPyt,'msd.mat'),'tau','MeanSD')