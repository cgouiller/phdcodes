load(strcat(directoryPyt,'boutstraj.mat'))

vlist=[];

for i=1:length(boutstrajx(:,1))
    miniboutx=boutstrajx(i,:);
    minibouty=boutstrajy(i,:);
    nantest=find(miniboutx~=miniboutx);
    if isempty(find(miniboutx~=miniboutx))
        lastok=length(miniboutx);
    else
        lastok=nantest(1)-1;
    end
    boutx=miniboutx(1:lastok);
    bouty=minibouty(1:lastok);
    vlist=[vlist,sqrt((boutx(2:end)-boutx(1:end-1)).^2+(bouty(2:end)-bouty(1:end-1)).^2)*fps];
    
end

save(strcat(directoryPyt,'vlist.mat'),'vlist')