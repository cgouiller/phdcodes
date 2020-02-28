%% Essais pour corriger la concentration dans le voisinage des nageurs


%% tracking des particules
% 
% fprintf('Video');
% fprintf(video);
% fprintf('\n');
% fprintf('Détection des nageurs solo');
% fprintf('\n');
% 
% Lsolo=dir(strcat(directoryVid,'solo\',format));
% load(strcat(directoryAnalyse,'directory.mat'));
% 
% for k=1:length(Lsolo)
%     
%     %get current image
%     fname=Lsolo(k).name;
%     fnamecompl=strcat(directoryVid,'solo\',fname);
%     im=double(imread(fnamecompl));
%     
%     %crop the image around the free surface of water
%     im=im(round(centerCellYSolo-radiusCellPx):round(centerCellYSolo+radiusCellPx),round(centerCellXSolo-radiusCellPx):round(centerCellXSolo+radiusCellPx));
%     
%     % Position of the camphor swimmers
%     [ctmp,rtmp] = imfindcircles(im,R_range,'ObjectPolarity','dark','Method','TwoStage');
%     c(k).x=ctmp(:,1)*calib;
%     c(k).y=ctmp(:,2)*calib;
%     c(k).r=rtmp*calib;
%     c(k).t=str2double(fname(1:7))/fps;
%     
%     % Avancement dans le traitement
%     if mod(k,10)==0
%         dispstat(sprintf('Progress %i%%',round((k-startImg)*100/(length(Lsolo)-startImg))),'timestamp');
%     end
%     
% end
% 
% % save the position of the camphor swimmers along the movie
% save(strcat(directoryAnalyse,'\','positionssolo.mat'),'c')
% %
% dispstat('Finished.','keepprev');

%%
fprintf('Extract Positions in text files...');
fprintf('\n');
%load(strcat(directoryAnalyse,'\ConcBL.mat'));
a=load(strcat(directoryAnalyse,'\positionssolo.mat'));
a=a.c;

maxdist=100/fps;
[tracks]=camphre_struct2pos(a,maxdist,50);


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


for i=2:length(tracks(:,1))-1
    %Repérer toutes les images correspondant à une particule
    
    if tracks(i+1,3)==tracks(i,3)+1 && tracks(i-1,3)+1==tracks(i,3)
        tracks(i,6)=(tracks(i+1,1)-tracks(i-1,1))*fps/2;
        tracks(i,7)=(tracks(i+1,2)-tracks(i-1,2))*fps/2;
        tracks(i,8)=sqrt(tracks(i,6)*tracks(i,6)+tracks(i,7)*tracks(i,7));
        tracks(i,9)=-atan(tracks(i,6)/tracks(i,7)); %le - vient du fait que y vers le bas dans nos images
        if tracks(i,7)<0
            tracks(i,9)=tracks(i,9)+pi;
        end
        
    end
    
end




save(strcat(directoryAnalyse,'trajectoriessolo.mat'),'tracks')
%
load(strcat(directoryAnalyse,'trajectoriessolo.mat'))

dispstat('','init');
dispstat(sprintf('Begining the trajectory analysis...'),'keepthis','timestamp');

R=sizeim/2*calib;
sample=[];


for i=1:length(tracks(:,1))
    if mod(i,100)==0
        dispstat(sprintf('Progress %i%%',round(i*100/(length(tracks(:,1))))),'timestamp');
    end
    
    samp=tracks(tracks(:,3)==tracks(i,3),1:2);
    theta=rand(1,1)*2*pi;
    test=0;
    %On définit le rectangle dans lequel les particules ne doivent pas être
    %             xv=[tracks(i,1)+9*cos(tracks(i,12))-14*sin(tracks(i,12)),tracks(i,1)+9*cos(tracks(i,12))+14*sin(tracks(i,12)),tracks(i,1)-32*cos(tracks(i,12))+14*sin(tracks(i,12)),tracks(i,1)-32*cos(tracks(i,12))-14*sin(tracks(i,12))];
    %             yv=[tracks(i,2)+14*cos(tracks(i,12))+9*sin(tracks(i,12)),tracks(i,2)+9*sin(tracks(i,12))-14*cos(tracks(i,12)),tracks(i,2)-14*cos(tracks(i,12))-32*sin(tracks(i,12)),tracks(i,2)+14*cos(tracks(i,12))-32*sin(tracks(i,12)),];
    xv=[tracks(i,1)+30*cos(theta)-30*sin(theta),tracks(i,1)+30*cos(theta)+30*sin(theta),tracks(i,1)-30*cos(theta)+30*sin(theta),tracks(i,1)-30*cos(theta)-30*sin(theta)];
    yv=[tracks(i,2)+30*cos(theta)+30*sin(theta),tracks(i,2)+30*sin(theta)-30*cos(theta),tracks(i,2)-30*cos(theta)-30*sin(theta),tracks(i,2)+30*cos(theta)-30*sin(theta),];
    
    for j=1:length(samp(:,1))
        if inpolygon(samp(j,1),samp(j,2),xv,yv) && samp(j,1)~=tracks(i,1)
            test=1;
        end
    end
    
    dCenter=sqrt((tracks(i,1)-R)^2+(tracks(i,2)-R)^2);
    if dCenter<70 && test==0
        sample=[sample;tracks(i,:)];
    end
end

% sample(:,3)=sample(:,3)+find(time==55*60)-1;
save(strcat(directoryAnalyse,'particules_selectionneessolo.mat'),'sample')

%Parmi les présentes à chaque frame, regarder celles qui sont assez
%loin du bord et de leurs voisines. Les sauvegarder.

%Les envoyer dans measure trail
% 
% 
% 
%%





dispstat('','init');
dispstat(sprintf('Calcul du champ de conc moyen autour d\''un nageur'),'keepthis','timestamp');
imbg=load(strcat(directoryAnalyse,'im0'));
imbg=imbg.im0;
immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));
imtot=zeros(sizeim+1,sizeim+1);
counttot=zeros(sizeim+1,sizeim+1);
Lsolo=dir(strcat(directoryVid,'solo\',format));

load(strcat(directoryAnalyse,'particules_selectionneessolo.mat'));
a=load(strcat(directoryAnalyse,'positionssolo.mat'));
c=a.c;
%moyCMoy=mean(CMoy(sample(1,3):sample(length(sample),3)));
for k=1:length(sample)%round(linspace(1,length(sample(:,1)),1000))
    
    %Mï¿½thode de background :
    %Chemins oï¿½ rï¿½cupï¿½rer/enregistrer les donnï¿½es.
    ctmp=[];
    theta=rand(1,1)*2*pi;
    if mod(k,10)==0
        dispstat(sprintf('Progress %d%%',round(k*100/length(sample))),'timestamp');
    end
    fname=Lsolo(sample(k,3)).name;
    fnamecompl=strcat(directoryVid,'solo\',fname);
    im=double(imread(fnamecompl));
    %crop the image around the free surface of water
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    % divide the image by the background image
    pos=[c(sample(k,3)).x,c(sample(k,3)).y,c(sample(k,3)).r];
    pos=pos/calib;
    Cfield=calc_CfieldBL(im,imbg,pos,immask);
    % Cfield=(Cfield-CMoy(sample(k,3)))/CMoy(sample(k,3));
    %      Cfield=(Cfield-moyCMoy)/moyCMoy; %BIS
    s=length(Cfield);
    [X,Y]=meshgrid(1:size(Cfield,2),1:size(Cfield,1));
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-sample(k,1)/calib;
    pts(:,2)=Y(:)-sample(k,2)/calib;
    R=[cos(theta), sin(theta);-sin(theta) cos(theta)];
    v=[s/2-sample(k,1)/calib, s/2-sample(k,2)/calib];
    tt=v*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+sample(k,1)/calib;
    pts2(:,2)=pts2(:,2)+sample(k,2)/calib;
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    [im,count]=bilinear_clement(Cfield,ptsf);
    imtot=imtot+im;
    counttot=counttot+count;
end
immoy=imtot./counttot;
save(strcat(directoryAnalyse,'meanTrailsolo'),'immoy');

% 
 %%
dispstat('','init');
dispstat(sprintf('Calcul de l\''image correctrice'),'keepthis','timestamp');
load(strcat(directoryAnalyse,'meanTrailsolo'));
[Zr, R] = radialavg(immoy,sizeim/2,0,0);

inde=find(Zr==max(Zr(50:800)));
if mod(inde,2)==0
    inde=inde-1;
end
%plot(Zr(1:inde))

Vect=Zr(1:inde);
%Vect=Vect-Vect(inde);
Vect(inde+1:2*inde)=0;
nagcor=zeros(2*inde+1,2*inde+1);
warning('off');
for x=1:2*inde+1
    for y=1:2*inde+1
        nagcor(x,y)=interp1(1:2*inde,Vect,sqrt((floor(inde+1/2)-x)^2+(floor(inde+1/2)-y)^2));
        
        if mod(x,10)==0 && y==1
            dispstat(sprintf('Progress %d%%',round(x*100/(2*inde+1))),'timestamp');
        end
    end
end
warning('on');
%imagesc(nagcor,[-0.01 0])
save(strcat(directoryAnalyse,'nagcor'),'nagcor');


 %%
dispstat('','init');
dispstat(sprintf('Calcul de l\''image correctrice'),'keepthis','timestamp');
load(strcat(directoryAnalyse,'meanTrailsolo'));
[Zr, R] = radialavg(immoy,sizeim/2,0,0);

inde=find(Zr==max(Zr(50:800)));
if mod(inde,2)==0
    inde=inde-1;
end


Vect=Zr(1:2*inde);
%Vect=Vect-Vect(inde);

nagcor=zeros(2*inde+1,2*inde+1);
warning('off');
for x=1:2*inde+1
    for y=1:2*inde+1
        nagcor(x,y)=interp1(1:2*inde,Vect,sqrt((floor(inde+1/2)-x)^2+(floor(inde+1/2)-y)^2));
        
        if mod(x,10)==0 && y==1
            dispstat(sprintf('Progress %d%%',round(x*100/(2*inde+1))),'timestamp');
        end
    end
end
warning('on');
%imagesc(nagcor,[-0.01 0])
save(strcat(directoryAnalyse,'nagcorfull'),'nagcor');
% 
% %%
% dispstat('','init');
% dispstat(sprintf('Calcul de l\''image correctrice'),'keepthis','timestamp');
% load(strcat(directoryAnalyse,'meanTrailsolo'));
% [Zr, R] = radialavg(immoy,sizeim/2,0,0);
% 
% inde=find(Zr==max(Zr(50:800)));
% if mod(inde,2)==0
%     inde=inde-1;
% end
% plot(Zr(1:inde))
% 
% Vect=Zr(1:inde);
% Vect=Vect-Vect(inde);
% Vect(inde+1:2*inde)=0;
% nagcor=zeros(2*inde+1,2*inde+1);
% warning('off');
% for x=1:2*inde+1
%     for y=1:2*inde+1
%         nagcor(x,y)=interp1(1:2*inde,Vect,sqrt((floor(inde+1/2)-x)^2+(floor(inde+1/2)-y)^2));
%         
%         if mod(x,10)==0 && y==1
%             dispstat(sprintf('Progress %d%%',round(x*100/(2*inde+1))),'timestamp');
%         end
%     end
% end
% warning('on');
% %imagesc(nagcor,[-0.01 0])
% save(strcat(directoryAnalyse,'nagcorshift'),'nagcor');
