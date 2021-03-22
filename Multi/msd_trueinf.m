load(strcat(directoryPyt,'trajtrueinf.mat'))

[MeanSDx,mdx,taux]=msd(xtrueinf,1/fps,1:round(length(xtrueinf)/2));
[MeanSDy,mdy,tauy]=msd(ytrueinf,1/fps,1:round(length(ytrueinf)/2));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
save(strcat(directoryPyt,'msd_trueinf.mat'),'tau','MeanSD')