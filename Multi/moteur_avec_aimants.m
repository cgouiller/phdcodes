run defaultfig;

minDelay=[480,440,400,360,320,280,260,624,810,1054,1370,1782,2316,3012,220,180,140,110,80]*10^(-6);
minDelayus=minDelay*10^6;
fps=35;

%% Arduino
frqclock=[1555,1660,1787,1925,2085,2275,2362,1270,1030,818,652,513,402,314,2607,2911,3295,3682,4171]/200;


%% Moteur en charge

nbtour=[2,9,16,3,8,10,27,6,5,7,4,3,5,3,19,27,8,11,16];
deltaim=[9,38,63,11,27,31,80,33,34,60,43,41,87,67,51,65,17,21,27];

%% Moteur à vide
%minDelay2=[810,1054,1370,1782,2316,3012]*10^(-6);
%nbtour2=[6,7,4,3,5,3];
%deltaim2=[41,60,43,41,87,67];
%frqcalc2=1./(200*minDelay2);
%frqreel2=1./(deltaim2./nbtour2./fps);
%plot(frqcalc2,frqreel2,'xk')

%% Agitateurs magnétiques
nbtour4=[2,4,3,6,8,10,4,9,5,2,3,3,2,2,13,5,8,11,19];
deltaim4=[9,17,12,22,27,31,12,50,34,17,32,41,35,45,35,12,17,21,32];

%% Affichages et calculs
frqbarreau=1./(deltaim4./nbtour4./fps);
frqcalc=1./(200*minDelay);
frqmoteur=1./(deltaim./nbtour./fps);
plot(minDelayus,frqcalc,'xk','markersize',10)
hold on;
plot(minDelayus,frqclock,'oc','markersize',10,'linewidth',2)
plot(minDelayus,frqmoteur,'+b','markersize',10)
plot(minDelayus,frqbarreau,'dm','markersize',10)
ylabel('freq [tr/sec]')
xlabel('minDelay [us]')




legend({'freq théorique','freq arduino','freq moteur','freq barreau'})