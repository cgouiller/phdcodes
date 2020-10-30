36.15 et 84.35

load(strcat(directoryAnalyse,'trajectories.mat'))
x1=tracks(:,1)-hgxcat(numVid);
y1=tracks(:,2)-hgycat(numVid);
angle=mean([atan(-(hdycat(numVid)-hgycat(numVid))/(hdxcat(numVid)-hgxcat(numVid))),atan(-(bdycat(numVid)-bgycat(numVid))/(bdxcat(numVid)-bgxcat(numVid))),atan((hdxcat(numVid)-bdxcat(numVid))/(hdycat(numVid)-bdycat(numVid))),atan((hgxcat(numVid)-bgxcat(numVid))/(hgycat(numVid)-bgycat(numVid)))]);
x2=cos(angle)*x1-sin(angle)*y1;
y2=sin(angle)*x1+cos(angle)*y1;
x3=x2*calib;
y3=y2*calib;
t=inpolygon(x3,y3,[36.15,84.35,84.35,36.15],[36.15,36.15,84.35,84.35]);
x3=x3(t);
y3=y3(t);

x31v=mod(x3,24.1);
y31v=mod(y3,24.1);