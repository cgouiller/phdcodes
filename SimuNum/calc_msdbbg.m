load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'mxbg','mybg');

mxbg=mxbg(round(end/3):end,1:1000);
mybg=mybg(round(end/3):end,1:1000);
[MeanSDx,~,taux]=msd(mxbg',dt,round(logspace(0,log10(length(mxbg(:,1))/1.5),300)));
[MeanSDy,~,tauy]=msd(mybg',dt,round(logspace(0,log10(length(mybg(:,1))/1.5),300)));
MeanSD=MeanSDx+MeanSDy;
tau=taux;
save(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_msdbbg','.mat'),'tau','MeanSD');
