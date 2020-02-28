%Calcule des profils moyens de concentration (à la manière de meanTrail
%mais que sur une ligne)

% Load parameters corresponding to one set of data (one date)


    dispstat('','init');
    dispstat(sprintf('Begining the profile measurement...'),'keepthis','timestamp');
 
    
              load(strcat(directoryAnalyse,'directory.mat'));


   
    
 
    
    %load trajectories
    load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
    load(strcat(directoryAnalyse,'Conclin.mat'));
    im0=load(strcat(directoryAnalyse,'im0'));
    im0=im0.im0;
    a=load(strcat(directoryAnalyse,'positions.mat'));
    c=a.c;
    proftmp=zeros(1,901);
    proftot=[];
    
    %for nbprof=1:11
    nbprof=6; %Pour profil longitudinal
immask=nanOutCircle(ones(length(im0)),round(length(im0)/2),round(length(im0)/2),round(length(im0)/2));

        aleat=round((rand(1,2000)*(length(sample)-1))+1);

   for ii=1:length(aleat)
        k=aleat(ii);
       if mod(k,10)==0
            dispstat(sprintf('Progress %d%%',round(ii*100/length(aleat))),'timestamp');
        end
        fname=L(sample(k,3)).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
        
       % divide the image by the background image
        pos=[c(sample(k,3)).x,c(sample(k,3)).y,c(sample(k,3)).r];
        pos=pos/calib;
        Cfield=calc_Cfield2(im,im0,pos,immask);
      
        % Tracé de profils longitudinaux
        proftmp=improfile(Cfield,[-(nbprof-6)*sample(k,7)/sample(k,8)/calib+sample(k,1)/calib-60*sample(k,6)/sample(k,8)/calib,-(nbprof-6)*sample(k,7)/sample(k,8)/calib+sample(k,1)/calib+60*sample(k,6)/sample(k,8)/calib],[(nbprof-6)*sample(k,6)/sample(k,8)/calib+sample(k,2)/calib-60*sample(k,7)/sample(k,8)/calib,(nbprof-6)*sample(k,6)/sample(k,8)/calib+sample(k,2)/calib+60*sample(k,7)/sample(k,8)/calib],901)';
        proftot=[proftot;proftmp];
        
        
    end
    
    for i=1:length(proftmp)
        meanProf(nbprof,i)=nanmean(proftot(:,i));
        %meanProfPerp(nbprof,i)=nanmean(proftotperp(:,i));
        
        proflong=meanProf(6,:);
        %proflong(430:472)=nan(1,43);
        % end
        x=linspace(-60,60,901);
        %
        
        
        
        
        
        
    end
    comment='Proflong est le champ de conc sans correction autour du nageur';
       % save(strcat(directoryAnalyse,'\long_profil'),'x','proflong')%C-<C>/<C>
       
        save(strcat(directoryAnalyse,'\long_profillin'),'x','proflong','comment')
       % plot(x,proflong);hold on;
