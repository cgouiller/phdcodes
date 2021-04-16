mxbg=mxbg(4000:end,:);
mybg=mybg(4000:end,:);
[MeanSDx,~,taux]=msd(mxbg',dt,round(logspace(0,log10(length(mxbg(:,1))/1.5),50)));
[MeanSDy,~,tauy]=msd(mybg',dt,round(logspace(0,log10(length(mybg(:,1))/1.5),50)));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
save(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_msd','.mat'),'tau','MeanSD');
