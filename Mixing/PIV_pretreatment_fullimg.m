%Initialize the clock
dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining PIV pretreatment...'),'keepthis','timestamp');
run manipsfinales;
numVid=25;
load_param;

L=dir(strcat(directoryVid,'*.tif'));
load(strcat(directoryAnalyse,'\particules_selectionnees.mat'));

sample=sortrows(sample,3);

for k=round(linspace(1,length(sample)-61,10)) %Juste pour être sûr que ça dépasse pas
    if mod(k,10)==0
        dispstat(sprintf('Progress %d%%',round(k*100/length((sample(:,1))))),'timestamp');
    end
    a=load(strcat(directoryAnalyse,'positions.mat'));
c=a.c;
imbg=load(strcat(directoryAnalyse,'im0'));
imbg=imbg.im0;
immask=nanOutCircle(ones(length(imbg)),round(length(imbg)/2),round(length(imbg)/2),round(length(imbg)/2));
    fname=L(sample(k,3)).name;
    fnamesave=fname;
    fnamecompl=strcat(directoryVid,fname);
    im=double(imread(fnamecompl));
    im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
    
     pos=[c(sample(k,3)).x,c(sample(k,3)).y,c(sample(k,3)).r];
    pos=pos/calib;
    Cfield=calc_Cfield2(im,imbg,pos,immask);
    save(strcat('C:\Users\clement.gouiller\Desktop\Cfield\',fname(1:7),'.mat'),'Cfield')
%     im=nanOutCircle(im,length(im)/2,length(im)/2,length(im)/2);
%     im(isfinite(im)==0)=0;
%     im=uint8(im);
%     imwrite(im,strcat(directoryPivmean,'full',fname(1:7),'_A.tif'),'tif');
%     
%     
%     
%     fname=L(sample(k,3)+1).name;
%     fnamecompl=strcat(directoryVid,fname);
%     im=double(imread(fnamecompl));
%     im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
%     
%         im=nanOutCircle(im,length(im)/2,length(im)/2,length(im)/2);
%        im(isfinite(im)==0)=0;
% 
%     im=uint8(im);
%     imwrite(im,strcat(directoryPivmean,'full',fnamesave(1:7),'_B.tif'),'tif');
%     
end
