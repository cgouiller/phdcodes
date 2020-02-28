%Méthode de background :
%Chemins où récupérer/enregistrer les données.
basePathVid='E:\LMaquet_sauv_DD\Mixing\';
basePathAnalyse='E:\Clément\Mixing\Analyse\';
basePathVidProcessed='E:\Laurent\Mixing\Analyse\';

%Ne traiter qu'une image toutes les 'saut' images
saut=1;

sizeim=1790;
%fps of the videos
fps=20;

%numbre of videos in the set
nombreVid=17;

%date de prise des videos (pour le path)
date='180329\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varNumber_large\';setCatalogue{2}='varNumber_large\';setCatalogue{3}='varNumber_large\';setCatalogue{4}='varNumber_large\';setCatalogue{5}='varNumber_large\';setCatalogue{6}='varNumber_large\';
setCatalogue{7}='varNumber_large\';setCatalogue{8}='varNumber_large\';setCatalogue{9}='varNumber_large\';setCatalogue{10}='varNumber_large\';setCatalogue{11}='varNumber_large\';
setCatalogue{12}='varMass_large\';setCatalogue{13}='varMass_large\';setCatalogue{14}='varMass_large\';
setCatalogue{15}='varMass_large\';setCatalogue{16}='varMass_large\';setCatalogue{17}='varMass_large\';setCatalogue{18}='varMass_large\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='1';videoCatalogue{2}='2';videoCatalogue{3}='3';videoCatalogue{4}='5';videoCatalogue{5}='10';videoCatalogue{6}='15';
videoCatalogue{7}='20';videoCatalogue{8}='30';videoCatalogue{9}='40';videoCatalogue{10}='50';videoCatalogue{11}='60';
videoCatalogue{12}='1';videoCatalogue{13}='2';videoCatalogue{14}='3';
videoCatalogue{15}='4';videoCatalogue{16}='5';videoCatalogue{17}='6';videoCatalogue{18}='7';

%Diameter of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5;5;            5;5;5;5;5;5;5];


%radius of the area of interest in pixel 
radiusCellPx=1789/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);

%Mean concentrations of the mean image
CMoy=[0;0.052;0.0412;0.0497;0.0534;0.0433;0.0499;0.0439;0.0508;0.0509;0.0458];

%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
bubbleFreeCatalogue=[0;440;1057;1410;1254;1025;898;1050;1306;1555;447;          0;0;0;0;0;0];
startImgCatalogue=[1413;671;1334;1866;1482;1226;1187;1270;1548;2051;917; 		1662;3658;2715;1224;1914;1629;1211];

%top left corner of the square in which the free surface of water is
centerCellXCat=[211;181;155;167;102;212;160;132;80;169;140;			227;160;121;166;123;136;177];
centerCellYCat=[201;173;215;210;112;189;125;170;182;138;154;			213;194;176;158;125;124;143];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[211;181;154;167;104;213;162;133;82;162;140;			225;160;120;167;122;136;178];
centerCellYBgCat=[201;177;215;210;113;187;125;171;180;139;153;			211;195;176;158;124;124;149];

%top left corner of the square (X0,Y0) that is outside the free surface of
%water, above the plastic sheet, used to normalise the lightning provided by the LED sheet
% and its size (DX,DY). à prendre sur les images avec nageurs, pas sur le
% bg
% referenceSqX0Cat=[-1;42;60;48;1911;72;27;39;1893;39;30];
% referenceSqY0Cat=[-1;48;54;52;36;66;35;39;51;39;36];
% referenceSqDXCat=[100;100;100;100;100;100;100;100;100;100;100];
% referenceSqDYCat=referenceSqDXCat;


%Ceux ci-dessous sont ceux sur la feuille de plastique
referenceSqX0Cat=[1517;312;12;1736;77;686;22;89;1884;1892;305;			429;567;1222;1508;1356;362;64];
referenceSqY0Cat=[164;306;1151;374;1458;102;775;600;1293;1427;268;		1820;146;60;143;1847;193;1226];
referenceSqDXCat=[117;120;123;115;105;117;108;105;111;107;107;			102;108;108;110;81;110;105];
referenceSqDYCat=referenceSqDXCat;

%Starting time (in s) of the stationnary zone
startCatalogue=[60;156;212;123;232;220;162;145;200;240;340;             200;190;242;290;200;219];
endCatalogue=[150;219;311;306;365;324;241;264;368;500;490;               330;260;306;334;254;308];

%Number of images to be considered in the stationary zone
Nstationary=20;

format='*.tif';
