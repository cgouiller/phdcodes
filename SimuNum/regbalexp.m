
Npart = [1 5 10 20 29 30 43 50];
px = [.29 .29 .29 .29 .23 .29 .23 .29];
vcar=zeros(1,8);
errs=zeros(1,8);
for i=1:8
    x=(lagStats(i).MSDx.tau)/30;
    y=(lagStats(i).MSDx.mean+lagStats(i).MSDy.mean).*px(i)^2;
    y=y(x<0.5);
    x=x(x<0.5);
    P=polyfit(x.^2,y,1);
    vcar(i)=sqrt(P(1));
    errs(i)=sqrt(P(1))
end
plot(Npart,vcar,'+')