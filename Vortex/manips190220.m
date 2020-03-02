%Chemins où récupérer/enregistrer les données.
basePathVid='I:\Vortex\';
basePathAnalyse='E:\Clément\Vortex\Analyse';

sizeim=1671;

%fps of the videos
fps=35;

%numbre of videos in the set
nombreVid=16;

%date de prise des videos (pour le path)
date='190220\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varNumber\';setCatalogue{2}='varNumber\';setCatalogue{3}='varNumber\';setCatalogue{4}='varNumber\';setCatalogue{5}='varNumber\';setCatalogue{6}='varNumber\';setCatalogue{7}='varNumber\';setCatalogue{8}='varNumber\';setCatalogue{9}='varNumber\';setCatalogue{10}='varNumber\';setCatalogue{11}='varNumber\';setCatalogue{12}='varNumber\';setCatalogue{13}='varNumber\';setCatalogue{14}='varNumber\';setCatalogue{15}='varNumber\';setCatalogue{16}='varNumber\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='10';videoCatalogue{2}='10';videoCatalogue{3}='10';videoCatalogue{4}='10';videoCatalogue{5}='10';videoCatalogue{6}='10';videoCatalogue{7}='10_2';videoCatalogue{8}='10_2';videoCatalogue{9}='10_2';videoCatalogue{10}='10_2';videoCatalogue{11}='10_2';videoCatalogue{12}='10_2';videoCatalogue{13}='10_3';videoCatalogue{14}='10_3';videoCatalogue{15}='10_3';videoCatalogue{16}='10_3';


%Radii of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5;5;5;5;5;5;5]/2;
%Speed of the barrel
speedCat=[0,60,120,180,90,150,150,90,180,120,60,0];

%radius of the area of interest in pixel 
radiusCellPx=sizeim/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);

%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[1;2942;5953;8781;11611;14384;1;3208;5908;8632;11265;13711];
endImgCatalogue=[2118;5175;8068;10905;13666;16548;2355;5338;7999;10771;13357;16000];


%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXCat=[140;140;140;140;140;140;254;254;254;254;254;254];
centerCellYCat=[265;265;265;265;265;265;209;209;209;209;209;209];


format='*.tif';
