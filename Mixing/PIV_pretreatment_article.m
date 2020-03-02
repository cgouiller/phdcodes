clear all;
run defaultfig;
run manipsfinales;
numVid=25;
load_param;
mkdir(directoryPivmean2);

%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining PIV pretreatment...'),'keepthis','timestamp');
derrieregauchey=46;
derrieregauchex=446;
devantdroitey=1346;
devantdroitex=1446;

L=dir(strcat(directoryVid,'*.tif'));
load(strcat(directoryAnalyse,'\particules_selectionnees.mat'));

sample=sortrows(sample,3);

for k=round(linspace(1,length(sample)-61,10000)) %Juste pour être sûr que ça dépasse pas
    if mod(k,10)==0
        dispstat(sprintf('Progress %d%%',round(k*100/length((sample(:,1))))),'timestamp');
    end
    fname=L(sample(k,3)).name;
    fnamesave=fname;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    s=length(im);
    [X,Y]=meshgrid(1:size(im,2),1:size(im,1));
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
    
    [im,count]=bilinear_clement(im,ptsf);
    im=im(derrieregauchey:devantdroitey,derrieregauchex:devantdroitex);
    im=uint8(im);
    imwrite(im,strcat(directoryPivmean2,fname(1:7),'_A.tif'),'tif');
    
    
    
    fname=L(sample(k,3)+1).name;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    s=length(im);
    [X,Y]=meshgrid(1:size(im,2),1:size(im,1));
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
    
    [im,count]=bilinear_clement(im,ptsf);
    im=im(derrieregauchey:devantdroitey,derrieregauchex:devantdroitex);
    im=uint8(im);
    imwrite(im,strcat(directoryPivmean2,fnamesave(1:7),'_B.tif'),'tif');
    
end
