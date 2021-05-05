 load(strcat(directoryPyt,'positions.mat'))
[MeanSDx,mdx,taux]=msd(x',1/fps,1:round(length(x)/2));
[MeanSDy,mdy,tauy]=msd(y',1/fps,1:round(length(y)/2));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
save(strcat(directoryPyt,'msd.mat'),'tau','MeanSD')