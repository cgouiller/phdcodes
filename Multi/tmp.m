xc=[];
yc=[];
t=[];
for i=startImg:length(c)
    xc=[xc,c(i).x];
    yc=[yc,c(i).y];
    t=[t,c(i).t];
end
figure;
plot(xc,yc)