%% Calcule des caractéristiques de nage, avec sans glass bubbles (angle, norme...) et les plot


clear all;
run('E:\Clément\Mixing\Matlab\manips180913.m');
% maxcat=zeros(1,10);
for numVid=2:14
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    %determine paths
%     directoryVid=strcat(basePathVidProcessed,date,set,video,'\processed\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
%     load(strcat(directoryAnalyse,'sample_bubfree'));
%     tracks_bubfree=sample;
    
    load(strcat(directoryAnalyse,'sample'));
    tracks=sample;
    
    %Calculer les vitesses le long de chaque trajectoire, puis l'angle que
    %fait la trajectoire
    tracks(:,9)=zeros(length(tracks(:,1)),1);
    tracks(:,10)=zeros(length(tracks(:,1)),1);
    tracks(:,11)=zeros(length(tracks(:,1)),1);
    tracks(:,12)=zeros(length(tracks(:,1)),1);
    sample=[];
    for i=2:length(tracks(:,1))
        if tracks(i,4)==tracks(i-1,4) && tracks(i-1,3)+1==tracks(i,3)
            tracks(i,9)=(tracks(i,1)-tracks(i-1,1))*fps;
            tracks(i,10)=(tracks(i,2)-tracks(i-1,2))*fps;
            tracks(i,11)=sqrt(tracks(i,9)*tracks(i,9)+tracks(i,10)*tracks(i,10));
            tracks(i,12)=-atan(tracks(i,10)/tracks(i,9)); %le - vient du fait que y vers le bas dans nos images
            if tracks(i,9)<0
                tracks(i,12)=tracks(i,12)+pi;
            end
            
        end
        if tracks(i,11)>100 || tracks(i,11)==0
            tracks(i,11)=NaN;
        end
    end
    
    %Pareil mais en bubble free
%     tracks_bubfree(:,9)=zeros(length(tracks_bubfree(:,1)),1);
%     tracks_bubfree(:,10)=zeros(length(tracks_bubfree(:,1)),1);
%     tracks_bubfree(:,11)=zeros(length(tracks_bubfree(:,1)),1);
%     tracks_bubfree(:,12)=zeros(length(tracks_bubfree(:,1)),1);
%     sample_bubfree=[];
%     for i=2:length(tracks_bubfree(:,1))
%         if tracks_bubfree(i,4)==tracks_bubfree(i-1,4) && tracks_bubfree(i-1,3)+1==tracks_bubfree(i,3)
%             tracks_bubfree(i,9)=(tracks_bubfree(i,1)-tracks_bubfree(i-1,1))*fps;
%             tracks_bubfree(i,10)=(tracks_bubfree(i,2)-tracks_bubfree(i-1,2))*fps;
%             tracks_bubfree(i,11)=sqrt(tracks_bubfree(i,9)*tracks_bubfree(i,9)+tracks_bubfree(i,10)*tracks_bubfree(i,10));
%             tracks_bubfree(i,12)=-atan(tracks_bubfree(i,10)/tracks_bubfree(i,9)); %le - vient du fait que y vers le bas dans nos images
%             if tracks_bubfree(i,9)<0
%                 tracks_bubfree(i,12)=tracks_bubfree(i,12)+pi;
%             end
%             
%         end
%         if tracks_bubfree(i,11)>100 || tracks_bubfree(i,11)==0
%             tracks_bubfree(i,11)=NaN;
%         end
%     end
%     
    
    %On centre les angles en 0 pour se ramener à [-pi;pi]
    tracks(:,12)=tracks(:,12)-mean(tracks(:,12));
%     tracks_bubfree(:,12)=tracks_bubfree(:,12)-mean(tracks_bubfree(:,12));
    
%     save(strcat(directoryAnalyse,'trail'),'tracks');
%     tracks=tracks_bubfree;
%     save(strcat(directoryAnalyse,'trail_bubfree'),'tracks');

%     
%     
    %Distribution des vitesses
    
    v=tracks(:,11);
    figure;
    H=histogram(v(~isnan(v)),15);
    save(strcat(directoryAnalyse,'histvitsample'),'H')
    xlabel('Vitesse (mm/s)')
    ylabel('Nombre d occurence')
%     saveas(gcf,strcat(directoryAnalyse,'histvitavecbubsamp'),'jpg')
%     [b,c]=max(H(:,2));
%     
%     while H(c,1)<1 %Pour éviter que sur les vidéos où les nageurs passent bcp de temps près des bords ce ne soit pas le max qu'on veut qui soit choisi
%         H(c,:)=[];
%         [b,c]=max(H(:,2));
%     end
%     maxcat(numVid-1)=H(c(1),1);
    
%     
%     v_bubfree=tracks_bubfree(:,11);
%     figure;
%     H_bubfree=histogram(v_bubfree(~isnan(v_bubfree)),15);
%     xlabel('Vitesse (mm/s)')
%     ylabel('Nombre d occurence')
%     save(strcat(directoryAnalyse,'histvitssbubsample'),'H_bubfree')
%     saveas(gcf,strcat(directoryAnalyse,'histvitssbubsamp'),'jpg')
%     [b_bubfree,c_bubfree]=max(H_bubfree(:,2));
    
%     while H_bubfree(c_bubfree,1)<1 %Pour éviter que sur les vidéos où les nageurs passent bcp de temps près des bords ce ne soit pas le max qu'on veut qui soit choisi
%         H_bubfree(c_bubfree,:)=[];
%         [b_bubfree,c_bubfree]=max(H_bubfree(:,2));
%     end
%     maxcat_bubfree(numVid-1)=H_bubfree(c_bubfree(1),1);
%     
    
    
    
%     %Distribution des angles
%          figure;
%         Hangle=histogram(tracks(:,12),100);
%         xlabel('Angle (rad), ref arbitraire')
%         ylabel('Nombre d occurence')
%         save(strcat(directoryAnalyse,'histangle'),'Hangle')
%         saveas(gcf,strcat(directoryAnalyse,'histangle'),'jpg')
end
%figure;
% x=[2,3,5,10,15,20,30,40,50,60];
% plot(x,maxcat,'+'); hold on;
% plot(x,maxcat_bubfree,'r+')
