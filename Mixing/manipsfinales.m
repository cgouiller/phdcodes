run defaultfig;
%numbre of videos in the set
nombreVid=40;

%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='E:\Clément\Mixing\';basePathVidCatalogue{2}='E:\Clément\Mixing\';basePathVidCatalogue{3}='E:\Clément\Mixing\';basePathVidCatalogue{4}='E:\Clément\Mixing\';basePathVidCatalogue{5}='E:\Clément\Mixing\';basePathVidCatalogue{6}='E:\Clément\Mixing\';basePathVidCatalogue{7}='E:\Clément\Mixing\';basePathVidCatalogue{8}='E:\Clément\Mixing\';basePathVidCatalogue{9}='E:\Clément\Mixing\';basePathVidCatalogue{10}='E:\Clément\Mixing\';
basePathVidCatalogue{11}='E:\Clément\Mixing\';basePathVidCatalogue{12}='E:\Clément\Mixing\';basePathVidCatalogue{13}='E:\Clément\Mixing\';basePathVidCatalogue{14}='E:\Clément\Mixing\';basePathVidCatalogue{15}='E:\Clément\Mixing\';basePathVidCatalogue{16}='E:\Clément\Mixing\';basePathVidCatalogue{17}='E:\Clément\Mixing\';basePathVidCatalogue{18}='E:\Clément\Mixing\';basePathVidCatalogue{19}='E:\Clément\Mixing\';basePathVidCatalogue{20}='E:\Clément\Mixing\';
basePathVidCatalogue{21}='E:\ManipeCarbopol\Users\ccottin\Downloads\';basePathVidCatalogue{22}='E:\ManipeCarbopol\Users\ccottin\Downloads\';basePathVidCatalogue{23}='E:\ManipeCarbopol\Users\ccottin\Downloads\';basePathVidCatalogue{24}='E:\ManipeCarbopol\Users\ccottin\Downloads\';basePathVidCatalogue{25}='E:\Clément\Mixing\';basePathVidCatalogue{26}='E:\Clément\Mixing\';basePathVidCatalogue{27}='E:\Clément\Mixing\';basePathVidCatalogue{28}='E:\Clément\Mixing\';basePathVidCatalogue{29}='E:\Clément\Mixing\';basePathVidCatalogue{30}='E:\Clément\Mixing\';
basePathVidCatalogue{31}='E:\Clément\Mixing\';basePathVidCatalogue{32}='E:\Clément\Mixing\';basePathVidCatalogue{33}='E:\Clément\Mixing\';basePathVidCatalogue{34}='E:\Clément\Mixing\';basePathVidCatalogue{35}='E:\Clément\Mixing\';basePathVidCatalogue{36}='E:\Clément\Mixing\';basePathVidCatalogue{37}='E:\Clément\Mixing\';basePathVidCatalogue{38}='E:\Clément\Mixing\';basePathVidCatalogue{39}='E:\Clément\Mixing\';basePathVidCatalogue{40}='E:\Clément\Mixing\';
basePathVidCatalogue{41}='E:\Clément\Mixing\';basePathVidCatalogue{42}='E:\Clément\Mixing\';basePathVidCatalogue{43}='I:\Mixing\';basePathVidCatalogue{44}='I:\Mixing\';basePathVidCatalogue{45}='I:\Mixing\';basePathVidCatalogue{46}='I:\Mixing\';basePathVidCatalogue{47}='I:\Mixing\';basePathVidCatalogue{48}='I:\Mixing\';basePathVidCatalogue{49}='I:\Mixing\';basePathVidCatalogue{50}='I:\Mixing\';
basePathVidCatalogue{51}='I:\Mixing\';basePathVidCatalogue{52}='I:\Mixing\';basePathVidCatalogue{53}='I:\Mixing\';basePathVidCatalogue{54}='I:\Mixing\';basePathVidCatalogue{55}='J:\Mixing\';
basePathAnalyse='E:\Clément\Mixing\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;


%fps of the videos
fps=35;



%date de prise des videos (pour le path)
dateCatalogue=cell(1,nombreVid);
dateCatalogue{1}='190313\';dateCatalogue{2}='190313\';dateCatalogue{3}='190313\';dateCatalogue{4}='190314\';dateCatalogue{5}='190314\';dateCatalogue{6}='190315\';dateCatalogue{7}='190315\';dateCatalogue{8}='190315\';dateCatalogue{9}='190321\';dateCatalogue{10}='190321\';
dateCatalogue{11}='190321\';dateCatalogue{12}='190321\';dateCatalogue{13}='190321\';dateCatalogue{14}='190401\';dateCatalogue{15}='190401\';dateCatalogue{16}='190401\';dateCatalogue{17}='190403\';dateCatalogue{18}='190403\';dateCatalogue{19}='190403\';dateCatalogue{20}='190403\';
dateCatalogue{21}='190404\';dateCatalogue{22}='190404\';dateCatalogue{23}='190404\';dateCatalogue{24}='190404\';dateCatalogue{25}='190405\';dateCatalogue{26}='190405\';dateCatalogue{27}='190405\';dateCatalogue{28}='190411\';dateCatalogue{29}='190411\';dateCatalogue{30}='190411\';
dateCatalogue{31}='190411\';dateCatalogue{32}='190415\';dateCatalogue{33}='190415\';dateCatalogue{34}='190618\';dateCatalogue{35}='190618\';dateCatalogue{36}='190618\';dateCatalogue{37}='190620\';dateCatalogue{38}='190620\';dateCatalogue{39}='190620\';dateCatalogue{40}='190620\';
dateCatalogue{41}='190628\';dateCatalogue{42}='190628\';dateCatalogue{43}='190702\';dateCatalogue{44}='190702\';dateCatalogue{45}='190702\';dateCatalogue{46}='190702\';dateCatalogue{47}='190703\';dateCatalogue{48}='190703\';dateCatalogue{49}='190703\';dateCatalogue{50}='190703\';
dateCatalogue{51}='190704\';dateCatalogue{52}='190704\';dateCatalogue{53}='190704\';dateCatalogue{54}='190704\';dateCatalogue{55}='190902\';
%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varMass\';setCatalogue{2}='varMass\';setCatalogue{3}='varMass\';setCatalogue{4}='varMass\';setCatalogue{5}='varMass\';setCatalogue{6}='varMass\';setCatalogue{7}='varMass\';setCatalogue{8}='varMass\';setCatalogue{9}='varMass\';setCatalogue{10}='varMass\';
setCatalogue{11}='varMass\';setCatalogue{12}='varMass\';setCatalogue{13}='varMass\';setCatalogue{14}='varMass\';setCatalogue{15}='varMass\';setCatalogue{16}='varMass\';setCatalogue{17}='varNumber\';setCatalogue{18}='varNumber\';setCatalogue{19}='varNumber\';setCatalogue{20}='varNumber\';
setCatalogue{21}='varSize\';setCatalogue{22}='varSize\';setCatalogue{23}='varSize\';setCatalogue{24}='varSize\';setCatalogue{25}='commun\';setCatalogue{26}='varNumber\';setCatalogue{27}='varSize\';setCatalogue{28}='';setCatalogue{29}='';setCatalogue{30}='varMass\';
setCatalogue{31}='varMass\';setCatalogue{32}='varSize\';setCatalogue{33}='varSize\';setCatalogue{34}='varSize\';setCatalogue{35}='varSize\';setCatalogue{36}='varSize\';setCatalogue{37}='varSize\';setCatalogue{38}='varSize\';setCatalogue{39}='varSize\';setCatalogue{40}='varSize\';
setCatalogue{41}='varSize\';setCatalogue{42}='varSize\';setCatalogue{43}='varSize\';setCatalogue{44}='varSize\';setCatalogue{45}='varSize\';setCatalogue{46}='varSize\';setCatalogue{47}='varSize\';setCatalogue{48}='varSize\';setCatalogue{49}='varSize\';setCatalogue{50}='varSize\';
setCatalogue{51}='varSize\';setCatalogue{52}='varSize\';setCatalogue{53}='varSize\';setCatalogue{54}='varSize\';setCatalogue{55}='test\';

varM=[1:3,7,8,10:13,15,16,29:31];
%varM=[29,31,30,3,5,15,11,2,8,16,12,25,10,13,7];  %[1:21,23,25:27]; ajouter 25
varMpiv=[3,15,11,16,10,7];
varRold=[23,33,21,25,24,32,27];   %[16,21,23,24,27];
varNold=[17,20,25,18,19,26];  %[16,17:20,26];
varR=[37,42,54,39,44,53,34,47,48,40,45,49,35,43,51,38,46,52,36,41,50];

%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='Exp1\';videoCatalogue{2}='Exp2\';videoCatalogue{3}='Exp3\';videoCatalogue{4}='Exp4\';videoCatalogue{5}='Exp5\';videoCatalogue{6}='Exp6\';videoCatalogue{7}='Exp7\';videoCatalogue{8}='Exp8\';videoCatalogue{9}='Exp9\';videoCatalogue{10}='Exp10\';
videoCatalogue{11}='Exp11\';videoCatalogue{12}='Exp12\';videoCatalogue{13}='Exp13\';videoCatalogue{14}='Exp14\';videoCatalogue{15}='Exp15\';videoCatalogue{16}='Exp16\';videoCatalogue{17}='7\';videoCatalogue{18}='20\';videoCatalogue{19}='30\';videoCatalogue{20}='11\';
videoCatalogue{21}='4\';videoCatalogue{22}='8\';videoCatalogue{23}='2\';videoCatalogue{24}='6\';videoCatalogue{25}='15\';videoCatalogue{26}='45\';videoCatalogue{27}='8_2\';videoCatalogue{28}='blank\';videoCatalogue{29}='swimmers_alone\';videoCatalogue{30}='Exp30\';
videoCatalogue{31}='Exp31\';videoCatalogue{32}='7\';videoCatalogue{33}='3\';videoCatalogue{34}='4\';videoCatalogue{35}='6\';videoCatalogue{36}='8\';videoCatalogue{37}='2\';videoCatalogue{38}='7\';videoCatalogue{39}='3\';videoCatalogue{40}='5\';
videoCatalogue{41}='8_2\';videoCatalogue{42}='2_2\';videoCatalogue{43}='6_2\';videoCatalogue{44}='3_2\';videoCatalogue{45}='5_2\';videoCatalogue{46}='7_2\';videoCatalogue{47}='4_2\';videoCatalogue{48}='4_3\';videoCatalogue{49}='5_3\';videoCatalogue{50}='8_3\';
videoCatalogue{51}='6_3\';videoCatalogue{52}='7_3\';videoCatalogue{53}='3_3\';videoCatalogue{54}='2_3\';videoCatalogue{55}='8mg\';
% Mass of glass bubbles in the crystallizer (mg)
MCat=[82.34;36.62;11.37;41.66;18.73;58.62;71.22;38.57;22.45;54.85;
    32.04;44.65;65.96;37.33;21.77;39.61;40.43;42.57;40.68;40.77;
    40.75;41.18;41.32;NaN;47.07;40.19;41.95;0;0;7.69;
    2.45;40.83;41.96;8.04;7.80;7.83;7.89;8.08;7.89;8.01;
    8.06;8.10;7.72;7.66;8.24;7.56;7.49;7.51;7.28;7.57;
    7.74;7.71;8.31;8.35;6.99];

NCat=[15;15;15;15;15;15;15;15;15;15;
    15;15;15;15;15;15;7;20;30;11;
    15;15;15;15;15;45;15;0;15;15;
    15;15;15;15;15;15;15;15;15;15;
    15;15;15;15;15;15;15;15;15;15;
    15;15;15;15;0];
%Radii of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5;
    5;5;5;5;5;5;5;5;5;5;
    4;8;2;6;5;5;8;NaN;5;5;
    5;7;3;4;6;8;2;7;3;5;
    8;2;6;3;5;7;4;4;5;8;
    6;7;3;2;NaN]/2;


%radius of the area of interest in pixel 
radiusCellPxCat=1854/2*ones(1,33);
radiusCellPxCat(34)=1894/2;radiusCellPxCat(35)=1894/2;radiusCellPxCat(36)=1894/2;radiusCellPxCat(37)=1894/2;radiusCellPxCat(38)=1894/2;radiusCellPxCat(39)=1894/2;radiusCellPxCat(40)=1894/2;
radiusCellPxCat(41)=1970/2;radiusCellPxCat(42)=1970/2;radiusCellPxCat(43)=1970/2;radiusCellPxCat(44)=1970/2;radiusCellPxCat(45)=1970/2;radiusCellPxCat(46)=1970/2;radiusCellPxCat(47)=1970/2;radiusCellPxCat(48)=1970/2;radiusCellPxCat(49)=1970/2;radiusCellPxCat(50)=1970/2;
radiusCellPxCat(51)=1970/2;radiusCellPxCat(52)=1970/2;radiusCellPxCat(53)=1970/2;radiusCellPxCat(54)=1970/2;radiusCellPxCat(55)=1970/2;


%calibration in mm/px
calibCat=180./(2*radiusCellPxCat);



%top left corner of the square in which the free surface of water is
centerCellXBgCat=[64;87;91;82;85;91;94;88;80;76;
    80;73;83;65;78;77;94;84;89;83;
    84;NaN;82;61;86;55;88;87;88;58;
    75;66;76;51;67;78;58;74;63;68;
    32;32;40;34;36;24;33;33;34;36;
    33;37;30;24;34];
centerCellYBgCat=[102;84;92;111;86;99;96;77;99;96;
    98;99;103;86;114;112;127;108;108;97;
    139;NaN;114;111;107;109;104;83;86;88;
    84;105;125;36;109;81;90;66;76;72;
    39;42;37;41;34;46;34;45;42;54;
    45;56;38;50;35];
%top left corner of the square in which the free surface of water is (in
%the solo images)
centerCellXSoloCat=[NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN
    NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN
    NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN
    NaN;NaN;NaN;50;67;77;60;74;63;68;
    31;32;40;34;37;25;33;34;34;35;
    33;38;30;24;NaN];
centerCellYSoloCat=[NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN
    NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN
    NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN
    NaN;NaN;NaN;37;103;77;90;66;75;71;
    40;41;36;40;36;45;36;41;38;55;
    44;53;34;49;NaN];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXCat=[65;88;91;80;86;91;90;91;75;74;
    75;75;81;64;77;78;94;83;88;81;
    85;NaN;81;61;84;53;89;87;88;60;
    76;67;77;51;68;78;59;74;63;69;
    31;31;41;34;36;25;34;32;34;34;
    33;37;29;23;34];
centerCellYCat=[102;84;91;111;86;99;97;77;102;98;
    104;95;101;85;113;112;125;108;110;97;
    140;NaN;115;111;107;108;104;85;85;90;
    84;105;126;29;108;83;90;65;76;71;
    39;38;35;40;34;44;32;46;42;56;
    44;53;35;46;35];

%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[7;5;5;5;8;7;6;7;6;8;
    13;7;8;7;6;7;7;11;8;7;
    7;NaN;8;7;9;9;10;1;1;6;
    10;8;9;1;1;1;1;1;1;1;
    1;1;1;1;1;1;1;1;1;1
    1;1;1;1;1];

format='*.tif';
