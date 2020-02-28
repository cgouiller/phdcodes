function [tracks]=camphre_struct2pos(c,maxdist,longueur)

% Utilisé pour analyser les trajectoires de nageurs à partir des positions

% on a une structure qu'on concatene

for k=1:length(c)
    ll(k)=length(c(k).x);
end
lt=sum(ll);

x=zeros(lt,1);
y=zeros(lt,1);
t=zeros(lt,1);
r=zeros(lt,1);
nt=0;
for k=1:length(c)
    xtmp=c(k).x;
    ytmp=c(k).y;
    time=k*ones(size(xtmp));
    rtmp=c(k).r;
    
    nn=length(xtmp);
    x(1+nt:nt+nn,1)=xtmp;
    y(1+nt:nt+nn,1)=ytmp;
    t(1+nt:nt+nn,1)=time;
    r(1+nt:nt+nn,1)=rtmp;
    nt=nt+nn;
end

pos=[x y t r];

[~,tracks,~]=track2d(pos,maxdist,longueur);



