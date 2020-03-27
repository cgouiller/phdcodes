%% Sélectionne dans les trajectoires les nageurs qui peuvent être utilisés pour les calculs de concentration moyenne autour (ceux qui sont suffisamment loin des autres)
load(strcat(directoryAnalyse,'trajectories.mat'))

dispstat('','init');
dispstat(sprintf('Begining the trajectory analysis...'),'keepthis','timestamp');

R=sizeim/2*calib;
sample=[];


for i=1:length(tracks(:,1))
    if mod(i,100)==0
        dispstat(sprintf('Progress %i%%',round(i*100/(length(tracks(:,1))))),'timestamp');
    end
    
    samp=tracks(tracks(:,3)==tracks(i,3),1:2);
    test=1;
    
    if isnan(tracks(i,8))==0
        test=0;
        %On définit le rectangle dans lequel les particules ne doivent pas être
        %             xv=[tracks(i,1)+9*cos(tracks(i,12))-14*sin(tracks(i,12)),tracks(i,1)+9*cos(tracks(i,12))+14*sin(tracks(i,12)),tracks(i,1)-32*cos(tracks(i,12))+14*sin(tracks(i,12)),tracks(i,1)-32*cos(tracks(i,12))-14*sin(tracks(i,12))];
        %             yv=[tracks(i,2)+14*cos(tracks(i,12))+9*sin(tracks(i,12)),tracks(i,2)+9*sin(tracks(i,12))-14*cos(tracks(i,12)),tracks(i,2)-14*cos(tracks(i,12))-32*sin(tracks(i,12)),tracks(i,2)+14*cos(tracks(i,12))-32*sin(tracks(i,12)),];
        xv=[tracks(i,1)+6*cos(tracks(i,9))-10*sin(tracks(i,9)),tracks(i,1)+6*cos(tracks(i,9))+10*sin(tracks(i,9)),tracks(i,1)-20*cos(tracks(i,9))+10*sin(tracks(i,9)),tracks(i,1)-20*cos(tracks(i,9))-10*sin(tracks(i,9))];
        yv=[tracks(i,2)+10*cos(tracks(i,9))+6*sin(tracks(i,9)),tracks(i,2)+6*sin(tracks(i,9))-10*cos(tracks(i,9)),tracks(i,2)-10*cos(tracks(i,9))-20*sin(tracks(i,9)),tracks(i,2)+10*cos(tracks(i,9))-20*sin(tracks(i,9)),];
        
        for j=1:length(samp(:,1))
            if inpolygon(samp(j,1),samp(j,2),xv,yv) && samp(j,1)~=tracks(i,1)
                test=1;
            end
        end
        
        dCenter=sqrt((tracks(i,1)-R)^2+(tracks(i,2)-R)^2);
        if dCenter<65 && test==0
            sample=[sample;tracks(i,:)];
        end
    end
end
load(strcat(directoryAnalyse,'directory.mat'));

time=zeros(1,length(L));
for k=startImg:length(L)
    % Open the image and calculate the concentration field
    fname=L(k).name;
    
    time(k)=str2double(fname(1:7))/fps;
    
end
sample(:,3)=sample(:,3)+find(time==55*60)-1;
save(strcat(directoryAnalyse,'particules_selectionnees.mat'),'sample')

%Parmi les présentes à chaque frame, regarder celles qui sont assez
%loin du bord et de leurs voisines. Les sauvegarder.

%Les envoyer dans measure trail