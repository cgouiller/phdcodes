%Chemins où récupérer/enregistrer les données.
basePathVid='J:\Mixing\';
basePathAnalyse='E:\Clément\Vortex\Analyse';

sizeim=1842;

%fps of the videos
fps=35;

%numbre of videos in the set
nombreVid=1;

%date de prise des videos (pour le path)
date='190904\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='tests\';
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='vortex';

NCat=[15];
%Radii of the camphor swimmers
RCat=[5]/2;
%Speed of the barrel
speedCat=[300];

%radius of the area of interest in pixel 
radiusCellPx=sizeim/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);

%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[1;1;1;1];
endImgCatalogue=[6300;6300;6300;6300];


%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXCat=[45];
centerCellYCat=[79];


format='*.tif';
