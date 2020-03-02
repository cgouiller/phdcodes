%Chemins où récupérer/enregistrer les données.
basePathVid='J:\';
basePathAnalyse='E:\Clément\Vortex\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;

sizeim=1584;
%fps of the videos
fps=28;

%numbre of videos in the set
nombreVid=6;

%date de prise des videos (pour le path)
date='190201\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='testSpeed\';setCatalogue{2}='testSpeed\';setCatalogue{3}='testSpeed\';setCatalogue{4}='testSpeed\';setCatalogue{5}='testSpeed\';setCatalogue{6}='testSpeed\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='0\';videoCatalogue{2}='60\';videoCatalogue{3}='120\';videoCatalogue{4}='180\';videoCatalogue{5}='240\';videoCatalogue{6}='500\';

%Radii of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5]/2;


%radius of the area of interest in pixel 
radiusCellPx=sizeim/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);

%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[1;1;1;1;1;1;1;1];

%top left corner of the square in which the free surface of water is
centerCellXBgCat=[210;210;210;210;210;210];
centerCellYBgCat=[232;232;232;232;232;232];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXCat=[208;208;208;208;208;208];
centerCellYCat=[238;238;238;238;238;238];


format='*.tif';
