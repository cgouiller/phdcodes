run defaultfig;
%numbre of videos in the set
nombreVid=21;

%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='E:\Clément\Multi\';basePathVidCatalogue{2}='E:\Clément\Multi\';basePathVidCatalogue{3}='E:\Clément\Multi\';basePathVidCatalogue{4}='E:\Clément\Multi\';basePathVidCatalogue{5}='E:\Clément\Multi\';basePathVidCatalogue{6}='E:\Clément\Multi\';basePathVidCatalogue{7}='E:\Clément\Multi\';basePathVidCatalogue{8}='E:\Clément\Multi\';basePathVidCatalogue{9}='E:\Clément\Multi\';basePathVidCatalogue{10}='Y:\cgouiller\Multi\';
basePathVidCatalogue{11}='Y:\cgouiller\Multi\';basePathVidCatalogue{12}='Y:\cgouiller\Multi\';basePathVidCatalogue{13}='Y:\cgouiller\Multi\';basePathVidCatalogue{14}='Y:\cgouiller\Multi\';basePathVidCatalogue{15}='Y:\cgouiller\Multi\';basePathVidCatalogue{16}='Y:\cgouiller\Multi\';basePathVidCatalogue{17}='Y:\cgouiller\Multi\';basePathVidCatalogue{18}='Y:\cgouiller\Multi\';basePathVidCatalogue{19}='Y:\cgouiller\Multi\';basePathVidCatalogue{20}='Y:\cgouiller\Multi\';
basePathVidCatalogue{21}='Y:\cgouiller\Multi\';%basePathVidCatalogue{22}='E:\Clément\Multi\';basePathVidCatalogue{23}='E:\Clément\Multi\';basePathVidCatalogue{24}='E:\Clément\Multi\';basePathVidCatalogue{25}='E:\Clément\Multi\';basePathVidCatalogue{26}='E:\Clément\Multi\';basePathVidCatalogue{27}='E:\Clément\Multi\';basePathVidCatalogue{28}='E:\Clément\Multi\';basePathVidCatalogue{29}='E:\Clément\Multi\';basePathVidCatalogue{30}='E:\Clément\Multi\';
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
dateCatalogue{1}='200728\';dateCatalogue{2}='200728\';dateCatalogue{3}='200728\';dateCatalogue{4}='200915\';dateCatalogue{5}='200915\';dateCatalogue{6}='200915\';dateCatalogue{7}='200915\';dateCatalogue{8}='200917\';dateCatalogue{9}='200917\';dateCatalogue{10}='210331\';
 dateCatalogue{11}='210331\';dateCatalogue{12}='210331\';dateCatalogue{13}='210331\';dateCatalogue{14}='210331\';dateCatalogue{15}='210331\';dateCatalogue{16}='210331\';dateCatalogue{17}='210331\';dateCatalogue{18}='210331\';dateCatalogue{19}='210331\';dateCatalogue{20}='210331\';
 dateCatalogue{21}='210331\';

%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='fin_avec_mur\';setCatalogue{2}='fin_sans_mur\';setCatalogue{3}='large_sans_mur\';setCatalogue{4}='geom\';setCatalogue{5}='essai1\';setCatalogue{6}='essai2\';setCatalogue{7}='essai3\';setCatalogue{8}='piv\';setCatalogue{9}='piv\';setCatalogue{10}='varSpeed\';
 setCatalogue{11}='varSpeed\';setCatalogue{12}='varSpeed\';setCatalogue{13}='varSpeed\';setCatalogue{14}='varSpeed\';setCatalogue{15}='varSpeed\';setCatalogue{16}='varSpeed\';setCatalogue{17}='varSpeed\';setCatalogue{18}='varSpeed\';setCatalogue{19}='varSpeed\';setCatalogue{20}='varSpeed\';
 setCatalogue{21}='varSpeed\';

%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='';videoCatalogue{2}='';videoCatalogue{3}='';videoCatalogue{4}='';videoCatalogue{5}='';videoCatalogue{6}='';videoCatalogue{7}='';videoCatalogue{8}='exp1\';videoCatalogue{9}='exp2\';videoCatalogue{10}='226\';
 videoCatalogue{11}='260\';videoCatalogue{12}='320\';videoCatalogue{13}='360\';videoCatalogue{14}='400\';videoCatalogue{15}='440\';videoCatalogue{16}='480\';videoCatalogue{17}='533\';videoCatalogue{18}='625\';videoCatalogue{19}='735\';videoCatalogue{20}='868\';
 videoCatalogue{21}='1225\';

NCat=[0;0;0;0;0;0;0;0;0];
%Radii of the camphor swimmers
RCat=[NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN]/2;
Rdetect=[NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN]/2;
    

startImgCatalogue=[360;370;483;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1];
hgxcat=[257;370;112;65;308;307;305;246;310;232;232;232;232;232;232;232;232;232;232;232;232]; % Coord x du coin en haut à gauche
hgycat=[309;251;120;401;245;239;239;233;191;184;184;184;184;184;184;184;184;184;184;184;184]; % Coord y du coin en haut à gauche
hdxcat=[1711;1840;1954;1587;1866;1865;1863;1817;1882;1927;1927;1927;1927;1927;1927;1927;1927;1927;1927;1927;1927]; % x haut droite
hdycat=[298;277;120;54;266;260;259;221;196;223;223;223;223;223;223;223;223;223;223;223;223]; % y haut droite
bdxcat=[1733;1822;1962;1937;1851;1850;1848;1835;1881;1891;1891;1891;1891;1891;1891;1891;1891;1891;1891;1891;1891]; % x bas gauche
bdycat=[1759;1740;1949;1573;1825;1819;1817;1785;1759;1921;1921;1921;1921;1921;1921;1921;1921;1921;1921;1921;1921]; % y bas gauche
bgxcat=[248;350;118;423;295;294;292;260;313;195;195;195;195;195;195;195;195;195;195;195;195]; % x bas droit
bgycat=[1777;1722;1962;1929;1815;1808;1807;1807;1763;1895;1895;1895;1895;1895;1895;1895;1895;1895;1895;1895;1895]; % y bas droit

centerXCat=round((hgxcat+hdxcat+bgxcat+bdxcat)/4);
centerYCat=round((hgycat+hdycat+bgycat+bdycat)/4);

coteCarre=mean([sqrt((hgxcat-hdxcat).^2+(hgycat-hdycat).^2),sqrt((hdxcat-bdxcat).^2+(hdycat-bdycat).^2),sqrt((bdxcat-bgxcat).^2+(bdycat-bgycat).^2),sqrt((bgxcat-hgxcat).^2+(bgycat-hgycat).^2)]'); %#ok<UDIM> % On fait le moyenne des 4 longueurs du carré pour chaque manip
trueCarre=[96.4,96.4,120.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5,108.5]; %en mm

calibCat=trueCarre./coteCarre;
format='*.tif';
