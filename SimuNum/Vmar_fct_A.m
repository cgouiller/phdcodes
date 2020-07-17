clear all;close all;run defaultfig;
run manips

 
    
Alist=[];
Vmlist=[];
figure;
for ii=1:nombreVid
       A=manipCat.A(ii);
    nt=manipCat.nt(ii);
    load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
    v=sqrt((mx(3:end)-mx(1:end-2)).^2+(my(3:end)-my(1:end-2)).^2)/(2*dt);
    hold on;
    plot((2:length(mx)-1)*dt,v)
    hold off;
    Alist=[Alist,A];
    Vmlist=[Vmlist,mean(v(end-50:end))];
end

figure;
plot(Alist(Vmlist<10 & Alist>0.52),Vmlist(Vmlist<10 & Alist>0.52),'+')

% Résultat du fit : Vm=2.3664*(A-0.52966)^0.57171
% donc A=(Vm/2.3664)^(1/0.57171)+0.52966
%ex: Vm=1 => A=0.7513