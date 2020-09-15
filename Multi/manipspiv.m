run defaultfig;
%numbre of videos in the set
nombreVid=7;

%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='E:\Clément\Multi\';basePathVidCatalogue{2}='E:\Clément\Multi\';basePathVidCatalogue{3}='E:\Clément\Multi\';basePathVidCatalogue{4}='E:\Clément\Multi\';basePathVidCatalogue{5}='E:\Clément\Multi\';basePathVidCatalogue{6}='E:\Clément\Multi\';basePathVidCatalogue{7}='E:\Clément\Multi\';%basePathVidCatalogue{8}='E:\Clément\Multi\';basePathVidCatalogue{9}='E:\Clément\Multi\';basePathVidCatalogue{10}='E:\Clément\Multi\';
%basePathVidCatalogue{11}='E:\Clément\Multi\';basePathVidCatalogue{12}='E:\Clément\Multi\';basePathVidCatalogue{13}='E:\Clément\Multi\';basePathVidCatalogue{14}='E:\Clément\Multi\';basePathVidCatalogue{15}='E:\Clément\Multi\';basePathVidCatalogue{16}='E:\Clément\Multi\';basePathVidCatalogue{17}='E:\Clément\Multi\';basePathVidCatalogue{18}='E:\Clément\Multi\';basePathVidCatalogue{19}='E:\Clément\Multi\';basePathVidCatalogue{20}='E:\Clément\Multi\';
%basePathVidCatalogue{21}='E:\Clément\Multi\';basePathVidCatalogue{22}='E:\Clément\Multi\';basePathVidCatalogue{23}='E:\Clément\Multi\';basePathVidCatalogue{24}='E:\Clément\Multi\';basePathVidCatalogue{25}='E:\Clément\Multi\';basePathVidCatalogue{26}='E:\Clément\Multi\';basePathVidCatalogue{27}='E:\Clément\Multi\';basePathVidCatalogue{28}='E:\Clément\Multi\';basePathVidCatalogue{29}='E:\Clément\Multi\';basePathVidCatalogue{30}='E:\Clément\Multi\';
%basePathVidCatalogue{31}='E:\Clément\Multi\';basePathVidCatalogue{32}='E:\Clément\Multi\';basePathVidCatalogue{33}='E:\Clément\Multi\';basePathVidCatalogue{34}='E:\Clément\Multi\';basePathVidCatalogue{35}='E:\Clément\Multi\';basePathVidCatalogue{36}='E:\Clément\Multi\';basePathVidCatalogue{37}='E:\Clément\Multi\';basePathVidCatalogue{38}='E:\Clément\Multi\';basePathVidCatalogue{39}='E:\Clément\Multi\';basePathVidCatalogue{40}='E:\Clément\Multi\';
%basePathVidCatalogue{41}='E:\Clément\Multi\';basePathVidCatalogue{42}='E:\Clément\Multi\';basePathVidCatalogue{43}='E:\Clément\Multi\';basePathVidCatalogue{44}='E:\Clément\Multi\';basePathVidCatalogue{45}='E:\Clément\Multi\';basePathVidCatalogue{46}='E:\Clément\Multi\';basePathVidCatalogue{47}='E:\Clément\Multi\';basePathVidCatalogue{48}='E:\Clément\Multi\';basePathVidCatalogue{49}='E:\Clément\Multi\';basePathVidCatalogue{50}='E:\Clément\Multi\';
%basePathVidCatalogue{51}='E:\Clément\Multi\';basePathVidCatalogue{52}='E:\Clément\Multi\';
basePathAnalyse='E:\Clément\Multi\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;


%fps of the videos
fps=30;



%date de prise des videos (pour le path)
dateCatalogue=cell(1,nombreVid);
dateCatalogue{1}='200728\';dateCatalogue{2}='200728\';dateCatalogue{3}='200728\';dateCatalogue{4}='200915\';dateCatalogue{5}='200915\';dateCatalogue{6}='200915\';dateCatalogue{7}='200915\';%dateCatalogue{8}='200603\';dateCatalogue{9}='200603\';dateCatalogue{10}='200603\';
% dateCatalogue{11}='200603\';dateCatalogue{12}='200603\';dateCatalogue{13}='200603\';dateCatalogue{14}='200603\';dateCatalogue{15}='200603\';dateCatalogue{16}='200603\';dateCatalogue{17}='200603\';dateCatalogue{18}='200603\';dateCatalogue{19}='200603\';dateCatalogue{20}='200603\';
% dateCatalogue{21}='200608\';dateCatalogue{22}='200608\';dateCatalogue{23}='200608\';dateCatalogue{24}='200608\';dateCatalogue{25}='200608\';dateCatalogue{26}='200608\';dateCatalogue{27}='200608\';dateCatalogue{28}='200608\';dateCatalogue{29}='200608\';dateCatalogue{30}='200608\';
% dateCatalogue{31}='200608\';dateCatalogue{32}='200608\';dateCatalogue{33}='200608\';dateCatalogue{34}='200608\';dateCatalogue{35}='200608\';dateCatalogue{36}='200608\';dateCatalogue{37}='200617\';dateCatalogue{38}='200617\';dateCatalogue{39}='200617\';dateCatalogue{40}='200617\';
% dateCatalogue{41}='200617\';dateCatalogue{42}='200617\';dateCatalogue{43}='200617\';dateCatalogue{44}='200617\';dateCatalogue{45}='200617\';dateCatalogue{46}='200617\';dateCatalogue{47}='200617\';dateCatalogue{48}='200617\';dateCatalogue{49}='200617\';dateCatalogue{50}='200617\';
% dateCatalogue{51}='200617\';dateCatalogue{52}='200617\';

%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='fin_avec_mur\';setCatalogue{2}='fin_sans_mur\';setCatalogue{3}='large_sans_mur\';setCatalogue{4}='geom\';setCatalogue{5}='essai1\';setCatalogue{6}='essai2\';setCatalogue{7}='essai3\';%setCatalogue{8}='actif\';setCatalogue{9}='actif\';setCatalogue{10}='actif\';
% setCatalogue{11}='passif\';setCatalogue{12}='passif\';setCatalogue{13}='passif\';setCatalogue{14}='passif\';setCatalogue{15}='passif\';setCatalogue{16}='passif\';setCatalogue{17}='passif\';setCatalogue{18}='passif\';setCatalogue{19}='passif\';setCatalogue{20}='passif\';
% setCatalogue{21}='varSize\actif\2\';setCatalogue{22}='varSize\actif\2\';setCatalogue{23}='varSize\actif\2\';setCatalogue{24}='varSize\actif\2\';setCatalogue{25}='varSize\actif\8\';setCatalogue{26}='varSize\actif\8\';setCatalogue{27}='varSize\actif\8\';setCatalogue{28}='varSize\actif\8\';setCatalogue{29}='varSize\passif\2\';setCatalogue{30}='varSize\passif\2\';
% setCatalogue{31}='varSize\passif\2\';setCatalogue{32}='varSize\passif\2\';setCatalogue{33}='varSize\passif\8\';setCatalogue{34}='varSize\passif\8\';setCatalogue{35}='varSize\passif\8\';setCatalogue{36}='varSize\passif\8\';setCatalogue{37}='varSize\passif\2\';setCatalogue{38}='varSize\passif\5\';setCatalogue{39}='varSize\passif\8\';setCatalogue{40}='varSize\actif\2\';
% setCatalogue{41}='varSize\actif\5\';setCatalogue{42}='varSize\actif\8\';setCatalogue{43}='varSize\passif\16\';setCatalogue{44}='varSize\passif\16\';setCatalogue{45}='varSize\passif\16\';setCatalogue{46}='varSize\passif\16\';setCatalogue{47}='varSize\passif\16\';setCatalogue{48}='varSize\actif\16\';setCatalogue{49}='varSize\actif\16\';setCatalogue{50}='varSize\actif\16\';
% setCatalogue{51}='varSize\actif\16\';setCatalogue{52}='varSize\actif\16\';

%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='';videoCatalogue{2}='';videoCatalogue{3}='';videoCatalogue{4}='';videoCatalogue{5}='';videoCatalogue{6}='';videoCatalogue{7}='';%videoCatalogue{8}='360\';videoCatalogue{9}='450\';videoCatalogue{10}='600\';
% videoCatalogue{11}='60\';videoCatalogue{12}='90\';videoCatalogue{13}='120\';videoCatalogue{14}='150\';videoCatalogue{15}='180\';videoCatalogue{16}='240\';videoCatalogue{17}='300\';videoCatalogue{18}='360\';videoCatalogue{19}='450\';videoCatalogue{20}='600\';
% videoCatalogue{21}='90\';videoCatalogue{22}='150\';videoCatalogue{23}='300\';videoCatalogue{24}='600\';videoCatalogue{25}='60\';videoCatalogue{26}='150\';videoCatalogue{27}='300\';videoCatalogue{28}='600\';videoCatalogue{29}='90\';videoCatalogue{30}='150\';
% videoCatalogue{31}='300\';videoCatalogue{32}='600\';videoCatalogue{33}='90\';videoCatalogue{34}='150\';videoCatalogue{35}='300\';videoCatalogue{36}='600\';videoCatalogue{37}='0\';videoCatalogue{38}='0\';videoCatalogue{39}='0\';videoCatalogue{40}='0\';
% videoCatalogue{41}='0\';videoCatalogue{42}='0\';videoCatalogue{43}='0\';videoCatalogue{44}='90\';videoCatalogue{45}='150\';videoCatalogue{46}='300\';videoCatalogue{47}='600\';videoCatalogue{48}='0\';videoCatalogue{49}='90\';videoCatalogue{50}='150\';
% videoCatalogue{51}='300\';videoCatalogue{52}='600\';

NCat=[0;0;0;0;0;0;0];
%Radii of the camphor swimmers
RCat=[NaN;NaN;NaN;NaN;NaN;NaN;NaN]/2;
Rdetect=[NaN;NaN;NaN;NaN;NaN;NaN;NaN]/2;
    

startImgCatalogue=[360;370;483;1;1;1;1];
hgxcat=[257;370;112;65;308;307;305]; % Coord x du coin en haut à gauche
hgycat=[309;251;120;401;245;239;239]; % Coord y du coin en haut à gauche
hdxcat=[1711;1840;1954;1587;1866;1865;1863]; % x haut droite
hdycat=[298;277;120;54;266;260;259]; % y haut droite
bdxcat=[1733;1822;1962;1937;1851;1850;1848]; % x bas gauche
bdycat=[1759;1740;1949;1573;1825;1819;1817]; % y bas gauche
bgxcat=[248;350;118;423;295;294;292]; % x bas droit
bgycat=[1777;1722;1962;1929;1815;1808;1807]; % y bas droit
% hgxcat=[258;368;113]; % Coord x du coin en haut à gauche
% hgycat=[309;253;120]; % Coord y du coin en haut à gauche
% hdxcat=[1710;1836;1953]; % x haut droite
% hdycat=[298;279;121]; % y haut droite
% bdxcat=[1734;1817;1960]; % x bas gauche
% bdycat=[1761;1741;1950]; % y bas gauche
% bgxcat=[254;349;118]; % x bas droit
% bgycat=[1778;1724;1958]; % y bas droit

centerXCat=round((hgxcat+hdxcat+bgxcat+bdxcat)/4);
centerYCat=round((hgycat+hdycat+bgycat+bdycat)/4);

coteCarre=mean([sqrt((hgxcat-hdxcat).^2+(hgycat-hdycat).^2),sqrt((hdxcat-bdxcat).^2+(hdycat-bdycat).^2),sqrt((bdxcat-bgxcat).^2+(bdycat-bgycat).^2),sqrt((bgxcat-hgxcat).^2+(bgycat-hgycat).^2)]'); %#ok<UDIM> % On fait le moyenne des 4 longueurs du carré pour chaque manip
trueCarre=[96.4,96.4,120.5,96.4,96.4,96.4,96.4];

calibCat=trueCarre./coteCarre;
format='*.tif';
