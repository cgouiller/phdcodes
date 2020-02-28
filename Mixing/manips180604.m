%Méthode de background :
%Chemins où récupérer/enregistrer les données.
basePathVid='E:\Laurent\Mixing\Analyse\';
basePathAnalyse='E:\Laurent\Mixing\Analyse\';
basePathVidProcessed='E:\Laurent\Mixing\Analyse\';

%Ne traiter qu'une image toutes les 'saut' images
saut=1;

sizeim=3096;
%fps of the videos
fps=1/15;

%numbre of videos in the set
nombreVid=3;

%date de prise des videos (pour le path)
date='180604\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varNumber_large\';setCatalogue{2}='varNumber_large\';setCatalogue{3}='varNumber_large\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='5';videoCatalogue{2}='10';videoCatalogue{3}='40';
%Diameter of the camphor swimmers
RCat=[5;5;5];


%radius of the area of interest in pixel 
radiusCellPx=3096/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);


%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.

startImgCatalogue=[1;1;1];

%top left corner of the square in which the free surface of water is
centerCellXCat=[1467;1449;1426];
centerCellYCat=[470;384;477];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[1466;1448;1426];
centerCellYBgCat=[471;388;475];


%Starting time (in s) of the stationnary zone
startCatalogue=[1*15;1*15;1*15];
endCatalogue=[20*15;20*15;20*15];

%Number of images to be considered in the stationary zone
Nstationary=20;

format='*.tif';
