
    
load(strcat(directoryVid,'trajectories.mat'));
mkdir(directoryPiv);
tracks=sortrows(tracks,4);
tracks(:,2)=tracks(:,2)+200;

for kk=1:length(alea) %696Juste pour être sûr que ça dépasse pas
    k=alea(kk);
   % disp(round(100*(k-startpretr)/(endpretr-startpretr)))
    number=int2str(tracks(k,3));
    for j=1:4-length(number)
        number=['0' number];
    end
        
    fname=L(tracks(k,3)).name;
    fnamesave=fname;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
   imsq=zeros(1248,1248);
   imsq(201:1048,:)=im;
    [X,Y]=meshgrid(1:size(imsq,2),1:size(imsq,1));
    s=size(imsq,1);
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-tracks(k,1);
    pts(:,2)=Y(:)-tracks(k,2);
    R=[cos(tracks(k,9)), sin(tracks(k,9));-sin(tracks(k,9)) cos(tracks(k,9))];
    v=[s/2-tracks(k,1), s/2-tracks(k,2)];
    if isfinite(tracks(k,9))
    tt=v*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+tracks(k,1);
    pts2(:,2)=pts2(:,2)+tracks(k,2);
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [imsq,count]=bilinear_clement(imsq,ptsf);
    imsq=uint8(imsq);
    imwrite(imsq,strcat(directoryPiv,num2str(numPassage(numVid)),'im_',number,'_a.tif'),'tif');
    
    
    
    fname=L(tracks(k,3)+4).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
   imsq=zeros(1248,1248);
   imsq(201:1048,:)=im;
    [X,Y]=meshgrid(1:size(imsq,2),1:size(imsq,1));
    s=size(imsq,1);
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-tracks(k,1);
    pts(:,2)=Y(:)-tracks(k,2);
    R=[cos(tracks(k,9)), sin(tracks(k,9));-sin(tracks(k,9)) cos(tracks(k,9))];
    v=[s/2-tracks(k,1), s/2-tracks(k,2)];
    
    tt=v*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+tracks(k,1);
    pts2(:,2)=pts2(:,2)+tracks(k,2);
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [imsq,count]=bilinear_clement(imsq,ptsf);
    imsq=uint8(imsq);
    imwrite(imsq,strcat(directoryPiv,num2str(numPassage(numVid)),'im_',number,'_b.tif'),'tif');
    end
end
