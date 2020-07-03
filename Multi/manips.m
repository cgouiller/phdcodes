run defaultfig;
%numbre of videos in the set
nombreVid=52;

%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='E:\Clément\Multi\';basePathVidCatalogue{2}='E:\Clément\Multi\';basePathVidCatalogue{3}='E:\Clément\Multi\';basePathVidCatalogue{4}='E:\Clément\Multi\';basePathVidCatalogue{5}='E:\Clément\Multi\';basePathVidCatalogue{6}='E:\Clément\Multi\';basePathVidCatalogue{7}='E:\Clément\Multi\';basePathVidCatalogue{8}='E:\Clément\Multi\';basePathVidCatalogue{9}='E:\Clément\Multi\';basePathVidCatalogue{10}='E:\Clément\Multi\';
basePathVidCatalogue{11}='E:\Clément\Multi\';basePathVidCatalogue{12}='E:\Clément\Multi\';basePathVidCatalogue{13}='E:\Clément\Multi\';basePathVidCatalogue{14}='E:\Clément\Multi\';basePathVidCatalogue{15}='E:\Clément\Multi\';basePathVidCatalogue{16}='E:\Clément\Multi\';basePathVidCatalogue{17}='E:\Clément\Multi\';basePathVidCatalogue{18}='E:\Clément\Multi\';basePathVidCatalogue{19}='E:\Clément\Multi\';basePathVidCatalogue{20}='E:\Clément\Multi\';
basePathVidCatalogue{21}='E:\Clément\Multi\';basePathVidCatalogue{22}='E:\Clément\Multi\';basePathVidCatalogue{23}='E:\Clément\Multi\';basePathVidCatalogue{24}='E:\Clément\Multi\';basePathVidCatalogue{25}='E:\Clément\Multi\';basePathVidCatalogue{26}='E:\Clément\Multi\';basePathVidCatalogue{27}='E:\Clément\Multi\';basePathVidCatalogue{28}='E:\Clément\Multi\';basePathVidCatalogue{29}='E:\Clément\Multi\';basePathVidCatalogue{30}='E:\Clément\Multi\';
basePathVidCatalogue{31}='E:\Clément\Multi\';basePathVidCatalogue{32}='E:\Clément\Multi\';basePathVidCatalogue{33}='E:\Clément\Multi\';basePathVidCatalogue{34}='E:\Clément\Multi\';basePathVidCatalogue{35}='E:\Clément\Multi\';basePathVidCatalogue{36}='E:\Clément\Multi\';basePathVidCatalogue{37}='E:\Clément\Multi\';basePathVidCatalogue{38}='E:\Clément\Multi\';basePathVidCatalogue{39}='E:\Clément\Multi\';basePathVidCatalogue{40}='E:\Clément\Multi\';
basePathVidCatalogue{41}='E:\Clément\Multi\';basePathVidCatalogue{42}='E:\Clément\Multi\';basePathVidCatalogue{43}='E:\Clément\Multi\';basePathVidCatalogue{44}='E:\Clément\Multi\';basePathVidCatalogue{45}='E:\Clément\Multi\';basePathVidCatalogue{46}='E:\Clément\Multi\';basePathVidCatalogue{47}='E:\Clément\Multi\';basePathVidCatalogue{48}='E:\Clément\Multi\';basePathVidCatalogue{49}='E:\Clément\Multi\';basePathVidCatalogue{50}='E:\Clément\Multi\';
basePathVidCatalogue{51}='E:\Clément\Multi\';basePathVidCatalogue{52}='E:\Clément\Multi\';
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
dateCatalogue{31}='200608\';dateCatalogue{32}='200608\';dateCatalogue{33}='200608\';dateCatalogue{34}='200608\';dateCatalogue{35}='200608\';dateCatalogue{36}='200608\';dateCatalogue{37}='200617\';dateCatalogue{38}='200617\';dateCatalogue{39}='200617\';dateCatalogue{40}='200617\';
dateCatalogue{41}='200617\';dateCatalogue{42}='200617\';dateCatalogue{43}='200617\';dateCatalogue{44}='200617\';dateCatalogue{45}='200617\';dateCatalogue{46}='200617\';dateCatalogue{47}='200617\';dateCatalogue{48}='200617\';dateCatalogue{49}='200617\';dateCatalogue{50}='200617\';
dateCatalogue{51}='200617\';dateCatalogue{52}='200617\';

%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='actif\';setCatalogue{2}='actif\';setCatalogue{3}='actif\';setCatalogue{4}='actif\';setCatalogue{5}='actif\';setCatalogue{6}='actif\';setCatalogue{7}='actif\';setCatalogue{8}='actif\';setCatalogue{9}='actif\';setCatalogue{10}='actif\';
setCatalogue{11}='passif\';setCatalogue{12}='passif\';setCatalogue{13}='passif\';setCatalogue{14}='passif\';setCatalogue{15}='passif\';setCatalogue{16}='passif\';setCatalogue{17}='passif\';setCatalogue{18}='passif\';setCatalogue{19}='passif\';setCatalogue{20}='passif\';
setCatalogue{21}='varSize\actif\2\';setCatalogue{22}='varSize\actif\2\';setCatalogue{23}='varSize\actif\2\';setCatalogue{24}='varSize\actif\2\';setCatalogue{25}='varSize\actif\8\';setCatalogue{26}='varSize\actif\8\';setCatalogue{27}='varSize\actif\8\';setCatalogue{28}='varSize\actif\8\';setCatalogue{29}='varSize\passif\2\';setCatalogue{30}='varSize\passif\2\';
setCatalogue{31}='varSize\passif\2\';setCatalogue{32}='varSize\passif\2\';setCatalogue{33}='varSize\passif\8\';setCatalogue{34}='varSize\passif\8\';setCatalogue{35}='varSize\passif\8\';setCatalogue{36}='varSize\passif\8\';setCatalogue{37}='varSize\passif\2\';setCatalogue{38}='varSize\passif\5\';setCatalogue{39}='varSize\passif\8\';setCatalogue{40}='varSize\actif\2\';
setCatalogue{41}='varSize\actif\5\';setCatalogue{42}='varSize\actif\8\';setCatalogue{43}='varSize\passif\16\';setCatalogue{44}='varSize\passif\16\';setCatalogue{45}='varSize\passif\16\';setCatalogue{46}='varSize\passif\16\';setCatalogue{47}='varSize\passif\16\';setCatalogue{48}='varSize\actif\16\';setCatalogue{49}='varSize\actif\16\';setCatalogue{50}='varSize\actif\16\';
setCatalogue{51}='varSize\actif\16\';setCatalogue{52}='varSize\actif\16\';

%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='60\';videoCatalogue{2}='90\';videoCatalogue{3}='120\';videoCatalogue{4}='150\';videoCatalogue{5}='180\';videoCatalogue{6}='240\';videoCatalogue{7}='300\';videoCatalogue{8}='360\';videoCatalogue{9}='450\';videoCatalogue{10}='600\';
videoCatalogue{11}='60\';videoCatalogue{12}='90\';videoCatalogue{13}='120\';videoCatalogue{14}='150\';videoCatalogue{15}='180\';videoCatalogue{16}='240\';videoCatalogue{17}='300\';videoCatalogue{18}='360\';videoCatalogue{19}='450\';videoCatalogue{20}='600\';
videoCatalogue{21}='90\';videoCatalogue{22}='150\';videoCatalogue{23}='300\';videoCatalogue{24}='600\';videoCatalogue{25}='60\';videoCatalogue{26}='150\';videoCatalogue{27}='300\';videoCatalogue{28}='600\';videoCatalogue{29}='90\';videoCatalogue{30}='150\';
videoCatalogue{31}='300\';videoCatalogue{32}='600\';videoCatalogue{33}='90\';videoCatalogue{34}='150\';videoCatalogue{35}='300\';videoCatalogue{36}='600\';videoCatalogue{37}='0\';videoCatalogue{38}='0\';videoCatalogue{39}='0\';videoCatalogue{40}='0\';
videoCatalogue{41}='0\';videoCatalogue{42}='0\';videoCatalogue{43}='0\';videoCatalogue{44}='90\';videoCatalogue{45}='150\';videoCatalogue{46}='300\';videoCatalogue{47}='600\';videoCatalogue{48}='0\';videoCatalogue{49}='90\';videoCatalogue{50}='150\';
videoCatalogue{51}='300\';videoCatalogue{52}='600\';

NCat=[1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1];
%Radii of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5;
      5;5;5;5;5;5;5;5;5;5;
      2;2;2;2;8;8;8;8;2;2;
      2;2;8;8;8;8;2;5;8;2;
      5;8;16;16;16;16;16;16;16;16;
      16;16]/2;
Rdetect=[5;5;5;5;5;5;5;5;5;5;
    2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;
    1.4;1.4;1.4;1.4;8;8;8;8;2;2;
    2;2;5.6;5.6;5.6;5.6;2;29/71*5;81/113*8;1.4
    5;8;200/230*16;200/230*16;200/230*16;200/230*16;200/230*16;16;16;16;
    16;16]/2;
    

startImgCatalogue=[61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61];
  
hgxcat=[165;166;166;168;166;164;175;174;174;174;92;87;87;86;87;87;90;90;87;87;100;105;100;100;138;142;141;141;144;137;136;137;115;110;110;110;86;87;103;161;96;121;162;162;163;162;162;141;138;139;138;138]; % Coord x du coin en haut à gauche
hgycat=[142;143;144;144;147;150;154;155;154;154;178;179;179;175;171;171;168;167;167;170;187;186;187;186;160;148;148;148;159;156;166;154;116;114;114;112;152;152;161;135;202;132;95;97;96;95;95;107;110;110;108;109]; % Coord y du coin en haut à gauche
hdxcat=[1912;1913;1912;1913;1909;1908;1919;1919;1919;1918;1839;1835;1834;1832;1834;1834;1836;1837;1835;1835;1844;1850;1844;1844;1882;1886;1886;1886;1890;1882;1881;1882;1859;1856;1856;1856;1831;1831;1846;1905;1839;1864;1906;1906;1908;1908;1907;1886;1885;1885;1885;1886]; % x haut droite
hdycat=[153;155;156;156;157;159;161;161;162;162;157;157;159;156;152;152;151;150;151;156;153;152;153;152;151;142;142;142;152;151;162;150;96;96;94;95;148;147;154;143;215;122;126;130;128;127;127;96;96;96;95;94]; % y haut droite
bdxcat=[1906;1905;1906;1907;1905;1904;1918;1917;1917;1916;1864;1859;1859;1857;1855;1855;1859;1858;1856;1857;1884;1889;1883;1883;1895;1896;1897;1896;1900;1892;1892;1892;1885;1880;1879;1879;1843;1843;1860;1905;1832;1879;1879;1880;1881;1880;1880;1904;1903;1904;1904;1904]; % x bas gauche
bdycat=[1892;1892;1893;1892;1894;1897;1899;1899;1899;1900;1896;1896;1897;1894;1891;1891;1889;1890;1889;1893;1888;1886;1887;1886;1886;1877;1877;1877;1887;1887;1896;1885;1831;1831;1831;1829;1883;1882;1890;1879;1951;1859;1862;1864;1863;1862;1862;1831;1833;1833;1831;1831]; % y bas gauche
bgxcat=[156;158;159;160;158;156;170;169;170;170;114;112;112;106;108;106;109;108;108;110;139;144;139;139;151;150;151;152;156;146;146;146;138;134;134;134;97;97;115;159;87;134;136;134;136;135;137;158;156;157;157;158]; % x bas droit
bgycat=[1886;1886;1888;1886;1890;1892;1897;1897;1897;1897;1922;1924;1923;1918;1915;1915;1912;1911;1911;1914;1927;1930;1929;1928;1903;1892;1891;1890;1905;1901;1909;1899;1860;1858;1858;1856;1898;1896;1904;1880;1944;1876;1836;1841;1837;1837;1838;1851;1855;1854;1850;1851]; % y bas droit

coteCarre=mean([sqrt((hgxcat-hdxcat).^2+(hgycat-hdycat).^2),sqrt((hdxcat-bdxcat).^2+(hdycat-bdycat).^2),sqrt((bdxcat-bgxcat).^2+(bdycat-bgycat).^2),sqrt((bgxcat-hgxcat).^2+(bgycat-hgycat).^2)]'); %#ok<UDIM> % On fait le moyenne des 4 longueurs du carré pour chaque manip
calibCat=120.5./coteCarre; %120.5 mm est le côté du carré

format='*.tif';
