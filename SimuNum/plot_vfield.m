%% Commun
run defaultfig;
N=128;
n=2;
run manips;


%% Champs de PIV

for ii=653:655
            load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_vfield.mat'))
Umoy(isfinite(Umoy)==0)=0;
Vmoy(isfinite(Vmoy)==0)=0;
quiverC2D(Y(1:n:N,1:n:N),X(1:n:N,1:n:N),Umoy(1:n:N,1:n:N),Vmoy(1:n:N,1:n:N));hold on; plot(64,64,'+k');title(manipCat.A(ii));pause;
end