
%fps of the videos
fps=20;

%numbre of videos in the set
nombreVid=24;

%date de prise des videos (pour le path)
date='180307\';

%on traite une toutes les 'saut' images
saut=10;

%chemin où récupérer\enregistrer les données
basePathVid='H:\Mixing\';
basePathAnalyse='E:\Laurent\Mixing\Analyse\';
basePathVidProcessed='E:\Laurent\Mixing\Analyse\';
%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varNumber_5mm_compl180307\';setCatalogue{2}='varNumber_5mm_compl180307\';setCatalogue{3}='varNumber_5mm_compl180307\';setCatalogue{4}='varNumber_5mm_compl180307\';setCatalogue{5}='varNumber_5mm_compl180307\';setCatalogue{6}='varNumber_5mm_compl180307\';setCatalogue{7}='varNumber_5mm_compl180307\';
setCatalogue{8}='varNumber_8mm\';setCatalogue{9}='varNumber_8mm\';setCatalogue{10}='varNumber_8mm\';setCatalogue{11}='varNumber_8mm\';
setCatalogue{12}='increaseNumberStationnary\';setCatalogue{13}='increaseNumberStationnary\';setCatalogue{14}='increaseNumberStationnary\';setCatalogue{15}='increaseNumberStationnary\';setCatalogue{16}='increaseNumberStationnary\';setCatalogue{17}='increaseNumberStationnary\';setCatalogue{18}='increaseNumberStationnary\';setCatalogue{19}='increaseNumberStationnary\';
setCatalogue{20}='varNumber_5mm_large\';setCatalogue{21}='varNumber_5mm_large\';setCatalogue{22}='varNumber_5mm_large\';setCatalogue{23}='varNumber_5mm_large\';setCatalogue{24}='varNumber_5mm_large\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='0';videoCatalogue{2}='1';videoCatalogue{3}='1b';videoCatalogue{4}='2';videoCatalogue{5}='3';videoCatalogue{6}='40';videoCatalogue{7}='40b';
videoCatalogue{8}='1';videoCatalogue{9}='5';videoCatalogue{10}='10';videoCatalogue{11}='20';
videoCatalogue{12}='1';videoCatalogue{13}='2';videoCatalogue{14}='3';videoCatalogue{15}='5';videoCatalogue{16}='10';videoCatalogue{17}='15';videoCatalogue{18}='32';videoCatalogue{19}='40';
videoCatalogue{20}='5_2';videoCatalogue{21}='10_2';videoCatalogue{22}='15';videoCatalogue{23}='15_2';videoCatalogue{24}='15_3';

%Diameter of the camphor swimmers
RCat=[5;5;5;5;5;5;5     ;   8;8;8;8     ;   5;5;5;5;5;5;5;5     ;   5;5;5;5;5];


%radius of the area of interest in pixel 
radiusCellPx=934/2;

%calibration in mm/px
calib=140./(2*radiusCellPx);


%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[152;379;268;1246;286;352;1     ;         563;1776;1087;1173  ;   1;1;1;1;1;1;1;1         ;   271;733;1607;1025;1135];

%top left corner of the square in which the free surface of water is
centerCellXCat=[60;62;38;59;63;90;71                  ;     70;46;56;32     ;   51;51;51;51;51;51;51;51     ;   44;35;21;31;34];
centerCellYCat=[36;33;78;40;54;0;36                  ;      63;35;42;36     ;   42;42;42;42;42;42;42;42     ;   38;35;51;34;42];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[59;62;38;60;68;40;64                ;     67;43;56;56     ;   56;56;56;56;56;56;56;56     ;   43;36;21;30;34];
centerCellYBgCat=[36;34;79;39;40;57;53                ;     66;36;42;42     ;   42;42;42;42;42;42;42;42     ;   38;33;51;34;42];

%top left corner of the square (X0,Y0) that is outside the free surface of
%water, above the plastic sheet, used to normalise the lightning provided by the LED sheet
% and its size (DX,DY)
referenceSqX0Cat=[59;46;60;73;63;30;24                ;     62;46;60;34     ;       857;857;857;857;857;857;857;857     ;   146;106;94;116;171];
referenceSqY0Cat=[41;52;52;65;53;90;141               ;     58;41;46;36     ;       24;24;24;24;24;24;24;24             ;   72;102;118;80;53];
referenceSqDXCat=[112;112;114;104;114;100           ;       112;114;110;114 ;       122;122;122;122;122;122;122;122     ;   64;64;64;64;64];
referenceSqDYCat=[112;112;114;104;114;100           ;       112;114;110;114 ;       122;122;122;122;122;122;122;122     ;   64;64;64;64;64];

%Starting time (in s) of the stationnary zone
startCatalogue=[15;175;100;75;90;400;1  ; 	50;85;90;75	;	4;40;50;50;50;25;25;15		; 150;200;170;170;150	];
endCatalogue=[80;225;160;175;120;450;69   ; 	77;119;140;150	;	24;90;80;82;86;95;79;87		; 290;290;214;270;225	];

CMoyCat=[0.0680085;0.0669956;0.0658302;0.0588978;0.0785814;0.0371982;   0.0648702;0.0693311;0.0558417;0.056045;0.0539864;   0.0742461;0.0694329;0.0686476;0.065085;0.0641157;0.0626103;0.060985;0.0605575;  0.0278346;0.0308033;0.0457393;0.0306065;0.0186918];
C2MoyCat=[0.00557259;0.0106458;0.00831669;0.00834014;0.0137696;0.00792105;  0.00995478;0.0136617;0.00947808;0.00863478;0.00947808;  0.0116636;0.011264;0.0116413;0.012456;0.0130336;0.0112897;0.0110902;0.0113032;  0.00456232;0.00511607;0.00557262;0.00583116;0.00209936];
