run defaultfig;
%numbre of videos in the set
nombreVid=2;

%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='I:\';basePathVidCatalogue{2}='I:\';
basePathAnalyse='E:\Clément\Mixing\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;

sizeim=1976;
%fps of the videos
fps=35;



%date de prise des videos (pour le path)
dateCatalogue=cell(1,nombreVid);
dateCatalogue{1}='190606\';dateCatalogue{2}='190606\';


%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='';setCatalogue{2}='';


%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='test_ombre_avecscotch\';videoCatalogue{2}='test_ombre_sansscotch\';

% Mass of glass bubbles in the crystallizer (mg)
MCat=[0;0];

NCat=[10;10];
%Radii of the camphor swimmers
RCat=[6;6]/2;


%radius of the area of interest in pixel 
radiusCellPx=sizeim/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);

%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[1;1];

%top left corner of the square in which the free surface of water is
centerCellXBgCat=[26;32];
centerCellYBgCat=[37;22];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXCat=[26;30];
centerCellYCat=[37;24];



format='*.tif';
