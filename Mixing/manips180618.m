%Méthode de background :
%Chemins où récupérer/enregistrer les données.
basePathVid='I:\Mixing\nageur_passif\';
basePathAnalyse='E:\Laurent\Mixing\Analyse\';


saut=1;
%fps of the videos
fps=20;

%numbre of videos in the set
nombreVid=10;

%date de prise des videos (pour le path)
date='180618\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varSpeed\';setCatalogue{2}='varSpeed\';setCatalogue{3}='varSpeed\';setCatalogue{4}='varSpeed\';setCatalogue{5}='varSpeed\';setCatalogue{6}='varSpeed\';
setCatalogue{7}='varSpeed\';setCatalogue{8}='varSpeed\';setCatalogue{9}='varSpeed\';setCatalogue{10}='varSpeed\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='365';videoCatalogue{2}='730';videoCatalogue{3}='1095';videoCatalogue{4}='1460';videoCatalogue{5}='1825';videoCatalogue{6}='2190';
videoCatalogue{7}='2555';videoCatalogue{8}='2920';videoCatalogue{9}='3285';videoCatalogue{10}='3650';

%Diameter of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5];


%calibration in mm/px
calib=60/770;

%Image de début du mouvement
startIm=[359;524;468;482;480;610;526;497;553;647];

%Image de fin de mouvement (arret du moteur, malgré les qq oscillations
%perceptibles à cause de l'inertie)
endIm=[592;642;548;542;529;652;567;528;581;673];


%Positions de debut et fin pour déduire la zone d'interet
startPosX=[187;157;162;148;140;128;75;138;366;348];
startPosY=[1064;1024;1144;1169;1216;1355;1195;1241;1262;1248];

endPosX=[1659;1630;1635;1619;1612;1599;1548;1613;1837;1820];
endPosY=[933;894;1012;1038;1087;1228;1067;1112;1134;1120];

 %definition de la zone d'interet
topLeftX=startPosX-200;
    for i=1:length(topLeftX)
        if topLeftX(i)<=0
            topLeftX(i)=1;
        end
    end
    topLeftY=min(startPosY,endPosY)-300;
    
    bottomRightX=endPosX+200;
    bottomRightY=max(startPosY,endPosY)+300;

%Sensibilité pour la détection de particules
Sens=[0.93;0.92;0.95;0.96;0.93;0.96;0.92;0.92;0.93;0.95];

format='*.tif';
