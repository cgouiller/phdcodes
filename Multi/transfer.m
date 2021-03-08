%%

Date={};
Rayon=[];
Nombre=[];
Set={};
Act={};
Video={};
AmpVortex=[];
Raystr={};
run('E:\Clément\phdcodes\Multi\manips.m')
for numVid=1:nombreVid
    load_param;
    if numVid>105 && exist(strcat(directoryAnalyse,'trajectories.mat'))~=0
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
    end
    % load(strcat(directoryAnalyse,'msd.mat'))
    % load(strcat(directoryAnalyse,'msd_tot.mat'))
    %
    % save(strcat(directoryPyt,'msd.mat'),'tau','MeanSD')
    
    
    %
    %
    %date de prise des videos (pour le path)
    % dateCatalogue=cell(1,nombreVid);
    % dateCatalogue{1}='200603';dateCatalogue{2}='200603';dateCatalogue{3}='200603';dateCatalogue{4}='200603';dateCatalogue{5}='200603';dateCatalogue{6}='200603';dateCatalogue{7}='200603';dateCatalogue{8}='200603';dateCatalogue{9}='200603';dateCatalogue{10}='200603';
    % dateCatalogue{11}='200603';dateCatalogue{12}='200603';dateCatalogue{13}='200603';dateCatalogue{14}='200603';dateCatalogue{15}='200603';dateCatalogue{16}='200603';dateCatalogue{17}='200603';dateCatalogue{18}='200603';dateCatalogue{19}='200603';dateCatalogue{20}='200603';
    % dateCatalogue{21}='200608';dateCatalogue{22}='200608';dateCatalogue{23}='200608';dateCatalogue{24}='200608';dateCatalogue{25}='200608';dateCatalogue{26}='200608';dateCatalogue{27}='200608';dateCatalogue{28}='200608';dateCatalogue{29}='200608';dateCatalogue{30}='200608';
    % dateCatalogue{31}='200608';dateCatalogue{32}='200608';dateCatalogue{33}='200608';dateCatalogue{34}='200608';dateCatalogue{35}='200608';dateCatalogue{36}='200608';dateCatalogue{37}='200617';dateCatalogue{38}='200617';dateCatalogue{39}='200617';dateCatalogue{40}='200617';
    % dateCatalogue{41}='200617';dateCatalogue{42}='200617';dateCatalogue{43}='200617';dateCatalogue{44}='200617';dateCatalogue{45}='200617';dateCatalogue{46}='200617';dateCatalogue{47}='200617';dateCatalogue{48}='200617';dateCatalogue{49}='200617';dateCatalogue{50}='200617';
    % dateCatalogue{51}='200617';dateCatalogue{52}='200617';
    %
    % %Catalogue of paths (concatenation of 'Mixing\date\set\video\')
    % setCatalogue=cell(1,nombreVid);
    % setCatalogue{1}='varVite';setCatalogue{2}='varVite';setCatalogue{3}='varVite';setCatalogue{4}='varVite';setCatalogue{5}='varVite';setCatalogue{6}='varVite';setCatalogue{7}='varVite';setCatalogue{8}='varVite';setCatalogue{9}='varVite';setCatalogue{10}='varVite';
    % setCatalogue{11}='varVite';setCatalogue{12}='varVite';setCatalogue{13}='varVite';setCatalogue{14}='varVite';setCatalogue{15}='varVite';setCatalogue{16}='varVite';setCatalogue{17}='varVite';setCatalogue{18}='varVite';setCatalogue{19}='varVite';setCatalogue{20}='varVite';
    % setCatalogue{21}='varSize';setCatalogue{22}='varSize';setCatalogue{23}='varSize';setCatalogue{24}='varSize';setCatalogue{25}='varSize';setCatalogue{26}='varSize';setCatalogue{27}='varSize';setCatalogue{28}='varSize';setCatalogue{29}='varSize';setCatalogue{30}='varSize';
    % setCatalogue{31}='varSize';setCatalogue{32}='varSize';setCatalogue{33}='varSize';setCatalogue{34}='varSize';setCatalogue{35}='varSize';setCatalogue{36}='varSize';setCatalogue{37}='varSize';setCatalogue{38}='varSize';setCatalogue{39}='varSize';setCatalogue{40}='varSize';
    % setCatalogue{41}='varSize';setCatalogue{42}='varSize';setCatalogue{43}='varSize';setCatalogue{44}='varSize';setCatalogue{45}='varSize';setCatalogue{46}='varSize';setCatalogue{47}='varSize';setCatalogue{48}='varSize';setCatalogue{49}='varSize';setCatalogue{50}='varSize';
    % setCatalogue{51}='varSize';setCatalogue{52}='varSize';
    %
    % actCatalogue=cell(1,nombreVid);
    % actCatalogue{1}='actif';actCatalogue{2}='actif';actCatalogue{3}='actif';actCatalogue{4}='actif';actCatalogue{5}='actif';actCatalogue{6}='actif';actCatalogue{7}='actif';actCatalogue{8}='actif';actCatalogue{9}='actif';actCatalogue{10}='actif';
    % actCatalogue{11}='passif';actCatalogue{12}='passif';actCatalogue{13}='passif';actCatalogue{14}='passif';actCatalogue{15}='passif';actCatalogue{16}='passif';actCatalogue{17}='passif';actCatalogue{18}='passif';actCatalogue{19}='passif';actCatalogue{20}='passif';
    % actCatalogue{21}='actif';actCatalogue{22}='actif';actCatalogue{23}='actif';actCatalogue{24}='actif';actCatalogue{25}='actif';actCatalogue{26}='actif';actCatalogue{27}='actif';actCatalogue{28}='actif';actCatalogue{29}='passif';actCatalogue{30}='passif';
    % actCatalogue{31}='passif';actCatalogue{32}='passif';actCatalogue{33}='passif';actCatalogue{34}='passif';actCatalogue{35}='passif';actCatalogue{36}='passif';actCatalogue{37}='passif';actCatalogue{38}='passif';actCatalogue{39}='passif';actCatalogue{40}='actif';
    % actCatalogue{41}='actif';actCatalogue{42}='actif';actCatalogue{43}='passif';actCatalogue{44}='passif';actCatalogue{45}='passif';actCatalogue{46}='passif';actCatalogue{47}='passif';actCatalogue{48}='actif';actCatalogue{49}='actif';actCatalogue{50}='actif';
    % actCatalogue{51}='actif';actCatalogue{52}='actif';
    %
    %
    %
    % %Name of the folders
    % videoCatalogue=cell(1,nombreVid);
    % videoCatalogue{1}='60';videoCatalogue{2}='90';videoCatalogue{3}='120';videoCatalogue{4}='150';videoCatalogue{5}='180';videoCatalogue{6}='240';videoCatalogue{7}='300';videoCatalogue{8}='360';videoCatalogue{9}='450';videoCatalogue{10}='600';
    % videoCatalogue{11}='60';videoCatalogue{12}='90';videoCatalogue{13}='120';videoCatalogue{14}='150';videoCatalogue{15}='180';videoCatalogue{16}='240';videoCatalogue{17}='300';videoCatalogue{18}='360';videoCatalogue{19}='450';videoCatalogue{20}='600';
    % videoCatalogue{21}='90';videoCatalogue{22}='150';videoCatalogue{23}='300';videoCatalogue{24}='600';videoCatalogue{25}='60';videoCatalogue{26}='150';videoCatalogue{27}='300';videoCatalogue{28}='600';videoCatalogue{29}='90';videoCatalogue{30}='150';
    % videoCatalogue{31}='300';videoCatalogue{32}='600';videoCatalogue{33}='90';videoCatalogue{34}='150';videoCatalogue{35}='300';videoCatalogue{36}='600';videoCatalogue{37}='0';videoCatalogue{38}='0';videoCatalogue{39}='0';videoCatalogue{40}='0';
    % videoCatalogue{41}='0';videoCatalogue{42}='0';videoCatalogue{43}='0';videoCatalogue{44}='90';videoCatalogue{45}='150';videoCatalogue{46}='300';videoCatalogue{47}='600';videoCatalogue{48}='0';videoCatalogue{49}='90';videoCatalogue{50}='150';
    % videoCatalogue{51}='300';videoCatalogue{52}='600';
    
    Date{numVid}=dateCatalogue{numVid};
    Rayon=[Rayon,RCat(numVid)];
    Nombre=[Nombre,NCat(numVid)];
    Set{numVid}=setCatalogue{numVid};
    Act{numVid}=actCatalogue{numVid};
    Video{numVid}=videoCatalogue{numVid};
    Raystr{numVid}=num2str(floor(2*RCat(numVid)));
    AmpVortex=[AmpVortex,minDelay(numVid)];
  
    
end
save('E:\Clément\MyCore\Analyse\Multi\manips.mat','Nombre','AmpVortex','Date','Set','Rayon','Video','Act','Raystr')
