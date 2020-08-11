load(strcat(directoryVid,'PIV_mean.mat'))
%angle=-mean([atan(-(hdycat(numVid)-hgycat(numVid))/(hdxcat(numVid)-hgxcat(numVid))),atan(-(bdycat(numVid)-bgycat(numVid))/(bdxcat(numVid)-bgxcat(numVid))),atan((hdxcat(numVid)-bdxcat(numVid))/(hdycat(numVid)-bdycat(numVid))),atan((hgxcat(numVid)-bgxcat(numVid))/(hgycat(numVid)-bgycat(numVid)))]);
xs=[bdxcat(numVid)-bgxcat(numVid),hdxcat(numVid)-bdxcat(numVid),hdxcat(numVid)-hgxcat(numVid),hgxcat(numVid)-bgxcat(numVid)];
ys=-[bdycat(numVid)-bgycat(numVid),hdycat(numVid)-bdycat(numVid),hdycat(numVid)-hgycat(numVid),hgycat(numVid)-bgycat(numVid)]; %à cause d'imageJ
angles=atan(ys./xs);
angles(2)=angles(2)-pi/2;
angles(4)=angles(4)-pi/2;

angles(xs<0)=angles(xs<0)+pi;
angle=-mean(angles); %- parce qu'on veut tourner dans l'autre sens que celui qu'on a mesuré!
figure;

hgx=hgxcat(numVid);
hgy=hgycat(numVid);
hdx=hdxcat(numVid);
hdy=hdycat(numVid);
bgx=bgxcat(numVid);
bgy=bgycat(numVid);
bdx=bdxcat(numVid);
bdy=bdycat(numVid);
xedge=[hgx,hdx,bdx,bgx]-centerXCat(numVid);
yedge=[hgy,hdy,bdy,bgy]-centerYCat(numVid);
xedger=cos(angle)*xedge-sin(angle)*yedge;
yedger=sin(angle)*xedge+cos(angle)*yedge;
xedge2=xedger+centerXCat(numVid);
yedge2=yedger+centerYCat(numVid);
in=inpolygon(x,y,xedge2,yedge2);
Umoy=Umoy.*in;
Vmoy=Vmoy.*in;
xedge3=(xedge2-xedge2(1))*calibCat(numVid);
yedge3=(yedge2-yedge2(1))*calibCat(numVid);
%plot([xedge3,xedge3(1)],[yedge3,yedge3(1)],'-k','LineWidth',2)
quiverC2D((x-xedge2(1))*calibCat(numVid),(y-yedge2(1))*calibCat(numVid),Umoy*calibCat(numVid)*30,Vmoy*calibCat(numVid)*30)
axis square;
xlabel('x [mm]')
ylabel('y [mm]')
hold on;
if trueCarre(numVid)==120.5
    pas=coteCarre(numVid)*calibCat(numVid)/5;
    for i=1:4
        for j=1:4
            if mod(i,2)==mod(j,2)
                plot(i*pas,j*pas,'+r','MarkerSize',10,'LineWidth',2)
            else
                plot(i*pas,j*pas,'xk','MarkerSize',10,'LineWidth',2)
            end
        end
    end
elseif trueCarre(numVid)==96.4
        pas=coteCarre(numVid)*calibCat(numVid)/4;

    for i=1:4
        for j=1:4
            if mod(i,2)==mod(j,2)
                plot((0.5+(i-1))*pas,(0.5+(j-1))*pas,'+r','MarkerSize',10,'LineWidth',2)
            else
                plot((0.5+(i-1))*pas,(0.5+(j-1))*pas,'xk','MarkerSize',10,'LineWidth',2)
            end
        end
    end
    
end
xlim([-5,trueCarre(numVid)+5])
ylim([-5,trueCarre(numVid)+5])