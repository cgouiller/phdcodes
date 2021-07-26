clear all;run defaultfig;
%numbre of videos in the set
nombreVid=13;
basePathAnalyse='E:\Clément\Vortex\Analyse\';
%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='J:\Vortex\';basePathVidCatalogue{2}='J:\Vortex\';basePathVidCatalogue{3}='J:\Vortex\';basePathVidCatalogue{4}='J:\Vortex\';basePathVidCatalogue{5}='J:\Vortex\';basePathVidCatalogue{6}='J:\Vortex\';basePathVidCatalogue{7}='J:\Vortex\';basePathVidCatalogue{8}='J:\Vortex\';basePathVidCatalogue{9}='J:\Vortex\';basePathVidCatalogue{10}='J:\Vortex\';
basePathVidCatalogue{11}='J:\Vortex\';basePathVidCatalogue{12}='J:\Vortex\';basePathVidCatalogue{13}='J:\Vortex\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;


%fps of the videos
fps=20;


%date de prise des videos (pour le path)
dateCatalogue=cell(1,nombreVid);
dateCatalogue{1}='191127\';dateCatalogue{2}='191127\';dateCatalogue{3}='191127\';dateCatalogue{4}='191127\';dateCatalogue{5}='191127\';dateCatalogue{6}='191127\';dateCatalogue{7}='191127\';dateCatalogue{8}='191127\';dateCatalogue{9}='191127\';dateCatalogue{10}='191127\';
dateCatalogue{11}='191127\';dateCatalogue{12}='191127\';dateCatalogue{13}='191127\';

%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='passif\';setCatalogue{2}='passif\';setCatalogue{3}='passif\';setCatalogue{4}='passif\';setCatalogue{5}='actif\';setCatalogue{6}='actif\';setCatalogue{7}='actif\';setCatalogue{8}='actif\';setCatalogue{9}='ellipse\';setCatalogue{10}='ellipse\';
setCatalogue{11}='ellipse\';setCatalogue{12}='ellipse\';setCatalogue{13}='ellipse\';


%Name of the folders (nombre de nageurs / nb de tours/min de l'agitateur)
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='1\0\';videoCatalogue{2}='1\120\';videoCatalogue{3}='15\0\';videoCatalogue{4}='15\120\';videoCatalogue{5}='1\0\';videoCatalogue{6}='1\120\';videoCatalogue{7}='15\0\';videoCatalogue{8}='15\120\';videoCatalogue{9}='1\0\';videoCatalogue{10}='1\120\';
videoCatalogue{11}='15\0\';videoCatalogue{12}='15\120\';videoCatalogue{13}='15\120b\';


NCat=[1;1;15;15;1;1;15;15;1;1;15;15;15];

% Small axis Cat of the particle
SCat=[5;5;5;5;5;5;5;5;4;4;4;4;4];
% Large axis Cat of the particle
LCat=[5;5;5;5;5;5;5;5;8;8;8;8;8];


%top left corner of the square in which the free surface of water is
centerCellXCat=[366;360;361;362;364;361;394;393;396;392;398;394;394];
centerCellYCat=[199;195;195;196;197;197;243;243;248;250;250;248;249];

%radius of the area of interest in pixel 
radiusCellPxCat=[1496;1498;1499;1495;1497;1500;1517;1518;1511;1511;1508;1512;1511]/2;

%calibration in mm/px
calibCat=198./(2*radiusCellPxCat);


%top left corner of the square in which the disk agitator is
centerAgitXCat=[811;814;811;810;814;811;807;807;810;805;807;807;810];
centerAgitYCat=[756;754;749;754;752;756;753;756;756;758;756;757;757];

% size of the square in which the agitator is
sizeAgitCat=[532;529;533;531;529;530;530;528;529;528;531;525;529];


%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=ones(1,nombreVid);

format='*.tif';
