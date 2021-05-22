% Avec vortex num:
mx=mx(round(end/100):end,:);
my=my(round(end/100):end,:);
% Autres:
% mx=mx(end/2:end,:);
% my=my(end/2:end,:);
[MeanSDx,~,taux]=msd(mx',dt,round(logspace(0,log10(length(mx(:,1))/1.5),300)));
[MeanSDy,~,tauy]=msd(my',dt,round(logspace(0,log10(length(my(:,1))/1.5),300)));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
mkdir(directoryPyt);
save(strcat(directoryPyt,manipCat.video{ii},'_msd','.mat'),'tau','MeanSD');
