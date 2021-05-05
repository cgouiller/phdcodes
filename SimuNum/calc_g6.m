%calc_g6
load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_p6.mat'))
inc=round(logspace(log10(1),log10(round(length(p6list(:,1))/4)),300));
Nmax=length(inc);
g6=zeros(1,Nmax);
tau=inc*(tlist(2)-tlist(1))*manipCat.dt(ii);
norm=mean(mean(abs(p6list).^2));
for k=1:length(inc) 
    num=p6list(1+inc(k):end,:).*conj(p6list(1:end-inc(k),:));
    g6(k)=real(mean(mean(num))/norm);
end
        directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');

save(strcat(directoryPyt,manipCat.video{ii},'_g6.mat'),'g6','tau');
