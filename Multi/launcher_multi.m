clear all;


run('E:\Clément\phdcodes\Multi\manipspiv.m');


for numVid=2%[2,1,3]%:3
% xs=[bdxcat(numVid)-bgxcat(numVid),hdxcat(numVid)-bdxcat(numVid),hdxcat(numVid)-hgxcat(numVid),hgxcat(numVid)-bgxcat(numVid)];
% ys=-[bdycat(numVid)-bgycat(numVid),hdycat(numVid)-bdycat(numVid),hdycat(numVid)-hgycat(numVid),hgycat(numVid)-bgycat(numVid)];
% angles=atan(ys./xs);
% angles(2)=angles(2)-pi/2;
% angles(4)=angles(4)-pi/2;
% 
% angles(xs<0)=angles(xs<0)+pi;
% std1=std(angles)
% angles2=[atan((hdycat(numVid)-hgycat(numVid))/(hdxcat(numVid)-hgxcat(numVid))),atan((bdycat(numVid)-bgycat(numVid))/(bdxcat(numVid)-bgxcat(numVid))),atan((hdxcat(numVid)-bdxcat(numVid))/(hdycat(numVid)-bdycat(numVid))),atan((hgxcat(numVid)-bgxcat(numVid))/(hgycat(numVid)-bgycat(numVid)))];
% std2=std(angles2)
%     numVid
% val=180/pi*[atan((bdycat(numVid)-bgycat(numVid))/(bdxcat(numVid)-bgxcat(numVid))),atan((hdycat(numVid)-bdycat(numVid))/(hdxcat(numVid)-bdxcat(numVid)))-pi/2,atan((hdycat(numVid)-hgycat(numVid))/(hdxcat(numVid)-hgxcat(numVid))),atan((hgycat(numVid)-bgycat(numVid))/(hgxcat(numVid)-bgxcat(numVid)))-pi/2];
% val(val<-90)=val(val<-90)+180;
% angle=-mean(val)*pi/180
% angle=mean([atan(-(hdycat(numVid)-hgycat(numVid))/(hdxcat(numVid)-hgxcat(numVid))),atan(-(bdycat(numVid)-bgycat(numVid))/(bdxcat(numVid)-bgxcat(numVid))),atan((hdxcat(numVid)-bdxcat(numVid))/(hdycat(numVid)-bdycat(numVid))),atan((hgxcat(numVid)-bgxcat(numVid))/(hgycat(numVid)-bgycat(numVid)))])
% 
% hgx=hgxcat(numVid);
% hgy=hgycat(numVid);
% hdx=hdxcat(numVid);
% hdy=hdycat(numVid);
% bgx=bgxcat(numVid);
% bgy=bgycat(numVid);
% bdx=bdxcat(numVid);
% bdy=bdycat(numVid);
% xedge=[hgx,hdx,bdx,bgx]-centerXCat(numVid);
% yedge=[hgy,hdy,bdy,bgy]-centerYCat(numVid);
% xedger=cos(angle)*xedge-sin(angle)*yedge;
% yedger=sin(angle)*xedge+cos(angle)*yedge;
% xedge2=xedger+centerXCat(numVid);
% yedge2=yedger+centerYCat(numVid);
% xedge3=(xedge2-xedge2(1))*calibCat(numVid);
% yedge3=(yedge2-yedge2(1))*calibCat(numVid);

    basePathVid=strjoin(basePathVidCatalogue(numVid));
    video=strjoin(videoCatalogue(numVid));
    sete=strjoin(setCatalogue(numVid));
    startImg=startImgCatalogue(numVid);
    date=strjoin(dateCatalogue(numVid));
    % build paths and create directories
    directoryVid=strcat(basePathVid,date,sete,video);
    directoryPiv=strcat(directoryVid,'piv\');
    if exist(directoryPiv)==0
        mkdir(directoryPiv);
    end
%     PIV_pretreatment_multi;
%     dpiv_nappe_multi;
%      PIV_treatment_multi;
    piv_plot;
end
