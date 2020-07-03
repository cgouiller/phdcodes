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
yedge1=yedge-hgy;
xedge2=cos(angle)*xedge1-sin(angle)*yedge1;
yedge2=sin(angle)*xedge1+cos(angle)*yedge1;
xedge3=xedge2*calib;
yedge3=yedge2*calib;
x=x3;
y=y3;
xedge=xedge3;
yedge=yedge3;
save(strcat(directoryPyt,'positions.mat'),'x','y','xraw','yraw','xedge','yedge','xedgeraw','yedgeraw','t','pas')    

%load(strcat(directoryAnalyse,'msd.mat'))
%load(strcat(directoryAnalyse,'msd_tot.mat'))

%save(strcat(directoryPyt,'msd.mat'),'tau','MeanSD')    




%date de prise des videos (pour le path)
dateCatalogue=cell(1,nombreVid);
dateCatalogue{1}='200603\';dateCatalogue{2}='200603\';dateCatalogue{3}='200603\';dateCatalogue{4}='200603\';dateCatalogue{5}='200603\';dateCatalogue{6}='200603\';dateCatalogue{7}='200603\';dateCatalogue{8}='200603\';dateCatalogue{9}='200603\';dateCatalogue{10}='200603\';
dateCatalogue{11}='200603\';dateCatalogue{12}='200603\';dateCatalogue{13}='200603\';dateCatalogue{14}='200603\';dateCatalogue{15}='200603\';dateCatalogue{16}='200603\';dateCatalogue{17}='200603\';dateCatalogue{18}='200603\';dateCatalogue{19}='200603\';dateCatalogue{20}='200603\';
dateCatalogue{21}='200608\';dateCatalogue{22}='200608\';dateCatalogue{23}='200608\';dateCatalogue{24}='200608\';dateCatalogue{25}='200608\';dateCatalogue{26}='200608\';dateCatalogue{27}='200608\';dateCatalogue{28}='200608\';dateCatalogue{29}='200608\';dateCatalogue{30}='200608\';
dateCatalogue{31}='200608\';dateCatalogue{32}='200608\';dateCatalogue{33}='200608\';dateCatalogue{34}='200608\';dateCatalogue{35}='200608\';dateCatalogue{36}='200608\';dateCatalogue{37}='200617\';dateCatalogue{38}='200617\';dateCatalogue{39}='200617\';dateCatalogue{40}='200617\';
dateCatalogue{41}='200617\';dateCatalogue{42}='200617\';dateCatalogue{43}='200617\';dateCatalogue{44}='200617\';dateCatalogue{45}='200617\';dateCatalogue{46}='200617\';dateCatalogue{47}='200617\';dateCatalogue{48}='200617\';dateCatalogue{49}='200617\';dateCatalogue{50}='200617\';
dateCatalogue{51}='200617\';dateCatalogue{52}='200617\';

%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='actif\';setCatalogue{2}='actif\';setCatalogue{3}='actif\';setCatalogue{4}='actif\';setCatalogue{5}='actif\';setCatalogue{6}='actif\';setCatalogue{7}='actif\';setCatalogue{8}='actif\';setCatalogue{9}='actif\';setCatalogue{10}='actif\';
setCatalogue{11}='passif\';setCatalogue{12}='passif\';setCatalogue{13}='passif\';setCatalogue{14}='passif\';setCatalogue{15}='passif\';setCatalogue{16}='passif\';setCatalogue{17}='passif\';setCatalogue{18}='passif\';setCatalogue{19}='passif\';setCatalogue{20}='passif\';
setCatalogue{21}='varSize\actif\2\';setCatalogue{22}='varSize\actif\2\';setCatalogue{23}='varSize\actif\2\';setCatalogue{24}='varSize\actif\2\';setCatalogue{25}='varSize\actif\8\';setCatalogue{26}='varSize\actif\8\';setCatalogue{27}='varSize\actif\8\';setCatalogue{28}='varSize\actif\8\';setCatalogue{29}='varSize\passif\2\';setCatalogue{30}='varSize\passif\2\';
setCatalogue{31}='varSize\passif\2\';setCatalogue{32}='varSize\passif\2\';setCatalogue{33}='varSize\passif\8\';setCatalogue{34}='varSize\passif\8\';setCatalogue{35}='varSize\passif\8\';setCatalogue{36}='varSize\passif\8\';setCatalogue{37}='varSize\passif\2\';setCatalogue{38}='varSize\passif\5\';setCatalogue{39}='varSize\passif\8\';setCatalogue{40}='varSize\actif\2\';
setCatalogue{41}='varSize\actif\5\';setCatalogue{42}='varSize\actif\8\';setCatalogue{43}='varSize\passif\16\';setCatalogue{44}='varSize\passif\16\';setCatalogue{45}='varSize\passif\16\';setCatalogue{46}='varSize\passif\16\';setCatalogue{47}='varSize\passif\16\';setCatalogue{48}='varSize\actif\16\';setCatalogue{49}='varSize\actif\16\';setCatalogue{50}='varSize\actif\16\';
setCatalogue{51}='varSize\actif\16\';setCatalogue{52}='varSize\actif\16\';

%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='60\';videoCatalogue{2}='90\';videoCatalogue{3}='120\';videoCatalogue{4}='150\';videoCatalogue{5}='180\';videoCatalogue{6}='240\';videoCatalogue{7}='300\';videoCatalogue{8}='360\';videoCatalogue{9}='450\';videoCatalogue{10}='600\';
videoCatalogue{11}='60\';videoCatalogue{12}='90\';videoCatalogue{13}='120\';videoCatalogue{14}='150\';videoCatalogue{15}='180\';videoCatalogue{16}='240\';videoCatalogue{17}='300\';videoCatalogue{18}='360\';videoCatalogue{19}='450\';videoCatalogue{20}='600\';
videoCatalogue{21}='90\';videoCatalogue{22}='150\';videoCatalogue{23}='300\';videoCatalogue{24}='600\';videoCatalogue{25}='60\';videoCatalogue{26}='150\';videoCatalogue{27}='300\';videoCatalogue{28}='600\';videoCatalogue{29}='90\';videoCatalogue{30}='150\';
videoCatalogue{31}='300\';videoCatalogue{32}='600\';videoCatalogue{33}='90\';videoCatalogue{34}='150\';videoCatalogue{35}='300\';videoCatalogue{36}='600\';videoCatalogue{37}='0\';videoCatalogue{38}='0\';videoCatalogue{39}='0\';videoCatalogue{40}='0\';
videoCatalogue{41}='0\';videoCatalogue{42}='0\';videoCatalogue{43}='0\';videoCatalogue{44}='90\';videoCatalogue{45}='150\';videoCatalogue{46}='300\';videoCatalogue{47}='600\';videoCatalogue{48}='0\';videoCatalogue{49}='90\';videoCatalogue{50}='150\';
videoCatalogue{51}='300\';videoCatalogue{52}='600\';



    Date=[Date;dateCatalogue{numVid}];
    Rayon=[Rayon,RCat(numVid)];
    Nombre=[Nombre,NCat(numVid)];
    Set{numVid}=setCatalogue{numVid};
    Video{numVid}=videoCatalogue{numVid};
    vtmp=videoCatalogue{numVid};
    AmpVortex=[AmpVortex,str2num(vtmp(1:end-1))];
end
save('E:\Clément\MyCore\Analyse\Multi\manips.mat','Nombre','AmpVortex','Date','Set','Rayon','Video')
