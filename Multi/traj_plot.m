load(strcat(directoryAnalyse,'trajectories.mat'))
figure;
x1=tracks(:,1)-hgxcat(numVid);
y1=tracks(:,2)-hgycat(numVid);
angle=mean([atan(-(hdycat(numVid)-hgycat(numVid))/(hdxcat(numVid)-hgxcat(numVid))),atan(-(bdycat(numVid)-bgycat(numVid))/(bdxcat(numVid)-bgxcat(numVid))),atan((hdxcat(numVid)-bdxcat(numVid))/(hdycat(numVid)-bdycat(numVid))),atan((hgxcat(numVid)-bgxcat(numVid))/(hgycat(numVid)-bgycat(numVid)))]);
x2=cos(angle)*x1-sin(angle)*y1;
y2=sin(angle)*x1+cos(angle)*y1;
x3=x2*calib;
y3=y2*calib;
plot(x3,y3,'-');hold on;
pas=coteCarre(numVid)*calib/5;
for i=1:4
    for j=1:4
        if mod(i,2)==mod(j,2)
            plot(i*pas,j*pas,'+r','MarkerSize',10,'LineWidth',2)
            i*pas
        else
            plot(i*pas,j*pas,'xk','MarkerSize',10,'LineWidth',2)
        end
    end
end

hgx=hgxcat(numVid);
hgy=hgycat(numVid);
hdx=hdxcat(numVid);
hdy=hdycat(numVid);
bgx=bgxcat(numVid);
bgy=bgycat(numVid);
bdx=bdxcat(numVid);
bdy=bdycat(numVid);
xedge=[hgx,hdx,bdx,bgx,hgx];
yedge=[hgy,hdy,bdy,bgy,hgy];
xedge1=xedge-hgx;
yedge1=yedge-hgy;
xedge2=cos(angle)*xedge1-sin(angle)*yedge1;
yedge2=sin(angle)*xedge1+cos(angle)*yedge1;
xedge3=xedge2*calib;
yedge3=yedge2*calib;
plot(xedge3,yedge3,'-k','LineWidth',2)
axis square;
xlabel('x [mm]')
ylabel('y [mm]')
xlim([-5,125.5])
ylim([-5,125.5])
%% test
% hgx=0;
% hgy=0;
% hdx=1;
% hdy=-1;
% bdy=0;
% bdx=2;
% bgx=1;
% bgy=1;
% plot(hgx,hgy,'+');hold on;plot(hdx,hdy,'+');plot(bgx,bgy,'+');plot(bdx,bdy,'+')
% angle=mean([atan(-(hdy-hgy)/(hdx-hgx)),atan(-(bdy-bgy)/(bdx-bgx)),atan((hdx-bdx)/(hdy-bdy)),atan((hgx-bgx)/(hgy-bgy))]);
% hdx2=cos(angle)*hdx-sin(angle)*hdy;
% hdy2=sin(angle)*hdx+cos(angle)*hdy;