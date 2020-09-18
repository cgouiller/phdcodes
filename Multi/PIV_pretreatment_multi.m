xs=[bdxcat(numVid)-bgxcat(numVid),hdxcat(numVid)-bdxcat(numVid),hdxcat(numVid)-hgxcat(numVid),hgxcat(numVid)-bgxcat(numVid)];
ys=-[bdycat(numVid)-bgycat(numVid),hdycat(numVid)-bdycat(numVid),hdycat(numVid)-hgycat(numVid),hgycat(numVid)-bgycat(numVid)]; %à cause d'imageJ

angles=atan(ys./xs);
angles(2)=angles(2)-pi/2;
angles(4)=angles(4)-pi/2;

angles(xs<0)=angles(xs<0)+pi;
angle=-mean(angles); %- parce qu'on veut tourner dans l'autre sens que celui qu'on a mesuré!

reshval=round(min([2048-centerXCat(numVid),centerXCat(numVid),centerYCat(numVid),2048-centerYCat(numVid)])-5);
Lbg=dir(strcat(directoryVid,'\bg\','*.tif'));
% a typical image to get its size
fname=Lbg(1).name;
fnamecompl=strcat(directoryVid,'\bg\',fname);
im0=double(imread(fnamecompl));

im0=im0(centerYCat(numVid)-reshval:centerYCat(numVid)+reshval,centerXCat(numVid)-reshval:centerXCat(numVid)+reshval);
im0=zeros(size(im0));

centerval=(length(im0)+1)/2;

xedge2=[centerval-coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval-coteCarre(numVid)/2];
yedge2=[centerval-coteCarre(numVid)/2,centerval-coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval+coteCarre(numVid)/2];
mincrop=round(mean([xedge2(1),xedge2(4),yedge2(1),yedge2(2)]));
maxcrop=round(mean([xedge2(2),xedge2(3),yedge2(3),yedge2(4)]));

for k=1:length(Lbg) 
    fname=Lbg(k).name;
    fnamesave=fname;
    fnamecompl=strcat(directoryVid,'\bg\',fname);
    im=double(imread(fnamecompl));
    im=im(centerYCat(numVid)-reshval:centerYCat(numVid)+reshval,centerXCat(numVid)-reshval:centerXCat(numVid)+reshval);
    im0=im0+im;
end
centerval=(length(im0)+1)/2;
[X,Y]=meshgrid(1:size(im0,2),1:size(im0,1));
s=size(im0,1);
pts=zeros(length(X).^2,2);
ptsf=zeros(length(X).^2,2);
pts(:,1)=X(:)-centerval;
pts(:,2)=Y(:)-centerval;
R=[cos(angle), sin(angle);-sin(angle) cos(angle)];
v=[s/2-centerval, s/2-centerval];
tt=v*R;
pts2=pts*R;
pts2(:,1)=pts2(:,1)+centerval;
pts2(:,2)=pts2(:,2)+centerval;

ptsf(:,1)=pts2(:,2)-tt(2);
ptsf(:,2)=pts2(:,1)-tt(1);

[im0,count]=bilinear_clement(im0,ptsf);
im0=im0/length(Lbg);
im0=im0(mincrop:maxcrop,mincrop:maxcrop);






L=dir(strcat(directoryVid,'\*.tif'));
alea=randi([startImgCatalogue(numVid),length(L)-1],[200,1]);
while length(alea)~=length(unique(alea))
    alea=[unique(alea);randi([startImgCatalogue(numVid),length(L)-1],[200-length(unique(alea)),1])];
end
for kk=1:length(alea) 
    kk
    k=alea(kk);
    number=int2str(k);
    for j=1:4-length(number)
        number=['0' number];
    end
    fname=L(k).name;
    fnamesave=fname;
    fnamecompl=strcat(directoryVid,'\',fname);
    im=double(imread(fnamecompl));
    im=im(centerYCat(numVid)-reshval:centerYCat(numVid)+reshval,centerXCat(numVid)-reshval:centerXCat(numVid)+reshval);
    centerval=(length(im)+1)/2;
    [X,Y]=meshgrid(1:size(im,2),1:size(im,1));
    s=size(im,1);
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-centerval;
    pts(:,2)=Y(:)-centerval;
    R=[cos(angle), sin(angle);-sin(angle) cos(angle)];
    v=[s/2-centerval, s/2-centerval];
    tt=v*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+centerval;
    pts2(:,2)=pts2(:,2)+centerval;
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [im,count]=bilinear_clement(im,ptsf);
    im=im(mincrop:maxcrop,mincrop:maxcrop);
    im=im-im0;
    im(im<5)=0;
    im=uint8(im);
    imwrite(im,strcat(directoryPiv,'im_',number,'_a.tif'),'tif');
    
    
    
    fname=L(k+1).name;
    fnamesave=fname;
    fnamecompl=strcat(directoryVid,'\',fname);
    im=double(imread(fnamecompl));
    im=im(centerYCat(numVid)-reshval:centerYCat(numVid)+reshval,centerXCat(numVid)-reshval:centerXCat(numVid)+reshval);
    [X,Y]=meshgrid(1:size(im,2),1:size(im,1));
    s=size(im,1);
    pts=zeros(length(X).^2,2);
    ptsf=zeros(length(X).^2,2);
    pts(:,1)=X(:)-centerval;
    pts(:,2)=Y(:)-centerval;
    R=[cos(angle), sin(angle);-sin(angle) cos(angle)];
    v=[s/2-centerval, s/2-centerval];
    tt=v*R;
    pts2=pts*R;
    pts2(:,1)=pts2(:,1)+centerval;
    pts2(:,2)=pts2(:,2)+centerval;
    
    ptsf(:,1)=pts2(:,2)-tt(2);
    ptsf(:,2)=pts2(:,1)-tt(1);
    
    [im,count]=bilinear_clement(im,ptsf);
    im=im(mincrop:maxcrop,mincrop:maxcrop);
    im=im-im0;
    im(im<5)=0;
    im=uint8(im);
    imwrite(im,strcat(directoryPiv,'im_',number,'_b.tif'),'tif');
end
