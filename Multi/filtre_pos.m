load(strcat(directoryAnalyse,'\positions.mat'));
for kk=startImg+1:length(c)
    if length(c(kk).x)>1
        mind=1000000;
        xrepl=0;
        yrepl=0;
        rrepl=0;
        for jj=1:length(c(kk).x)
            dtmp=(c(kk).x(jj)-c(kk-1).x)^2+(c(kk).x(jj)-c(kk-1).x)^2;
            if dtmp<mind
                xrepl=c(kk).x(jj);
                yrepl=c(kk).y(jj);
                rrepl=c(kk).r(jj);

            end
        end
        c(kk).x=xrepl;
        c(kk).y=yrepl;
        c(kk).r=yrepl;

        
    end
end
save(strcat(directoryAnalyse,'\','positions.mat'),'c')

constr_traject;  
load(strcat(directoryAnalyse,'\positions.mat'));

for kk=1:max(tracks(:,4))
    if length(find(tracks(:,4)==kk))==1 && (tracks(find(tracks(:,4)==kk),3)~=max(tracks(:,3)))
        c(tracks(find(tracks(:,4)==kk),3)).x=mean([c(tracks(find(tracks(:,4)==kk),3)+1).x,c(tracks(find(tracks(:,4)==kk),3)-1).x]);
        c(tracks(find(tracks(:,4)==kk),3)).y=mean([c(tracks(find(tracks(:,4)==kk),3)+1).y,c(tracks(find(tracks(:,4)==kk),3)-1).y]);

    end
end

save(strcat(directoryAnalyse,'\','positions.mat'),'c')
constr_traject;
load(strcat(directoryAnalyse,'trajectories.mat'))

for kk=1:max(tracks(:,4))
    if length(find(tracks(:,4)==kk))==1 
        tracks(find(tracks(:,4)==kk),:)=[];
    end
end

save(strcat(directoryAnalyse,'trajectories.mat'),'tracks')
