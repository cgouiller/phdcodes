%Méthode de background :
%Chemins où récupérer/enregistrer les données.
basePathVid='I:\Mixing\';
basePathAnalyse='E:\Clément\Mixing\Analyse\';

%Ne traiter qu'une image toutes les 'saut' images
saut=1;

sizeim=1558;

%fps of the videos
fps=20;

%numbre of videos in the set
nombreVid=6;

%date de prise des videos (pour le path)
date='180622\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varNumber_large\';setCatalogue{2}='varNumber_large\';setCatalogue{3}='varNumber_large\';setCatalogue{4}='varNumber_large\';setCatalogue{5}='bubble_glass_alone\';setCatalogue{6}='bubble_glass_swimmer\';


videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='10';videoCatalogue{2}='10_2';videoCatalogue{3}='10_3';videoCatalogue{4}='10_4';videoCatalogue{5}='0';videoCatalogue{6}='0';


%Diameter of the camphor swimmers
RCat=[5;5;5;5;0;5];


%radius of the area of interest in pixel 
radiusCellPx=1558/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);

%top left corner of the square in which the free surface of water is
centerCellXCat=[297;354;208;298;225;321];
centerCellYCat=[257;294;226;205;274;224];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[300;354;209;297;225;320];
centerCellYBgCat=[258;294;224;206;275;224];

%Image de début de l'étude
startImgCatalogue=[0;0;0;0;265;245];

%Début de la zone stationnaire (en s)
startCatalogue=[0;0;0;0;NaN;NaN];

%Number of images to be considered in the stationary zone
Nstationary=100;


format='*.tif';
