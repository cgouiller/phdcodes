%%

Date=[];
Rayon=[];
Nombre=[];
Set={};
Video={};
AmpVortex=[];
run('E:\Clément\phdcodes\Multi\manips.m')
for numVid=1:nombreVid
    load_param;
    load(strcat(directoryAnalyse,'directory.mat'));
    load(strcat(directoryAnalyse,'trajectories.mat'))

    xraw=tracks(:,1)';
    yraw=tracks(:,2)';
    t=zeros(1,length(xraw));
    for i=1:length(xraw)
          fname=L(tracks(i,3)).name;
          t(i)=str2double(fname(1:7))/fps;
    end
    x1=tracks(:,1)-hgxcat(numVid);
y1=tracks(:,2)-hgycat(numVid);
angle=mean([atan(-(hdycat(numVid)-hgycat(numVid))/(hdxcat(numVid)-hgxcat(numVid))),atan(-(bdycat(numVid)-bgycat(numVid))/(bdxcat(numVid)-bgxcat(numVid))),atan((hdxcat(numVid)-bdxcat(numVid))/(hdycat(numVid)-bdycat(numVid))),atan((hgxcat(numVid)-bgxcat(numVid))/(hgycat(numVid)-bgycat(numVid)))]);
x2=cos(angle)*x1-sin(angle)*y1;
y2=sin(angle)*x1+cos(angle)*y1;
x3=x2*calib;
y3=y2*calib;
pas=coteCarre(numVid)*calib/5;

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
xedgeraw=xedge;
yedgeraw=yedge;
xedge1=xedge-hgx;
yedge1=yedge-hgx;
xedge2=cos(angle)*xedge1-sin(angle)*yedge1;
yedge2=sin(angle)*xedge1+cos(angle)*yedge1;
xedge3=xedge2*calib;
yedge3=yedge2*calib;
x=x3;
y=y3;
xedge=xedge3;
yedge=yedge3;
save(strcat(directoryPyt,'positions.mat'),'x','y','xraw','yraw','xedge','yedge','xedgeraw','yedgeraw','t')    

    Date=[Date;dateCatalogue{numVid}];
    Rayon=[Rayon,RCat(numVid)];
    Nombre=[Nombre,NCat(numVid)];
    Set{numVid}=setCatalogue{numVid};
    Video{numVid}=videoCatalogue{numVid};
    vtmp=videoCatalogue{numVid};
    AmpVortex=[AmpVortex,str2num(vtmp(1:end-1))];
end
save('E:\Clément\MyCore\Analyse\Multi\manips.mat','Nombre','AmpVortex','Date','Set','Rayon','Video')
