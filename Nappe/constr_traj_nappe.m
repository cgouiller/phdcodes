
fprintf('Extract Positions in text files...');
fprintf('\n');

    



load(strcat(directoryVid,'positions.mat'));


%%
maxdist=10;
[tracks]=camphre_struct2pos(c,maxdist,50);


x=tracks(:,1);
y=tracks(:,2);
frame=tracks(:,3);
particle=tracks(:,4);
tracks = sortrows(tracks,4);

while tracks(1,4)==0
    tracks(1,:)=[];
end

tracks(:,5)=tracks(:,6);
tracks=tracks(:,1:5);

tracks = sortrows(tracks,4);
tracks(:,6)=nan(length(tracks(:,1)),1);
tracks(:,7)=nan(length(tracks(:,1)),1);
tracks(:,8)=nan(length(tracks(:,1)),1);
tracks(:,9)=nan(length(tracks(:,1)),1);


for i=9:(length(L)-8)
    %Repérer toutes les images correspondant à une particule
    
    if tracks(i+1,3)==tracks(i,3)+1 && tracks(i-1,3)+1==tracks(i,3)
        tracks(i,6)=(tracks(i+8,1)-tracks(i-8,1))/16;
        tracks(i,7)=(tracks(i+8,2)-tracks(i-8,2))/16;
        tracks(i,8)=sqrt(tracks(i,6)*tracks(i,6)+tracks(i,7)*tracks(i,7));
        tracks(i,9)=-atan(tracks(i,6)/tracks(i,7)); %le - vient du fait que y vers le bas dans nos images
        if tracks(i,7)<0
            tracks(i,9)=tracks(i,9)+pi;
        end
        
    end
    
end




save(strcat(directoryVid,'trajectories.mat'),'tracks')




