%Chemins où récupérer/enregistrer les données.
basePathVid='I:\Vortex\';
basePathAnalyse='E:\Clément\Vortex\Analyse';

sizeim=1671;

%fps of the videos
fps=35;

%numbre of videos in the set
nombreVid=4;

%date de prise des videos (pour le path)
date='190221\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varSize\';setCatalogue{2}='varSize\';setCatalogue{3}='varSize\';setCatalogue{4}='varSize\';
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='6';videoCatalogue{2}='4';videoCatalogue{3}='8';videoCatalogue{4}='2';

%Radii of the camphor swimmers
RCat=[6;4;8;2]/2;
%Speed of the barrel
speedCat=[150;150;150;150];

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
centerCellXCat=[193;169;160;142];
centerCellYCat=[201;181;211;240];


format='*.tif';
