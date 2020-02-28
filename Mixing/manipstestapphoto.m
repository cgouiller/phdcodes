
%Chemins où récupérer/enregistrer les données.
basePathVid='E:\Laurent\Mixing\Analyse\';
basePathAnalyse='E:\Laurent\Mixing\Analyse\';
basePathVidProcessed='E:\Laurent\Mixing\Analyse\';

format='*.JPG';
%Ne traiter qu'une image toutes les 'saut' images
saut=1;

%fps of the videos
fps=1;

%numbre of videos in the set
nombreVid=5;

%date de prise des videos (pour le path)
date='180419\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='tests\';setCatalogue{2}='tests\';setCatalogue{3}='tests\';setCatalogue{4}='tests\';setCatalogue{5}='tests\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='1';videoCatalogue{2}='2';videoCatalogue{3}='3';videoCatalogue{4}='4';videoCatalogue{5}='5';

%Diameter of the camphor swimmers
RCat=[5;5;5;5;5];


%radius of the area of interest in pixel 
radiusCellPx=3113/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);


%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[0;0;0;0;0];

%top left corner of the square in which the free surface of water is
centerCellXCat=[1668;1663;1665;1665;1664];
centerCellYCat=[407;419;420;416;420];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[1470;1476;1476;1476;1476];
centerCellYBgCat=[593;544;544;544;544];

%top left corner of the square (X0,Y0) that is outside the free surface of
%water, above the plastic sheet, used to normalise the lightning provided by the LED sheet
% and its size (DX,DY)
referenceSqX0Cat=[2040;2005;2014;2104;2122];
referenceSqY0Cat=[552;552;561;468;474];
referenceSqDXCat=[179;188;191;191;182];
referenceSqDYCat=referenceSqDXCat;

%Starting time (in s) of the stationnary zone
startCatalogue=[0;0;0;0;0];
endCatalogue=[8;8;8;8;8];

%Number of images to be considered in the stationary zone
Nstationary=9;
