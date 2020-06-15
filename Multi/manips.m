run defaultfig;
%numbre of videos in the set
nombreVid=36;

%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='E:\Clément\Multi\';basePathVidCatalogue{2}='E:\Clément\Multi\';basePathVidCatalogue{3}='E:\Clément\Multi\';basePathVidCatalogue{4}='E:\Clément\Multi\';basePathVidCatalogue{5}='E:\Clément\Multi\';basePathVidCatalogue{6}='E:\Clément\Multi\';basePathVidCatalogue{7}='E:\Clément\Multi\';basePathVidCatalogue{8}='E:\Clément\Multi\';basePathVidCatalogue{9}='E:\Clément\Multi\';basePathVidCatalogue{10}='E:\Clément\Multi\';
basePathVidCatalogue{11}='E:\Clément\Multi\';basePathVidCatalogue{12}='E:\Clément\Multi\';basePathVidCatalogue{13}='E:\Clément\Multi\';basePathVidCatalogue{14}='E:\Clément\Multi\';basePathVidCatalogue{15}='E:\Clément\Multi\';basePathVidCatalogue{16}='E:\Clément\Multi\';basePathVidCatalogue{17}='E:\Clément\Multi\';basePathVidCatalogue{18}='E:\Clément\Multi\';basePathVidCatalogue{19}='E:\Clément\Multi\';basePathVidCatalogue{20}='E:\Clément\Multi\';
basePathVidCatalogue{21}='E:\Clément\Multi\';basePathVidCatalogue{22}='E:\Clément\Multi\';basePathVidCatalogue{23}='E:\Clément\Multi\';basePathVidCatalogue{24}='E:\Clément\Multi\';basePathVidCatalogue{25}='E:\Clément\Multi\';basePathVidCatalogue{26}='E:\Clément\Multi\';basePathVidCatalogue{27}='E:\Clément\Multi\';basePathVidCatalogue{28}='E:\Clément\Multi\';basePathVidCatalogue{29}='E:\Clément\Multi\';basePathVidCatalogue{30}='E:\Clément\Multi\';
basePathVidCatalogue{31}='E:\Clément\Multi\';basePathVidCatalogue{32}='E:\Clément\Multi\';basePathVidCatalogue{33}='E:\Clément\Multi\';basePathVidCatalogue{34}='E:\Clément\Multi\';basePathVidCatalogue{35}='E:\Clément\Multi\';basePathVidCatalogue{36}='E:\Clément\Multi\';
basePathAnalyse='E:\Clément\Multi\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;


%fps of the videos
fps=30;



%date de prise des videos (pour le path)
dateCatalogue=cell(1,nombreVid);
dateCatalogue{1}='200603\';dateCatalogue{2}='200603\';dateCatalogue{3}='200603\';dateCatalogue{4}='200603\';dateCatalogue{5}='200603\';dateCatalogue{6}='200603\';dateCatalogue{7}='200603\';dateCatalogue{8}='200603\';dateCatalogue{9}='200603\';dateCatalogue{10}='200603\';
dateCatalogue{11}='200603\';dateCatalogue{12}='200603\';dateCatalogue{13}='200603\';dateCatalogue{14}='200603\';dateCatalogue{15}='200603\';dateCatalogue{16}='200603\';dateCatalogue{17}='200603\';dateCatalogue{18}='200603\';dateCatalogue{19}='200603\';dateCatalogue{20}='200603\';
dateCatalogue{21}='200608\';dateCatalogue{22}='200608\';dateCatalogue{23}='200608\';dateCatalogue{24}='200608\';dateCatalogue{25}='200608\';dateCatalogue{26}='200608\';dateCatalogue{27}='200608\';dateCatalogue{28}='200608\';dateCatalogue{29}='200608\';dateCatalogue{30}='200608\';
dateCatalogue{31}='200608\';dateCatalogue{32}='200608\';dateCatalogue{33}='200608\';dateCatalogue{34}='200608\';dateCatalogue{35}='200608\';dateCatalogue{36}='200608\';

%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='actif\';setCatalogue{2}='actif\';setCatalogue{3}='actif\';setCatalogue{4}='actif\';setCatalogue{5}='actif\';setCatalogue{6}='actif\';setCatalogue{7}='actif\';setCatalogue{8}='actif\';setCatalogue{9}='actif\';setCatalogue{10}='actif\';
setCatalogue{11}='passif\';setCatalogue{12}='passif\';setCatalogue{13}='passif\';setCatalogue{14}='passif\';setCatalogue{15}='passif\';setCatalogue{16}='passif\';setCatalogue{17}='passif\';setCatalogue{18}='passif\';setCatalogue{19}='passif\';setCatalogue{20}='passif\';
setCatalogue{21}='varSize\actif\2\';setCatalogue{22}='varSize\actif\2\';setCatalogue{23}='varSize\actif\2\';setCatalogue{24}='varSize\actif\2\';setCatalogue{25}='varSize\actif\8\';setCatalogue{26}='varSize\actif\8\';setCatalogue{27}='varSize\actif\8\';setCatalogue{28}='varSize\actif\8\';setCatalogue{29}='varSize\passif\2\';setCatalogue{30}='varSize\passif\2\';
setCatalogue{31}='varSize\passif\2\';setCatalogue{32}='varSize\passif\2\';setCatalogue{33}='varSize\passif\8\';setCatalogue{34}='varSize\passif\8\';setCatalogue{35}='varSize\passif\8\';setCatalogue{36}='varSize\passif\8\';

%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='60\';videoCatalogue{2}='90\';videoCatalogue{3}='120\';videoCatalogue{4}='150\';videoCatalogue{5}='180\';videoCatalogue{6}='240\';videoCatalogue{7}='300\';videoCatalogue{8}='360\';videoCatalogue{9}='450\';videoCatalogue{10}='600\';
videoCatalogue{11}='60\';videoCatalogue{12}='90\';videoCatalogue{13}='120\';videoCatalogue{14}='150\';videoCatalogue{15}='180\';videoCatalogue{16}='240\';videoCatalogue{17}='300\';videoCatalogue{18}='360\';videoCatalogue{19}='450\';videoCatalogue{20}='600\';
videoCatalogue{21}='90\';videoCatalogue{22}='150\';videoCatalogue{23}='300\';videoCatalogue{24}='600\';videoCatalogue{25}='60\';videoCatalogue{26}='150\';videoCatalogue{27}='300\';videoCatalogue{28}='600\';videoCatalogue{29}='90\';videoCatalogue{30}='150\';
videoCatalogue{31}='300\';videoCatalogue{32}='600\';videoCatalogue{33}='90\';videoCatalogue{34}='150\';videoCatalogue{35}='300\';videoCatalogue{36}='600\';
NCat=[1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1];
%Radii of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5;
      5;5;5;5;5;5;5;5;5;5;
      2;2;2;2;8;8;8;8;2;2;
      2;2;8;8;8;8]/2;
Rdetect=[5;5;5;5;5;5;5;5;5;5;
    2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;
    1.4;1.4;1.4;1.4;8;8;8;8;2;2;
    2;2;5.6;5.6;5.6;5.6]/2;
    

startImgCatalogue=[61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61];
  
hgxcat=[165;166;166;168;166;164;175;174;174;174;92;87;87;86;87;87;90;90;87;87;100;105;100;100;138;142;141;141;144;137;136;137;115;110;110;110]; % Coord x du coin en haut à gauche
hgycat=[142;143;144;144;147;150;154;155;154;154;178;179;179;175;171;171;168;167;167;170;187;186;187;186;160;148;148;148;159;156;166;154;116;114;114;112]; % Coord y du coin en haut à gauche
hdxcat=[1912;1913;1912;1913;1909;1908;1919;1919;1919;1918;1839;1835;1834;1832;1834;1834;1836;1837;1835;1835;1844;1850;1844;1844;1882;1886;1886;1886;1890;1882;1881;1882;1859;1856;1856;1856]; % x haut droite
hdycat=[153;155;156;156;157;159;161;161;162;162;157;157;159;156;152;152;151;150;151;156;153;152;153;152;151;142;142;142;152;151;162;150;96;96;94;95]; % y haut droite
bdxcat=[1906;1905;1906;1907;1905;1904;1918;1917;1917;1916;1864;1859;1859;1857;1855;1855;1859;1858;1856;1857;1884;1889;1883;1883;1895;1896;1897;1896;1900;1892;1892;1892;1885;1880;1879;1879]; % x bas gauche
bdycat=[1892;1892;1893;1892;1894;1897;1899;1899;1899;1900;1896;1896;1897;1894;1891;1891;1889;1890;1889;1893;1888;1886;1887;1886;1886;1877;1877;1877;1887;1887;1896;1885;1831;1831;1831;1829]; % y bas gauche
bgxcat=[156;158;159;160;158;156;170;169;170;170;114;112;112;106;108;106;109;108;108;110;139;144;139;139;151;150;151;152;156;146;146;146;138;134;134;134]; % x bas droit
bgycat=[1886;1886;1888;1886;1890;1892;1897;1897;1897;1897;1922;1924;1923;1918;1915;1915;1912;1911;1911;1914;1927;1930;1929;1928;1903;1892;1891;1890;1905;1901;1909;1899;1860;1858;1858;1856]; % y bas droit

coteCarre=mean([sqrt((hgxcat-hdxcat).^2+(hgycat-hdycat).^2),sqrt((hdxcat-bdxcat).^2+(hdycat-bdycat).^2),sqrt((bdxcat-bgxcat).^2+(bdycat-bgycat).^2),sqrt((bgxcat-hgxcat).^2+(bgycat-hgycat).^2)]'); %#ok<UDIM> % On fait le moyenne des 4 longueurs du carré pour chaque manip
calibCat=120.5./coteCarre; %120.5 mm est le côté du carré

format='*.tif';
