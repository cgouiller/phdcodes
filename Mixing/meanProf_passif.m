clear all;
run manips180618;
for numVid=1:10
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,set,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
   
    R_range=[floor(RCat(numVid)*0.95*0.5/calib) ceil(RCat(numVid)*1.05*0.5/calib)];
    s=Sens(numVid);
    proftmpstock=nan(endIm(numVid)-startIm(numVid)-7+1,1001);
    meanProf=zeros(1,1001);
    for k=startIm(numVid)+7:endIm(numVid)
        100*(k-(startIm(numVid)+7))/(endIm(numVid)-(startIm(numVid)+7))
        video=strjoin(videoCatalogue(numVid));
        set=strjoin(setCatalogue(numVid));
        directoryVid=strcat(basePathVid,date,set,video,'\');
        directoryVidProcessed=strcat(basePathAnalyse,date,set,video,'\processed\');
        directoryBg=strcat(directoryVid,'bg\');
        directoryAnalyse=strcat(basePathAnalyse,date,set,video);
        
        load(strcat(directoryAnalyse,'\imbg'),'im0')
        
        L=dir(strcat(directoryVid,format));
        fname=L(k).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        im=im(topLeftY(numVid):bottomRightY(numVid),topLeftX(numVid):bottomRightX(numVid));
        % Position of the camphor swimmers
        [ctmp,rtmp] = imfindcircles(im,R_range,'ObjectPolarity','dark','Method','TwoStage','Sensitivity',s);
        c(k).x=ctmp(:,1)*calib;
        c(k).y=ctmp(:,2)*calib;
        c(k).r=rtmp*calib;
        c(k).t=k/fps;
        im=(im)./im0;
        
        %and take the log to get beer-lambert's estimation of the concentration
        Cfield=real(-nanlog(im));
        
        Cfield(Cfield>0.3)=NaN;
        
        % nan the camphor swimmers in the images
        for m=1:length(rtmp)
            Cfield=nanCircle(Cfield,round(ctmp(m,2)),round(ctmp(m,1)),rtmp(m)+3);
        end
        
        
        proftmp=nan(1,1501);
        proftmp2=nan(1,1501);
        proftmp3=nan(1,1501);
        proftmp4=nan(1,1501);
        proftmp5=nan(1,1501);
        
        vect=[endPosX(numVid)-startPosX(numVid) endPosY(numVid)-startPosY(numVid)]./(sqrt((endPosX(numVid)-startPosX(numVid))^2+(endPosY(numVid)-startPosY(numVid))^2));
        vectperp=[-vect(2) vect(1)];
        
        proftmp(501:1000)=improfile(Cfield,[startPosX(numVid)-topLeftX(numVid) endPosX(numVid)-topLeftX(numVid)],[startPosY(numVid)-topLeftY(numVid) endPosY(numVid)-topLeftY(numVid)],500)';
        proftmp2(501:1000)=improfile(Cfield,[startPosX(numVid)-topLeftX(numVid)+vectperp(1) endPosX(numVid)-topLeftX(numVid)+vectperp(1)],[startPosY(numVid)-topLeftY(numVid)+vectperp(2) endPosY(numVid)-topLeftY(numVid)+vectperp(2)],500)';
        proftmp3(501:1000)=improfile(Cfield,[startPosX(numVid)-topLeftX(numVid)+2*vectperp(1) endPosX(numVid)-topLeftX(numVid)+2*vectperp(1)],[startPosY(numVid)-topLeftY(numVid)+2*vectperp(2) endPosY(numVid)-topLeftY(numVid)+2*vectperp(2)],500)';
        proftmp4(501:1000)=improfile(Cfield,[startPosX(numVid)-topLeftX(numVid)-vectperp(1) endPosX(numVid)-topLeftX(numVid)-vectperp(1)],[startPosY(numVid)-topLeftY(numVid)-vectperp(2) endPosY(numVid)-topLeftY(numVid)-vectperp(2)],500)';
        proftmp5(501:1000)=improfile(Cfield,[startPosX(numVid)-topLeftX(numVid)-2*vectperp(1) endPosX(numVid)-topLeftX(numVid)-2*vectperp(1)],[startPosY(numVid)-topLeftY(numVid)-2*vectperp(2) endPosY(numVid)-topLeftY(numVid)-2*vectperp(2)],500)';
        
        for kk=501:1000
            proftmp(kk)=nanmean([proftmp(kk),proftmp2(kk),proftmp3(kk),proftmp4(kk),proftmp5(kk)]);
        end
        
        %Repérer le nageur dans proftmp
        test=501;
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
            if isnan(proftmp(test))==0 || test==1000
                fin=test-1;
                tt=0;
            else
                test=test+1;
            end
            
        end
        
        %Milieu du nageur:
        posmilieu=round((deb+fin)/2);
        
        if fin ~=999
            proftmpstock(k-startIm(numVid)-7+1,:)=proftmp(posmilieu-500:posmilieu+500);
        end
        
        
        
    end
    for k=1:1001
       meanProf(k)=nanmean(proftmpstock(:,k)); 
    end
    save(strcat(directoryAnalyse,'\',video,'meanProf_moy5prof'),'meanProf')
end