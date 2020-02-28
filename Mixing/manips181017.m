%Méthode de background :
%Chemins où récupérer/enregistrer les données.
basePathVid='I:\Mixing\';
basePathAnalyse='E:\Clément\Mixing\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;

sizeim=1888;
%fps of the videos
fps=20;

%numbre of videos in the set
nombreVid=20;

%date de prise des videos (pour le path)
date='181017\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='bubble_alone\6_conc\';setCatalogue{2}='bubble_alone\6_conc\';setCatalogue{3}='bubble_alone\6_conc\';setCatalogue{4}='bubble_alone\6_conc_sep\';setCatalogue{5}='bubble_alone\6_disp\';setCatalogue{6}='bubble_alone\6_disp\';setCatalogue{7}='bubble_alone\6_disp\';setCatalogue{8}='bubble_alone\6_disp\';setCatalogue{9}='bubble_alone\6_disp_sep\';setCatalogue{10}='varMass_large\1bis\';setCatalogue{11}='varSize\2\';setCatalogue{12}='varSize\2\';setCatalogue{13}='varSize\4\';setCatalogue{14}='varSize\4\';setCatalogue{15}='varSize\5\';setCatalogue{16}='varSize\5\';setCatalogue{17}='varSize\6\';setCatalogue{18}='varSize\6\';setCatalogue{19}='varSize\8\';setCatalogue{20}='varSize\8\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='0';videoCatalogue{2}='15';videoCatalogue{3}='30';videoCatalogue{4}='31';videoCatalogue{5}='0';videoCatalogue{6}='15';videoCatalogue{7}='30';videoCatalogue{8}='45';videoCatalogue{9}='46';videoCatalogue{10}='0';videoCatalogue{11}='9';videoCatalogue{12}='20';videoCatalogue{13}='9';videoCatalogue{14}='20';videoCatalogue{15}='9';videoCatalogue{16}='20';videoCatalogue{17}='9';videoCatalogue{18}='20';videoCatalogue{19}='9';videoCatalogue{20}='20';

%Diameter of the camphor swimmers
RCat=[0;0;0;0;0;0;0;0;0;5;2;2;4;4;5;5;6;6;8;8];


%radius of the area of interest in pixel 
radiusCellPx=1887/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);

%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[483;0;0;0;462;0;0;0;0;2025;0;0;0;0;0;0;0;0;0;0];

%top left corner of the square in which the free surface of water is
centerCellXCat=[76;76;76;76;99;99;99;99;99;103;72;72;59;59;68;68;68;68;75;75];
centerCellYCat=[120;120;120;120;51;51;51;51;51;57;91;91;88;88;54;54;81;81;92;92];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[74;74;74;74;98;98;98;98;98;102;73;73;59;59;68;68;67;67;75;75];
centerCellYBgCat=[119;119;119;119;50;50;50;50;50;56;92;92;87;87;54;54;81;81;94;94];

startCatalogue=[NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;0;0;0;0;0;0;0;0;0;0;];
format='*.tif';
