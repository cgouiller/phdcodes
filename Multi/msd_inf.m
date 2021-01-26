load(strcat(directoryPyt,'infinitetraj.mat'))

[MeanSDx,mdx,taux]=msd(xinf,1/fps,1:round(length(xinf)/2));
[MeanSDy,mdy,tauy]=msd(yinf,1/fps,1:round(length(yinf)/2));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
save(strcat(directoryPyt,'msd_inf.mat'),'tau','MeanSD')