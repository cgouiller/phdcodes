d=sqrt((tracks(:,1)-tracks(1,1)).^2+(tracks(:,2)-tracks(1,2)).^2);
[MeanSD,mdx,tau]=msd(d',1/fps,1:round(length(d)/3));