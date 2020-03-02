function b = radialCorr(logim,X,Y,vecDist)

vectDist=vecDist;
pairCorr=zeros(length(vectDist),2);
logim2=logim(1:10:end,1:10:end);
size=length(logim2);

for i=1:size
    for j=1:size
        if isnan(logim2(i,j))~=1
            logim3=logim2*logim2(i,j);
            matDiff=sqrt(abs(X-i).*abs(X-i)+abs(Y-j).*abs(Y-j));
            %corrLocal=logim2.*matDiff;

            tableDiffCorr=[reshape(matDiff,[size*size,1]) reshape(logim3,[size*size,1])];
            tableDiffCorr=tableDiffCorr(isnan(tableDiffCorr(:,2))~=1,:);
            for n=1:length(vectDist)
                tttt=tableDiffCorr(tableDiffCorr(:,1)==vectDist(n),2);
                pairCorr(n,1)=pairCorr(n,1)+sum(tttt);
                pairCorr(n,2)=pairCorr(n,2)+length(tttt);
            end
        end
    end
end

b=pairCorr(:,1)./pairCorr(:,2);

end