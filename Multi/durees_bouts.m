load(strcat(directoryPyt,'boutstraj.mat'))
durees=[];
for i=1:length(boutstrajx(:,1))
    miniboutx=boutstrajx(i,:);
    minibouty=boutstrajy(i,:);
    nantest=find(miniboutx~=miniboutx);
    if isempty(find(miniboutx~=miniboutx))
        lastok=length(miniboutx);
    else
        lastok=nantest(1)-1;
    end
    durees=[durees,(lastok-1)];
end
durees=durees/10; %fps
save(strcat(directoryPyt,'duree_bouts.mat'),'durees')