load(manipCat{i});
clear Ec
tracks=[];
for j=1:npart
    newpart=ma.tracks{j};
    for k=2:length(newpart)-1
        newpart(k,4)=(newpart(k+1,2)-newpart(k-1,2))/(newpart(k+1,1)-newpart(k-1,1));
        newpart(k,5)=(newpart(k+1,3)-newpart(k-1,3))/(newpart(k+1,1)-newpart(k-1,1));
        newpart(k,7)=(newpart(k+1,4)-newpart(k-1,4))/(newpart(k+1,1)-newpart(k-1,1));
        newpart(k,8)=(newpart(k+1,5)-newpart(k-1,5))/(newpart(k+1,1)-newpart(k-1,1));
    end
    newpart(length(newpart),4)=NaN;
    newpart(length(newpart),5)=NaN;
    newpart(:,6)=sqrt(newpart(:,4).^2+newpart(:,5).^2);
    
    tracks=[tracks;newpart];
    
end
for k=1:length(newpart)
    Ec(k)=1/2*sum(tracks(tracks(:,1)==tracks(k,1),6).^2);
end
Ec=Ec/npart;
mamsd=ma.getMeanMSD;
dt=mamsd(:,1);
%
[countx,binx]=hist_maison((tracks(:,4)-nanmean2(tracks(:,4)))/nanstd(tracks(:,4)),-5,5,101,1);
[county,biny]=hist_maison((tracks(:,5)-nanmean2(tracks(:,5)))/nanstd(tracks(:,5)),-5,5,101,1);
[countax,binax]=hist_maison((tracks(:,7)-nanmean2(tracks(:,7)))/nanstd(tracks(:,7)),-5,5,101,1);
[countay,binay]=hist_maison((tracks(:,8)-nanmean2(tracks(:,8)))/nanstd(tracks(:,8)),-5,5,101,1);
save(strcat(manipCat{i}(1:end-4),'_analyze.mat'),'dt','Ec','tracks','countx','county','countax','countay','binx','biny','binax','binay')
