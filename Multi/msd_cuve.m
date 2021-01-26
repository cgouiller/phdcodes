 load(strcat(directoryAnalyse,'trajectories.mat'))
[MeanSDx,mdx,taux]=msd(tracks(:,1)',1/fps,1:round(length(tracks(:,1))/2));
[MeanSDy,mdy,tauy]=msd(tracks(:,2)',1/fps,1:round(length(tracks(:,2))/2));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
save(strcat(directoryPyt,'msd.mat'),'tau','MeanSD')