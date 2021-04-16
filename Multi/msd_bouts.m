load(strcat(directoryPyt,'boutstraj.mat'))
MSDfinx=zeros(1,round(length(boutstrajx(1,:))/2));
MSDfiny=zeros(1,round(length(boutstrajx(1,:))/2));
cptmsd=zeros(1,round(length(boutstrajx(1,:))/2));

for i=1:length(boutstrajx(:,1))
    miniboutx=boutstrajx(i,:);
    minibouty=boutstrajy(i,:);
    nantest=find(miniboutx~=miniboutx);
    if isempty(find(miniboutx~=miniboutx))
        lastok=length(miniboutx);
    else
        lastok=nantest(1)-1;
    end
    [MeanSDx,mdx,taux]=msd(miniboutx(1:lastok),1/fps,1:round(length(miniboutx(1:lastok))/2));
    [MeanSDy,mdy,tauy]=msd(minibouty(1:lastok),1/fps,1:round(length(minibouty(1:lastok))/2));
    MSDfinx(1:round(length(miniboutx(1:lastok))/2))=MSDfinx(1:round(length(miniboutx(1:lastok))/2))+MeanSDx;
    MSDfiny(1:round(length(miniboutx(1:lastok))/2))=MSDfiny(1:round(length(miniboutx(1:lastok))/2))+MeanSDy;
    cptmsd(1:round(length(miniboutx(1:lastok))/2))=cptmsd(1:round(length(miniboutx(1:lastok))/2))+1;
end
MeanSDx=MSDfinx./cptmsd;
MeanSDy=MSDfiny./cptmsd;
MeanSD=MeanSDx+MeanSDy;
tau=linspace(1,round(length(boutstrajx(1,:))/2),round(length(boutstrajx(1,:))/2))/fps;
save(strcat(directoryPyt,'msd_bouts.mat'),'tau','MeanSD')