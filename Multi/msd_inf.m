load(strcat(directoryPyt,'infinitetraj.mat'))

dtot=zeros(1,length(xinf));
for k=1:length(xinf)
    dtot(k)=sqrt((xinf(k)-xinf(1))^2+(yinf(k)-yinf(1))^2);
end

[MeanSD,mdx,tau]=msd(dtot,1,1:round(length(dtot)/1.5));
save(strcat(directoryPyt,'msd_inf.mat'),'tau','MeanSD')
