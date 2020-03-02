function [n,x,Mrms,Mflat,Mmean,Msqew]=hist_im(M,num,opt);

% pour un hist centré et réduit
% [n,x,Mrms,Mflat,Mmean]=hist_im(M,num,'centrereduit');
% pour un hist brut
% [n,x,Mrms,Mflat,Mmean]=hist_im(M,num,'brut');

Mmean=mean(mean(M));
Mrms=sqrt(mean(mean((M-Mmean).^2)));
Mflat=(mean(mean((M-Mmean).^4)))/Mrms^4;
Msqew=(mean(mean((M-Mmean).^3)))/Mrms^3;

switch opt

    case 'centrereduit'
     M=(M-Mmean)/Mrms;
     if length(num)==1
     minM=min(min(M));
     maxM=max(max(M));
     x=linspace(minM,maxM,num);
     else
     x=num;
     end
     n=zeros(size(x));
     for k=1:size(M,1);
     n=n+hist(M(k,:),x);
     end

    case 'log'
     minM=log10(min(min(M)));
     maxM=log10(max(max(M)));
     x=logspace(minM,maxM,num);
     n=zeros(size(x));
     for k=1:size(M,1);
     n=n+hist(M(k,:),x);
     end

    otherwise
     if length(num)==1
     minM=min(min(M));
     maxM=max(max(M));
     x=linspace(minM,maxM,num);
     else
     x=num;
     end
     n=zeros(size(x));
     for k=1:size(M,1);
     n=n+hist(M(k,:),x);
     end

end

n=n/(x(2)-x(1))/sum(n);