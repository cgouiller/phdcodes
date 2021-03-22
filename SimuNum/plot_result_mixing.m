for i=1:5
    figure;
load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd1.mat'))
plot(Cstd)
hold on;
load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd3.mat'))
plot(Cstd*9,'r')
load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd10.mat'))
plot(Cstd*100,'k')
end
nlist=[30,7,70,100,150];
figure;
for i=1:5
load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd1.mat'))
plot(nlist(i),mean(Cstd(200:end)),'+k')
hold on;
load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd3.mat'))
plot(nlist(i),mean(Cstd(200:end))*9,'ob')
load(strcat('E:\Clément\SimuNum\Resultats\210309\mixd\0',num2str(i),'_cstd10.mat'))
plot(nlist(i),mean(Cstd(200:end))*100,'xr')
end
ylim([0,4000])