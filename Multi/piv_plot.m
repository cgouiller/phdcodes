load(strcat(directoryPiv,'PIV_mean_mask.mat'))
%angle=-mean([atan(-(hdycat(numVid)-hgycat(numVid))/(hdxcat(numVid)-hgxcat(numVid))),atan(-(bdycat(numVid)-bgycat(numVid))/(bdxcat(numVid)-bgxcat(numVid))),atan((hdxcat(numVid)-bdxcat(numVid))/(hdycat(numVid)-bdycat(numVid))),atan((hgxcat(numVid)-bgxcat(numVid))/(hgycat(numVid)-bgycat(numVid)))]);
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

% hgx=hgxcat(numVid);
% hgy=hgycat(numVid);
% hdx=hdxcat(numVid);
% hdy=hdycat(numVid);
% bgx=bgxcat(numVid);
% bgy=bgycat(numVid);
% bdx=bdxcat(numVid);
% bdy=bdycat(numVid);
% xlist=[hgx,hdx,bdx,bgx];
% ylist=[hgy,hdy,bdy,bgy];
% xedge=xlist-centerval;
% yedge=ylist-centerval;
% xedger=cos(angle)*xedge+sin(angle)*yedge;
% yedger=-sin(angle)*xedge+cos(angle)*yedge;
% xedge2=xedger+centerval;
% yedge2=yedger+centerval;
xedge2=[centerval-coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval-coteCarre(numVid)/2];
yedge2=[centerval-coteCarre(numVid)/2,centerval-coteCarre(numVid)/2,centerval+coteCarre(numVid)/2,centerval+coteCarre(numVid)/2];
in=inpolygon(x,y,xedge2,yedge2);
Umoy=Umoy.*in;
Vmoy=Vmoy.*in;
xedge3=(xedge2-xedge2(1))*calibCat(numVid);
yedge3=(yedge2-yedge2(1))*calibCat(numVid);
%plot([xedge3,xedge3(1)],[yedge3,yedge3(1)],'-k','LineWidth',2)
vmax=18;
Umoy=Umoy*calibCat(numVid)*30;
Vmoy=Vmoy*calibCat(numVid)*30;
normv=sqrt(Umoy.^2+Vmoy.^2);
Umoy(normv>vmax)=Umoy(normv>vmax)*vmax./normv(normv>vmax);
Vmoy(normv>vmax)=Vmoy(normv>vmax)*vmax./normv(normv>vmax);

quiverC2D((x-xedge2(1))*calibCat(numVid),(y-yedge2(1))*calibCat(numVid),Umoy,Vmoy);colorbar;
axis square;
xlabel('x [mm]')
ylabel('y [mm]')
title(strcat(sete,num2str(max(max(sqrt((Umoy).^2+(Vmoy).^2))))))
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