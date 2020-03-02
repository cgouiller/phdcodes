clear all;
close all
% Load parameters corresponding to one set of data (one date)


%%
run('E:\Laurent\Mixing\Matlab\manips180618.m');
%timer
for numVid=10
    
    %initialize counter
    
    
    
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    
    
    
    fprintf('Video ');
    fprintf(video);
    fprintf('\n');
    dispstat('','init');
    dispstat(sprintf('Begining the mean trail calculation...'),'keepthis','timestamp');
    
    startImg=startIm(numVid);
    R_range=[floor(RCat(numVid)*0.95*0.5/calib) ceil(RCat(numVid)*1.05*0.5/calib)];
    s=Sens(numVid);
    
    
    
    
    
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    directoryVid=strcat(basePathVid,date,set,video,'\');
    directoryBg=strcat(directoryVid,'bg\');
    L=dir(strcat(directoryVid,format));
    im0=load(strcat(directoryAnalyse,'imbg'));
    im0=im0.im0;
    
    
       
     vect=[endPosX(numVid)-startPosX(numVid) endPosY(numVid)-startPosY(numVid)]./(sqrt((endPosX(numVid)-startPosX(numVid))^2+(endPosY(numVid)-startPosY(numVid))^2));
%     if vect(1)>0
        theta=-atan(vect(1)/vect(2));
%     else
%         theta=-atan(vect(1)/vect(2))+pi;
    
    
    imtot=zeros(length(im0),length(im0));
    counttot=zeros(length(im0),length(im0));
    
    
    for i=startIm(numVid)+7:endIm(numVid)
        
        c=struct();
         fname=L(i).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        im=im(topLeftY(numVid):bottomRightY(numVid),topLeftX(numVid):bottomRightX(numVid));
        % Position of the camphor swimmers
        [ctmp,rtmp] = imfindcircles(im,R_range,'ObjectPolarity','dark','Method','TwoStage','Sensitivity',s);
        c.x=ctmp(:,1)*calib;
        c.y=ctmp(:,2)*calib;
        c.r=rtmp*calib;
       % c.t=k/fps;
        im=(im)./im0;
        
        %and take the log to get beer-lambert's estimation of the concentration
        Cfield=real(-nanlog(im));
        
        Cfield(Cfield>0.3)=NaN;
        
        % nan the camphor swimmers in the images
        for m=1:length(rtmp)
            Cfield=nanCircle(Cfield,round(ctmp(m,2)),round(ctmp(m,1)),rtmp(m)+3);
        end
    
    
        Cfield=Cfield-nanmean(nanmean(Cfield));
        
        
        
        
        proftmp=improfile(Cfield,[round(startPosX(numVid)-topLeftX(numVid)-10*vect(1)) round(endPosX(numVid)-topLeftX(numVid)+10*vect(1))],[round(startPosY(numVid)-topLeftY(numVid)-10*vect(2)) round(endPosY(numVid)-topLeftY(numVid)+10*vect(2))],500)';
        
        %Repérer le nageur dans proftmp
        test=1;
        tt=0;
        
        while tt==0
            if isnan(proftmp(test))==1
                deb=test;
                tt=1;
            else
                test=test+1;
            end
            
        end
        
        while tt==1
            if isnan(proftmp(test))==0 || test==500
                fin=test-1;
                tt=0;
            else
                test=test+1;
            end
            
        end
        
        %Milieu du nageur:
        posmilieu=round((deb+fin)/2);
        
        
        posmilieuX=round(startPosX(numVid)-topLeftX(numVid)-10*vect(1)+posmilieu/500*(endPosX(numVid)-startPosX(numVid)+20*vect(1)));
        posmilieuY=round(startPosY(numVid)-topLeftY(numVid)-10*vect(2)+posmilieu/500*(endPosY(numVid)-startPosY(numVid)+20*vect(2)));
        
        Cfield2=nan(size(Cfield,2));
        Cfield2(1:size(Cfield,1),1:size(Cfield,2))=Cfield;
       
        
        Cfield=Cfield2;
        [X,Y]=meshgrid(1:size(Cfield,2),1:size(Cfield,1));
        pts=zeros(length(X).^2,2);
        ptsf=zeros(length(X).^2,2);
        pts(:,1)=X(:)-posmilieuX;  %Position du nageur - x
        pts(:,2)=Y(:)-posmilieuY;  % Position du nageur - y
        R=[cos(theta), sin(theta);-sin(theta) cos(theta)];
        v=[size(Cfield,2)/2-posmilieuX, size(Cfield,1)/2-posmilieuY];
        
        tt=v*R;
        pts2=pts*R;
        pts2(:,1)=pts2(:,1)+posmilieuX;
        pts2(:,2)=pts2(:,2)+posmilieuY;
        
        ptsf(:,1)=pts2(:,2)-tt(2);
        ptsf(:,2)=pts2(:,1)-tt(1);
        
        [im,count]=bilinear_clement(Cfield,ptsf);
        %im(:,:,k)=uint8(im(:,:,k));
        imtot=imtot+im;
        counttot=counttot+count;
       
        
    end
    immoy=imtot./counttot;
    save(strcat(directoryAnalyse,'meanTrail_2'),'immoy');
end

