function [S1,S2,S3,S4] = linCorrNew(im)

sizeIm=length(im);

for n=1:sizeIm
    DC=im(:,0+n:end)-im(:,1:end-n+1);
    
    S1(n)=nanmean(nanmean(DC));
    S2(n)=nanmean(nanmean(DC.^2));
    S3(n)=nanmean(nanmean(DC.^3));
    S4(n)=nanmean(nanmean(DC.^4));
    
end


end
