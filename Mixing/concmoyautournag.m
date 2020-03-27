%% Calcule la concentration moyenne à chaque endroit autour du nageur en linéaire


fprintf('Video');
    fprintf(video(1:length(video)-1));
    fprintf('\n');
    dispstat('','init');
    dispstat(sprintf('Begining the mean trail calculation...'),'keepthis','timestamp');

    imbg=load(strcat(directoryAnalyse,'im0'));
    imbg=imbg.im0;
%     load(strcat(directoryAnalyse,'ConcBL.mat'));
          load(strcat(directoryAnalyse,'directory.mat'));

   
    immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));

    imtot=zeros(sizeim+1,sizeim+1);
    counttot=zeros(sizeim+1,sizeim+1);
    
    load(strcat(directoryAnalyse,'particules_selectionnees.mat'));
   
    
    a=load(strcat(directoryAnalyse,'positions.mat'));
    c=a.c;

    aleat=round((rand(1,3000)*(length(sample)-1))+1);
    for ii=1:length(aleat)
        k=aleat(ii);
        %Mï¿½thode de background :
        %Chemins oï¿½ rï¿½cupï¿½rer/enregistrer les donnï¿½es.
        ctmp=[];
        
        if mod(ii,10)==0
            dispstat(sprintf('Progress %d%%',round(ii*100/length(aleat))),'timestamp');
        end
        
        fname=L(sample(k,3)).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        
        
        %crop the image around the free surface of water
        im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
            
        
        % divide the image by the background image
        pos=[c(sample(k,3)).x,c(sample(k,3)).y,c(sample(k,3)).r];
        pos=pos/calib;
       % Cfield=calc_CfieldBLnagcor(im,imbg,pos,immask,nagcor);
        Cfield=calc_Cfield2(im,imbg,pos,immask);
       % Cfield=(Cfield-CMoy(sample(k,3)))/CMoy(sample(k,3));
         %       Cfield=(Cfield-moyCMoy)/moyCMoy; %BIS

        s=length(Cfield);

        
        [X,Y]=meshgrid(1:size(Cfield,2),1:size(Cfield,1));
        pts=zeros(length(X).^2,2);
        ptsf=zeros(length(X).^2,2);
        pts(:,1)=X(:)-sample(k,1)/calib;
        pts(:,2)=Y(:)-sample(k,2)/calib;
        R=[cos(sample(k,9)), sin(sample(k,9));-sin(sample(k,9)) cos(sample(k,9))];
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
    save(strcat(directoryAnalyse,'meanTrail'),'immoy');
    
%     load(strcat(directoryAnalyse,'nagcor.mat'));
% 
%     imtot=zeros(sizeim+1,sizeim+1);
%     counttot=zeros(sizeim+1,sizeim+1);
%       for ii=1:length(aleat)
%         k=aleat(ii);
%         %Mï¿½thode de background :
%         %Chemins oï¿½ rï¿½cupï¿½rer/enregistrer les donnï¿½es.
%         ctmp=[];
%         
%         if mod(ii,10)==0
%             dispstat(sprintf('Progress %d%%',round(ii*100/length(aleat))),'timestamp');
%         end
%         
%         fname=L(sample(k,3)).name;
%         fnamecompl=strcat(directoryVid,fname);
%         im=double(imread(fnamecompl));
%         
%         
%         %crop the image around the free surface of water
%         im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
%             
%         
%         % divide the image by the background image
%         pos=[c(sample(k,3)).x,c(sample(k,3)).y,c(sample(k,3)).r];
%         pos=pos/calib;
%         Cfield=calc_CfieldBLnagcor(im,imbg,pos,immask,nagcor);
%         %Cfield=calc_CfieldBL(im,imbg,pos,immask);
%        % Cfield=(Cfield-CMoy(sample(k,3)))/CMoy(sample(k,3));
%          %       Cfield=(Cfield-moyCMoy)/moyCMoy; %BIS
% 
%         s=length(Cfield);
% 
%         
%         [X,Y]=meshgrid(1:size(Cfield,2),1:size(Cfield,1));
%         pts=zeros(length(X).^2,2);
%         ptsf=zeros(length(X).^2,2);
%         pts(:,1)=X(:)-sample(k,1)/calib;
%         pts(:,2)=Y(:)-sample(k,2)/calib;
%         R=[cos(sample(k,9)), sin(sample(k,9));-sin(sample(k,9)) cos(sample(k,9))];
%         v=[s/2-sample(k,1)/calib, s/2-sample(k,2)/calib];
%         
%         tt=v*R;
%         pts2=pts*R;
%         pts2(:,1)=pts2(:,1)+sample(k,1)/calib;
%         pts2(:,2)=pts2(:,2)+sample(k,2)/calib;
%         
%         ptsf(:,1)=pts2(:,2)-tt(2);
%         ptsf(:,2)=pts2(:,1)-tt(1);
%         
%         [im,count]=bilinear_clement(Cfield,ptsf);
%         
%         
%         imtot=imtot+im;
%         counttot=counttot+count;
%         
%         
%         
%     end
%     immoy=imtot./counttot;
%     save(strcat(directoryAnalyse,'meanTrailcor'),'immoy');
% 
%     load(strcat(directoryAnalyse,'nagcorshift.mat'));
% 
%     imtot=zeros(sizeim+1,sizeim+1);
%     counttot=zeros(sizeim+1,sizeim+1);
%       for ii=1:length(aleat)
%         k=aleat(ii);
%         %Mï¿½thode de background :
%         %Chemins oï¿½ rï¿½cupï¿½rer/enregistrer les donnï¿½es.
%         ctmp=[];
%         
%         if mod(ii,10)==0
%             dispstat(sprintf('Progress %d%%',round(ii*100/length(aleat))),'timestamp');
%         end
%         
%         fname=L(sample(k,3)).name;
%         fnamecompl=strcat(directoryVid,fname);
%         im=double(imread(fnamecompl));
%         
%         
%         %crop the image around the free surface of water
%         im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
%             
%         
%         % divide the image by the background image
%         pos=[c(sample(k,3)).x,c(sample(k,3)).y,c(sample(k,3)).r];
%         pos=pos/calib;
%         Cfield=calc_CfieldBLnagcor(im,imbg,pos,immask,nagcor);
%         %Cfield=calc_CfieldBL(im,imbg,pos,immask);
%        % Cfield=(Cfield-CMoy(sample(k,3)))/CMoy(sample(k,3));
%          %       Cfield=(Cfield-moyCMoy)/moyCMoy; %BIS
% 
%         s=length(Cfield);
% 
%         
%         [X,Y]=meshgrid(1:size(Cfield,2),1:size(Cfield,1));
%         pts=zeros(length(X).^2,2);
%         ptsf=zeros(length(X).^2,2);
%         pts(:,1)=X(:)-sample(k,1)/calib;
%         pts(:,2)=Y(:)-sample(k,2)/calib;
%         R=[cos(sample(k,9)), sin(sample(k,9));-sin(sample(k,9)) cos(sample(k,9))];
%         v=[s/2-sample(k,1)/calib, s/2-sample(k,2)/calib];
%         
%         tt=v*R;
%         pts2=pts*R;
%         pts2(:,1)=pts2(:,1)+sample(k,1)/calib;
%         pts2(:,2)=pts2(:,2)+sample(k,2)/calib;
%         
%         ptsf(:,1)=pts2(:,2)-tt(2);
%         ptsf(:,2)=pts2(:,1)-tt(1);
%         
%         [im,count]=bilinear_clement(Cfield,ptsf);
%         
%         
%         imtot=imtot+im;
%         counttot=counttot+count;
%         
%         
%         
%     end
%     immoy=imtot./counttot;
%     save(strcat(directoryAnalyse,'meanTrailcorshift'),'immoy');
% 
% 


