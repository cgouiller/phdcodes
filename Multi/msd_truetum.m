load(strcat(directoryPyt,'trajtruetumble.mat'))

[MeanSDx,mdx,taux]=msd(xtum,1/fps,1:round(length(xtum)/2));
[MeanSDy,mdy,tauy]=msd(ytum,1/fps,1:round(length(ytum)/2));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
save(strcat(directoryPyt,'msd_truetum.mat'),'tau','MeanSD')