
function [Espc,Frecs,df]=spectre_burgete(b,fech);

% [s,f]=spectre_burgete(b,fech);

brms2=mean((b-mean(b)).^2);

tfS=fft(b);
TMAX=length(b)/fech;
    Serie=abs(tfS).^2;
    L=length(Serie)/2;
    F=1.05;
    Ni=floor(log10(L*(F-1)+1)./log10(F));
    U=floor(F.^(1:Ni-1));
    Comienzos=cumsum(U);
    clear Espc Frecs
    for i=1:length(U);
        Espc(i)=sum(Serie(Comienzos(i)+1:Comienzos(i)+U(i)))/U(i);
        Frecs(i)=(sum(Comienzos(i)+1:Comienzos(i)+U(i))-1)/U(i)./TMAX;
    end
    
    df=gradient(Frecs);
    rmsEspcs=sum(Espc.*df);%*mean(df);%.*df);
    
    Espc=Espc/rmsEspcs*brms2;
    
    
    

