
%Chemins où récupérer/enregistrer les données.
basePathVid='I:\Boulot\Mixing\';
basePathAnalyse='E:\Laurent\Mixing\Analyse\';
basePathVidProcessed='E:\Laurent\Mixing\Analyse\';

%Ne traiter qu'une image toutes les 'saut' images
saut=1;

%fps of the videos
fps=1/20;

%numbre of videos in the set
nombreVid=1;

%date de prise des videos (pour le path)
date='180518\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varNumber_large\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='10_vrai';

%Diameter of the camphor swimmers
RCat=[5];


%radius of the area of interest in pixel 
radiusCellPx=3090/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);


%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[25];

%top left corner of the square in which the free surface of water is
centerCellXCat=[1532];
centerCellYCat=[573];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[1533];
centerCellYBgCat=[571];
%top left corner of the square (X0,Y0) that is outside the free surface of
%water, above the plastic sheet, used to normalise the lightning provided by the LED sheet
% and its size (DX,DY). à prendre sur les images avec nageurs, pas sur le
% bg
% referenceSqX0Cat=[-1;42;60;48;1911;72;27;39;1893;39;30];
% referenceSqY0Cat=[-1;48;54;52;36;66;35;39;51;39;36];
% referenceSqDXCat=[100;100;100;100;100;100;100;100;100;100;100];
% referenceSqDYCat=referenceSqDXCat;


%Ceux ci-dessous sont ceux sur la feuille de plastique
% referenceSqX0Cat=[1517;312;12;1736;77;686;22;89;1884;1892;305;			429;567;1222;1508;1356;362;64];
% referenceSqY0Cat=[164;306;1151;374;1458;102;775;600;1293;1427;268;		1820;146;60;143;1847;193;1226];
% referenceSqDXCat=[117;120;123;115;105;117;108;105;111;107;107;			102;108;108;110;81;110;105];
% referenceSqDYCat=referenceSqDXCat;

%Starting time (in s) of the stationnary zone with respect to the
%startImgCatalogue
startCatalogue=[25*20];
endCatalogue=[44*20];

%Number of images to be considered in the stationary zone
Nstationary=20;

format='*.tif';
