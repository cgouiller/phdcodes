clear all;


run('E:\Clément\phdcodes\Multi\manipspiv.m');
cpt=0;

for numVid=8:9%4:7
    
    basePathVid=strjoin(basePathVidCatalogue(numVid));
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    startImg=startImgCatalogue(numVid);
    date=strjoin(dateCatalogue(numVid));
    % build paths and create directories
    directoryVid=strcat(basePathVid,date,sete,video);
    directoryPiv=strcat(directoryVid,'piv\');
    load(strcat(directoryPiv,'PIV_mean_mask.mat'))
    if cpt==0
        Umoyt=zeros(size(Umoy));
        Vmoyt=zeros(size(Umoy));
        cut=zeros(size(Umoy));
        cvt=zeros(size(Umoy));
        cpt=cpt+1;
    end
    Umoyt=Umoyt+Umoy.*countsu;
    Vmoyt=Vmoyt+Vmoy.*countsv;
    cut=cut+countsu;
    cvt=cvt+countsv;
    
end
Umoyt=Umoyt./cut;
Vmoyt=Vmoyt./cvt;


if numVid<8
xs=[bdxcat(numVid)-bgxcat(numVid),hdxcat(numVid)-bdxcat(numVid),hdxcat(numVid)-hgxcat(numVid),hgxcat(numVid)-bgxcat(numVid)];
ys=-[bdycat(numVid)-bgycat(numVid),hdycat(numVid)-bdycat(numVid),hdycat(numVid)-hgycat(numVid),hgycat(numVid)-bgycat(numVid)]; %à cause d'imageJ
angles=atan(ys./xs);
angles(2)=angles(2)-pi/2;
angles(4)=angles(4)-pi/2;

angles(xs<0)=angles(xs<0)+pi;
angle=-mean(angles); %- parce qu'on veut tourner dans l'autre sens que celui qu'on a mesuré!
figure;
L=dir(strcat(directoryVid,'*.tif'));

reshval=round(min([2048-centerXCat(numVid),centerXCat(numVid),centerYCat(numVid),2048-centerYCat(numVid)])-5);
fname=L(1).name;
fnamesave=fname;
fnamecompl=strcat(directoryVid,fname);
im=double(imread(fnamecompl));
im=im(centerYCat(numVid)-reshval:centerYCat(numVid)+reshval,centerXCat(numVid)-reshval:centerXCat(numVid)+reshval);
centerval=(length(im)+1)/2;

xedge2=[centerval-coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval-coteCarre(numVid)/2];
yedge2=[centerval-coteCarre(numVid)/2,centerval-coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval+coteCarre(numVid)/2];
in=inpolygon(x,y,xedge2,yedge2);
Umoyt=Umoyt.*in;
Vmoyt=Vmoyt.*in;
xedge3=(xedge2-xedge2(1))*calibCat(numVid);
yedge3=(yedge2-yedge2(1))*calibCat(numVid);
%plot([xedge3,xedge3(1)],[yedge3,yedge3(1)],'-k','LineWidth',2)
vmax=18;
Umoy=Umoyt*calibCat(numVid)*30;
Vmoy=Vmoyt*calibCat(numVid)*30;
normv=sqrt(Umoy.^2+Vmoy.^2);
Umoy(normv>vmax)=Umoy(normv>vmax)*vmax./normv(normv>vmax);
Vmoy(normv>vmax)=Vmoy(normv>vmax)*vmax./normv(normv>vmax);

quiverC2D((x-xedge2(1))*calibCat(numVid),(y-yedge2(1))*calibCat(numVid),Umoy,Vmoy);%colorbar;
axis square;
xlabel('x [mm]')
ylabel('y [mm]')
title(strcat(sete,num2str(max(max(sqrt((Umoy).^2+(Vmoy).^2))))),'Interpreter','latex')
hold on;
if trueCarre(numVid)==120.5
    pas=coteCarre(numVid)*calibCat(numVid)/5;
    for i=1:4
        for j=1:4
            if mod(i,2)==mod(j,2)
                plot(j*pas,i*pas,'+r','MarkerSize',10,'LineWidth',2)
            else
                plot(j*pas,i*pas,'xk','MarkerSize',10,'LineWidth',2)
            end
        end
    end
elseif trueCarre(numVid)==96.4
    pas=coteCarre(numVid)*calibCat(numVid)/4;
    
    for i=1:4
        for j=1:4
            if mod(i,2)==mod(j,2)
                plot((0.5+(j-1))*pas,(0.5+(i-1))*pas,'+r','MarkerSize',10,'LineWidth',2)
            else
                plot((0.5+(j-1))*pas,(0.5+(i-1))*pas,'xk','MarkerSize',10,'LineWidth',2)
            end
        end
    end
    
end
xlim([-5,trueCarre(numVid)+5])
ylim([-5,trueCarre(numVid)+5])
colormap parula(256);colorbar
end
if numVid>7
vmax=18;
Umoy=Umoyt*calibCat(numVid)*30;
Vmoy=Vmoyt*calibCat(numVid)*30;
normv=sqrt(Umoy.^2+Vmoy.^2);
Umoy(normv>vmax)=Umoy(normv>vmax)*vmax./normv(normv>vmax);
Vmoy(normv>vmax)=Vmoy(normv>vmax)*vmax./normv(normv>vmax);

quiverC2D(x*calibCat(numVid),y*calibCat(numVid),Umoy,Vmoy);%colorbar;
axis square;
xlabel('x [mm]')
ylabel('y [mm]')
title(strcat(sete,num2str(max(max(sqrt((Umoy).^2+(Vmoy).^2))))),'Interpreter','latex')
hold on;
if trueCarre(numVid)==120.5
    pas=coteCarre(numVid)*calibCat(numVid)/5;
    for i=1:4
        for j=1:4
            if mod(i,2)==mod(j,2)
                plot(j*pas,i*pas,'+r','MarkerSize',10,'LineWidth',2)
            else
                plot(j*pas,i*pas,'xk','MarkerSize',10,'LineWidth',2)
            end
        end
    end
elseif trueCarre(numVid)==96.4
    pas=coteCarre(numVid)*calibCat(numVid)/4;
    
    for i=1:4
        for j=1:4
            if mod(i,2)==mod(j,2)
                plot((0.5+(j-1))*pas,(0.5+(i-1))*pas,'+r','MarkerSize',10,'LineWidth',2)
            else
                plot((0.5+(j-1))*pas,(0.5+(i-1))*pas,'xk','MarkerSize',10,'LineWidth',2)
            end
        end
    end
    
end
xlim([-5,trueCarre(numVid)+5])
ylim([-5,trueCarre(numVid)+5])
colormap parula(256);colorbar
end
