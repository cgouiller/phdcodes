 load(strcat(directoryAnalyse,'trajectories.mat'))
% d=sqrt((tracks(:,1)-tracks(1,1)).^2+(tracks(:,2)-tracks(1,2)).^2)*calib;
% [MeanSD,mdx,tau]=msd(d',1/fps,1:round(length(d)/3));
% save(strcat(directoryAnalyse,'msd.mat'),'tau','MeanSD')

dtot=zeros(1,length(tracks));
for k=2:length(tracks)
    dtot(k)=dtot(k-1)+sqrt((tracks(k,1)-tracks(k-1,1)).^2+(tracks(k,2)-tracks(k-1,2)).^2)*calib;
end
[MeanSDtot,mdxtot,tautot]=msd(dtot,1/fps,1:round(length(dtot)/3));
save(strcat(directoryAnalyse,'msd_tot.mat'),'tautot','MeanSDtot')
