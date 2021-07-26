clear all;
run manips190220;
cm=parula(256);
%figure;

for numVid=1

    %% Chargement des données utiles
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    startImg=startImgCatalogue(numVid);
    endImg=endImgCatalogue(numVid);
    vitesse=speedCat(numVid);
    taille=RCat(numVid);
    
    % build paths and create directories
    directoryVid=strcat(basePathVid,date,sete,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,'\',date,sete,video,'\');
    directoryBg=strcat(basePathVid,date,sete,'bg\');
    centerCellX=centerCellXCat(numVid)+radiusCellPx;
    centerCellY=centerCellYCat(numVid)+radiusCellPx;
    R_range=[floor(RCat(numVid)*0.9/calib) ceil(RCat(numVid)*1.1/calib)];
    %% Déterminer ou charger les positions
   track_particles;
     load(strcat(directoryAnalyse,num2str(numVid),'positions.mat'))
     
     %% Tracer la probabilité d'être à une certaine distance
     X=[];
     Y=[];
%     
    for numImg=startImg:endImg
        X=[X;c(numImg).x];
        Y=[Y;c(numImg).y];
    end
    radiusCellMm=radiusCellPx*180/1671;
     D=sqrt((X-radiusCellMm).^2+(Y-radiusCellMm).^2);
     R=D;
%     T=atan((Y-90)./(X-90));
%     T(X<90)=T+pi;
%     T=T*180/pi;
%     
%     
nbar=10;
if numVid==4
    tabval=zeros(nbar,6);
end
    
    [valeurs,positions]=hist_maison(D,0,90,nbar,1); %function [counts,bins] = hist_maison(image,inf,sup,nbbins,norm)
    valeurscor=zeros(1,length(valeurs));
    for i=1:length(valeurs)
        valeurscor(i)=valeurs(i)/(pi*(i*90/nbar)^2-pi*((i-1)*(90/nbar))^2);
    end
     tabval(:,j)=valeurscor;
    hold on;    
    plot(positions,valeurscor,'Color',cm(floor(taille*255/4)+1,:),'LineWidth',3);
   
  xlabel('Distance au centre [mm]') 
  ylabel('Probabilité de présence d''un nageur')
  colorbar;
  colormap parula(256);
  %%  Etudier le sens de rotation des nageurs
  
%    a=load(strcat(directoryAnalyse,num2str(numVid),'positions.mat'));
%    
%     a=a.c;
%     a=a(startImg:length(a));
%     clear tracks
%     maxdist=6;
%     [tracks]=camphre_struct2pos(a,maxdist,5);
%     
%     x=tracks(:,1);
%     y=tracks(:,2);
%     frame=tracks(:,3);
%     particle=tracks(:,4);
%     tracks = sortrows(tracks,4);
% tracks(:,5:8)=[];
% 
%     while tracks(1,4)==0
%         tracks(1,:)=[];
%     end
%     %tttable=[x,y,frame,particle];
%     %dlmwrite(strcat(directoryAnalyse,'\positionsCamphres.txt'),tttable,'delimiter','\t','precision','%.5f');
%     tracks(:,5)=zeros(length(tracks(:,1)),1);
%     tracks(:,6)=zeros(length(tracks(:,1)),1);
%     tracks(:,7)=zeros(length(tracks(:,1)),1);
%     tracks(:,8)=zeros(length(tracks(:,1)),1);
%      
%     radiusCellMm=radiusCellPx*180/sizeim;
%    tracks(:,9)=sqrt((tracks(:,1)-radiusCellMm).^2+(tracks(:,2)-radiusCellMm).^2);
%      
%      tracks(:,10)=atan((tracks(:,2)-90)./(tracks(:,1)-90));
%     
%      
%     
%     for i=2:length(tracks(:,1))-1
%         if tracks(i,1)-90<0
%             tracks(i,10)=tracks(i,10)+pi;
%         end
%         if  tracks(i-1,3)+1==tracks(i,3) && tracks(i+1,4)==tracks(i-1,4)
%             tracks(i,5)=(tracks(i+1,1)-tracks(i-1,1))*fps/2;
%             tracks(i,6)=(tracks(i+1,2)-tracks(i-1,2))*fps/2;
%             tracks(i,7)=sqrt(tracks(i,5)*tracks(i,5)+tracks(i,6)*tracks(i,6));
%             tracks(i,8)=-atan(tracks(i,5)/tracks(i,6)); %le - vient du fait que y vers le bas dans nos images
%             if tracks(i,6)<0
%                 tracks(i,8)=tracks(i,8)+pi;
%             end
%             tracks(i,11)=(tracks(i+1,9)-tracks(i-1,9))*fps/2;
%             tracks(i,12)=tracks(i,9)*(tracks(i+1,10)-tracks(i-1,10))*fps/2;
%         end
%     end
%     
%     save(strcat(directoryAnalyse,'\',num2str(numVid),'trajectoires'),'tracks')
%     
load(strcat(directoryAnalyse,'\',num2str(numVid),'trajectoires'))    
     nbar=10;
    [valeurs,positions]=hist_maison(tracks(:,12),-150,150,nbar,1); %function [counts,bins] = hist_maison(image,inf,sup,nbbins,norm)
   if numVid==12
    tabval=zeros(nbar,6);
   end
    tabval(:,j)=valeurs;
% %     
%     hold on;    
%     plot(positions,valeurs,'Color',cm(floor(vitesse*255/180)+1,:),'LineWidth',3);
%    
%   xlabel('Vitesse perpendiculairement au centre [mm.s^{-1}]') 
%   ylabel('Probabilité de vitesse d''un nageur')
%   colorbar;
%   colormap parula(256);
end

bar(tabval(4:10,:))
%legend('R=1 mm','R=2 mm','R=3 mm','R=4 mm')
legend('0 tour/min','60 tour/min','90 tour/min','120 tour/min','150 tour/min','180 tour/min')

xlabel('Distance au centre [mm]') 
%ylabel('Probabilité de présence d''un nageur')
ylabel('Répartition des vitesses orthoradiales')
set(gca,'XTickLabel',{'-60<vt<-30','-30<vt<0','0<vt<30','30<vt<60','60<vt<90','90<vt<120','120<vt<150'})



% 
% t=[];
% for v=1:149
%     t=[t,length(c(v).x)];
% end
