run defaultfig;
%numbre of videos in the set
nombreVid=69;

%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='E:\Clément\Multi\';basePathVidCatalogue{2}='E:\Clément\Multi\';basePathVidCatalogue{3}='E:\Clément\Multi\';basePathVidCatalogue{4}='E:\Clément\Multi\';basePathVidCatalogue{5}='E:\Clément\Multi\';basePathVidCatalogue{6}='E:\Clément\Multi\';basePathVidCatalogue{7}='E:\Clément\Multi\';basePathVidCatalogue{8}='E:\Clément\Multi\';basePathVidCatalogue{9}='E:\Clément\Multi\';basePathVidCatalogue{10}='E:\Clément\Multi\';
basePathVidCatalogue{11}='E:\Clément\Multi\';basePathVidCatalogue{12}='E:\Clément\Multi\';basePathVidCatalogue{13}='E:\Clément\Multi\';basePathVidCatalogue{14}='E:\Clément\Multi\';basePathVidCatalogue{15}='E:\Clément\Multi\';basePathVidCatalogue{16}='E:\Clément\Multi\';basePathVidCatalogue{17}='E:\Clément\Multi\';basePathVidCatalogue{18}='E:\Clément\Multi\';basePathVidCatalogue{19}='E:\Clément\Multi\';basePathVidCatalogue{20}='E:\Clément\Multi\';
basePathVidCatalogue{21}='E:\Clément\Multi\';basePathVidCatalogue{22}='E:\Clément\Multi\';basePathVidCatalogue{23}='E:\Clément\Multi\';basePathVidCatalogue{24}='E:\Clément\Multi\';basePathVidCatalogue{25}='E:\Clément\Multi\';basePathVidCatalogue{26}='E:\Clément\Multi\';basePathVidCatalogue{27}='E:\Clément\Multi\';basePathVidCatalogue{28}='E:\Clément\Multi\';basePathVidCatalogue{29}='E:\Clément\Multi\';basePathVidCatalogue{30}='E:\Clément\Multi\';
basePathVidCatalogue{31}='E:\Clément\Multi\';basePathVidCatalogue{32}='E:\Clément\Multi\';basePathVidCatalogue{33}='E:\Clément\Multi\';basePathVidCatalogue{34}='E:\Clément\Multi\';basePathVidCatalogue{35}='E:\Clément\Multi\';basePathVidCatalogue{36}='E:\Clément\Multi\';basePathVidCatalogue{37}='E:\Clément\Multi\';basePathVidCatalogue{38}='E:\Clément\Multi\';basePathVidCatalogue{39}='E:\Clément\Multi\';basePathVidCatalogue{40}='E:\Clément\Multi\';
basePathVidCatalogue{41}='E:\Clément\Multi\';basePathVidCatalogue{42}='E:\Clément\Multi\';basePathVidCatalogue{43}='E:\Clément\Multi\';basePathVidCatalogue{44}='E:\Clément\Multi\';basePathVidCatalogue{45}='E:\Clément\Multi\';basePathVidCatalogue{46}='E:\Clément\Multi\';basePathVidCatalogue{47}='E:\Clément\Multi\';basePathVidCatalogue{48}='E:\Clément\Multi\';basePathVidCatalogue{49}='E:\Clément\Multi\';basePathVidCatalogue{50}='E:\Clément\Multi\';
basePathVidCatalogue{51}='E:\Clément\Multi\';basePathVidCatalogue{52}='E:\Clément\Multi\';basePathVidCatalogue{53}='H:\Multi\';basePathVidCatalogue{54}='H:\Multi\';basePathVidCatalogue{55}='H:\Multi\';basePathVidCatalogue{56}='H:\Multi\';basePathVidCatalogue{57}='H:\Multi\';basePathVidCatalogue{58}='H:\Multi\';basePathVidCatalogue{59}='H:\Multi\';basePathVidCatalogue{60}='H:\Multi\';
basePathVidCatalogue{61}='H:\Multi\';basePathVidCatalogue{62}='H:\Multi\';basePathVidCatalogue{63}='H:\Multi\';basePathVidCatalogue{64}='H:\Multi\';basePathVidCatalogue{65}='H:\Multi\';basePathVidCatalogue{66}='H:\Multi\';basePathVidCatalogue{67}='H:\Multi\';basePathVidCatalogue{68}='H:\Multi\';basePathVidCatalogue{69}='H:\Multi\';
basePathAnalyse='E:\Clément\Multi\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;


%fps of the videos
fpscat=[30*ones(1,52),27.8,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10];

dateCatalogue{1}='200603';dateCatalogue{2}='200603';dateCatalogue{3}='200603';dateCatalogue{4}='200603';dateCatalogue{5}='200603';dateCatalogue{6}='200603';dateCatalogue{7}='200603';dateCatalogue{8}='200603';dateCatalogue{9}='200603';dateCatalogue{10}='200603';
dateCatalogue{11}='200603';dateCatalogue{12}='200603';dateCatalogue{13}='200603';dateCatalogue{14}='200603';dateCatalogue{15}='200603';dateCatalogue{16}='200603';dateCatalogue{17}='200603';dateCatalogue{18}='200603';dateCatalogue{19}='200603';dateCatalogue{20}='200603';
dateCatalogue{21}='200608';dateCatalogue{22}='200608';dateCatalogue{23}='200608';dateCatalogue{24}='200608';dateCatalogue{25}='200608';dateCatalogue{26}='200608';dateCatalogue{27}='200608';dateCatalogue{28}='200608';dateCatalogue{29}='200608';dateCatalogue{30}='200608';
dateCatalogue{31}='200608';dateCatalogue{32}='200608';dateCatalogue{33}='200608';dateCatalogue{34}='200608';dateCatalogue{35}='200608';dateCatalogue{36}='200608';dateCatalogue{37}='200617';dateCatalogue{38}='200617';dateCatalogue{39}='200617';dateCatalogue{40}='200617';
dateCatalogue{41}='200617';dateCatalogue{42}='200617';dateCatalogue{43}='200617';dateCatalogue{44}='200617';dateCatalogue{45}='200617';dateCatalogue{46}='200617';dateCatalogue{47}='200617';dateCatalogue{48}='200617';dateCatalogue{49}='200617';dateCatalogue{50}='200617';
dateCatalogue{51}='200617';dateCatalogue{52}='200617';dateCatalogue{53}='201009';dateCatalogue{54}='201013';dateCatalogue{55}='201013';dateCatalogue{56}='201022';dateCatalogue{57}='201022';dateCatalogue{58}='201022';dateCatalogue{59}='201022';dateCatalogue{60}='201022';
dateCatalogue{61}='201022';dateCatalogue{62}='201104';dateCatalogue{63}='201104';dateCatalogue{64}='201104';dateCatalogue{65}='201104';dateCatalogue{66}='201104';dateCatalogue{67}='201104';dateCatalogue{68}='201126';dateCatalogue{69}='201126';

%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='varVite';setCatalogue{2}='varVite';setCatalogue{3}='varVite';setCatalogue{4}='varVite';setCatalogue{5}='varVite';setCatalogue{6}='varVite';setCatalogue{7}='varVite';setCatalogue{8}='varVite';setCatalogue{9}='varVite';setCatalogue{10}='varVite';
setCatalogue{11}='varVite';setCatalogue{12}='varVite';setCatalogue{13}='varVite';setCatalogue{14}='varVite';setCatalogue{15}='varVite';setCatalogue{16}='varVite';setCatalogue{17}='varVite';setCatalogue{18}='varVite';setCatalogue{19}='varVite';setCatalogue{20}='varVite';
setCatalogue{21}='varSize';setCatalogue{22}='varSize';setCatalogue{23}='varSize';setCatalogue{24}='varSize';setCatalogue{25}='varSize';setCatalogue{26}='varSize';setCatalogue{27}='varSize';setCatalogue{28}='varSize';setCatalogue{29}='varSize';setCatalogue{30}='varSize';
setCatalogue{31}='varSize';setCatalogue{32}='varSize';setCatalogue{33}='varSize';setCatalogue{34}='varSize';setCatalogue{35}='varSize';setCatalogue{36}='varSize';setCatalogue{37}='varSize';setCatalogue{38}='varSize';setCatalogue{39}='varSize';setCatalogue{40}='varSize';
setCatalogue{41}='varSize';setCatalogue{42}='varSize';setCatalogue{43}='varSize';setCatalogue{44}='varSize';setCatalogue{45}='varSize';setCatalogue{46}='varSize';setCatalogue{47}='varSize';setCatalogue{48}='varSize';setCatalogue{49}='varSize';setCatalogue{50}='varSize';
setCatalogue{51}='varSize';setCatalogue{52}='varSize';setCatalogue{53}='manip1';setCatalogue{54}='pics';setCatalogue{55}='rosaces';setCatalogue{56}='pics';setCatalogue{57}='pics';setCatalogue{58}='pics';setCatalogue{59}='rosaces';setCatalogue{60}='rosaces';
setCatalogue{61}='rosaces';setCatalogue{62}='minipics';setCatalogue{63}='minipics';setCatalogue{64}='minipics';setCatalogue{65}='rect';setCatalogue{66}='rect';setCatalogue{67}='rect';setCatalogue{68}='pics';setCatalogue{69}='pics';


actCatalogue=cell(1,nombreVid);
actCatalogue{1}='actif';actCatalogue{2}='actif';actCatalogue{3}='actif';actCatalogue{4}='actif';actCatalogue{5}='actif';actCatalogue{6}='actif';actCatalogue{7}='actif';actCatalogue{8}='actif';actCatalogue{9}='actif';actCatalogue{10}='actif';
actCatalogue{11}='passif';actCatalogue{12}='passif';actCatalogue{13}='passif';actCatalogue{14}='passif';actCatalogue{15}='passif';actCatalogue{16}='passif';actCatalogue{17}='passif';actCatalogue{18}='passif';actCatalogue{19}='passif';actCatalogue{20}='passif';
actCatalogue{21}='actif';actCatalogue{22}='actif';actCatalogue{23}='actif';actCatalogue{24}='actif';actCatalogue{25}='actif';actCatalogue{26}='actif';actCatalogue{27}='actif';actCatalogue{28}='actif';actCatalogue{29}='passif';actCatalogue{30}='passif';
actCatalogue{31}='passif';actCatalogue{32}='passif';actCatalogue{33}='passif';actCatalogue{34}='passif';actCatalogue{35}='passif';actCatalogue{36}='passif';actCatalogue{37}='passif';actCatalogue{38}='passif';actCatalogue{39}='passif';actCatalogue{40}='actif';
actCatalogue{41}='actif';actCatalogue{42}='actif';actCatalogue{43}='passif';actCatalogue{44}='passif';actCatalogue{45}='passif';actCatalogue{46}='passif';actCatalogue{47}='passif';actCatalogue{48}='actif';actCatalogue{49}='actif';actCatalogue{50}='actif';
actCatalogue{51}='actif';actCatalogue{52}='actif';actCatalogue{53}='actif';actCatalogue{54}='actif';actCatalogue{55}='actif';actCatalogue{56}='actif';actCatalogue{57}='actif';actCatalogue{58}='actif';actCatalogue{59}='actif';actCatalogue{60}='actif';
actCatalogue{61}='actif';actCatalogue{62}='actif';actCatalogue{63}='actif';actCatalogue{64}='actif';actCatalogue{65}='actif';actCatalogue{66}='actif';actCatalogue{67}='actif';actCatalogue{68}='actif';actCatalogue{69}='actif';



%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='60';videoCatalogue{2}='90';videoCatalogue{3}='120';videoCatalogue{4}='150';videoCatalogue{5}='180';videoCatalogue{6}='240';videoCatalogue{7}='300';videoCatalogue{8}='360';videoCatalogue{9}='450';videoCatalogue{10}='600';
videoCatalogue{11}='60';videoCatalogue{12}='90';videoCatalogue{13}='120';videoCatalogue{14}='150';videoCatalogue{15}='180';videoCatalogue{16}='240';videoCatalogue{17}='300';videoCatalogue{18}='360';videoCatalogue{19}='450';videoCatalogue{20}='600';
videoCatalogue{21}='90';videoCatalogue{22}='150';videoCatalogue{23}='300';videoCatalogue{24}='600';videoCatalogue{25}='60';videoCatalogue{26}='150';videoCatalogue{27}='300';videoCatalogue{28}='600';videoCatalogue{29}='90';videoCatalogue{30}='150';
videoCatalogue{31}='300';videoCatalogue{32}='600';videoCatalogue{33}='90';videoCatalogue{34}='150';videoCatalogue{35}='300';videoCatalogue{36}='600';videoCatalogue{37}='0';videoCatalogue{38}='0';videoCatalogue{39}='0';videoCatalogue{40}='0';
videoCatalogue{41}='0';videoCatalogue{42}='0';videoCatalogue{43}='0';videoCatalogue{44}='90';videoCatalogue{45}='150';videoCatalogue{46}='300';videoCatalogue{47}='600';videoCatalogue{48}='0';videoCatalogue{49}='90';videoCatalogue{50}='150';
videoCatalogue{51}='300';videoCatalogue{52}='600';videoCatalogue{53}='250';videoCatalogue{54}='120';videoCatalogue{55}='120';videoCatalogue{56}='120_1';videoCatalogue{57}='120_2';videoCatalogue{58}='120_3';videoCatalogue{59}='120_1';videoCatalogue{60}='120_2';
videoCatalogue{61}='120_3';videoCatalogue{62}='120_1';videoCatalogue{63}='120_2';videoCatalogue{64}='120_3';videoCatalogue{65}='120_1';videoCatalogue{66}='120_2';videoCatalogue{67}='120_3';videoCatalogue{68}='80';videoCatalogue{69}='100';

NCat=[1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1];
%Radii of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5;
      5;5;5;5;5;5;5;5;5;5;
      2;2;2;2;8;8;8;8;2;2;
      2;2;8;8;8;8;2;5;8;2;
      5;8;16;16;16;16;16;16;16;16;
      16;16;5;5;5;5;5;5;5;5;
      5;5;5;5;5;5;5;5;5]/2;
Rdetect=[5;5;5;5;5;5;5;5;5;5;
    2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;
    1.4;1.4;1.4;1.4;8;8;8;8;2;2;
    2;2;5.6;5.6;5.6;5.6;2;29/71*5;81/113*8;1.4
    5;8;200/230*16;200/230*16;200/230*16;200/230*16;200/230*16;16;16;16;
    16;16;5;5;5;5;5;5;5;5;
    5;5;5;5;5;5;5;5;5]/2;
    

startImgCatalogue=[61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61;
                   61;61;1;1;1;1;1;1;1;1;
                   1;1;1;1;1;1;1;1;1];
  
hgxcat=[165;166;166;168;166;164;175;174;174;174;92;87;87;86;87;87;90;90;87;87;100;105;100;100;138;142;141;141;144;137;136;137;115;110;110;110;86;87;103;161;96;121;162;162;163;162;162;141;138;139;138;138;443.5;296;301.375;254;290;270;296;256;289;312;300;364;338;365;317;279;291]; % Coord x du coin en haut à gauche
hgycat=[142;143;144;144;147;150;154;155;154;154;178;179;179;175;171;171;168;167;167;170;187;186;187;186;160;148;148;148;159;156;166;154;116;114;114;112;152;152;161;135;202;132;95;97;96;95;95;107;110;110;108;109;444.125;251;277.125;257;266;262;262;313;295;339;271;342;293;301;320;275;269]; % Coord y du coin en haut à gauche
hdxcat=[1912;1913;1912;1913;1909;1908;1919;1919;1919;1918;1839;1835;1834;1832;1834;1834;1836;1837;1835;1835;1844;1850;1844;1844;1882;1886;1886;1886;1890;1882;1881;1882;1859;1856;1856;1856;1831;1831;1846;1905;1839;1864;1906;1906;1908;1908;1907;1886;1885;1885;1885;1886;1581.25;1774.5;1776.938;1739;1773;1754;1777;1735;1771;1726;1713;1776;1746;1773;1726;1763;1774]; % x haut droite
hdycat=[153;155;156;156;157;159;161;161;162;162;157;157;159;156;152;152;151;150;151;156;153;152;153;152;151;142;142;142;152;151;162;150;96;96;94;95;148;147;154;143;215;122;126;130;128;127;127;96;96;96;95;94;452;282.25;290.062;256;268;280;283;299;302;356;313;387;332;321;350;289;286]; % y haut droite
bdxcat=[1906;1905;1906;1907;1905;1904;1918;1917;1917;1916;1864;1859;1859;1857;1855;1855;1859;1858;1856;1857;1884;1889;1883;1883;1895;1896;1897;1896;1900;1892;1892;1892;1885;1880;1879;1879;1843;1843;1860;1905;1832;1879;1879;1880;1881;1880;1880;1904;1903;1904;1904;1904;1577.875;1746.167;1767.083;1747;1779;1743;1760;1752;1767;1711;1673;1733;1714;1761;1704;1758;1766]; % x bas gauche
bdycat=[1892;1892;1893;1892;1894;1897;1899;1899;1899;1900;1896;1896;1897;1894;1891;1891;1889;1890;1889;1893;1888;1886;1887;1886;1886;1877;1877;1877;1887;1887;1896;1885;1831;1831;1831;1829;1883;1882;1890;1879;1951;1859;1862;1864;1863;1862;1862;1831;1833;1833;1831;1831;1583;1770;1770;1745;1757;1767;1756;1772;1775;1763;1719;1793;1743;1730;1761;1777;1774]; % y bas gauche
bgxcat=[156;158;159;160;158;156;170;169;170;170;114;112;112;106;108;106;109;108;108;110;139;144;139;139;151;150;151;152;156;146;146;146;138;134;134;134;97;97;115;159;87;134;136;134;136;135;137;158;156;157;157;158;439.917;261;288.938;265;294;259;276;269;281;297;260;319;305;351;294;276;282]; % x bas droit
bgycat=[1886;1886;1888;1886;1890;1892;1897;1897;1897;1897;1922;1924;1923;1918;1915;1915;1912;1911;1911;1914;1927;1930;1929;1928;1903;1892;1891;1890;1905;1901;1909;1899;1860;1858;1858;1856;1898;1896;1904;1880;1944;1876;1836;1841;1837;1837;1838;1851;1855;1854;1850;1851;1581;1747;1766.062;1755;1764;1760;1744;1794;1777;1755;1685;1756;1711;1717;1738;1774;1766]; % y bas droit


coteCarre=mean([sqrt((hgxcat-hdxcat).^2+(hgycat-hdycat).^2),sqrt((hdxcat-bdxcat).^2+(hdycat-bdycat).^2),sqrt((bdxcat-bgxcat).^2+(bdycat-bgycat).^2),sqrt((bgxcat-hgxcat).^2+(bgycat-hgycat).^2)]'); %#ok<UDIM> % On fait le moyenne des 4 longueurs du carré pour chaque manip
calibCat=[120.5./coteCarre(1:52),96.4/coteCarre(53),106.3/coteCarre(54),107/coteCarre(55),96.4/1339.5,96.4/1340,96.4/1340,96.4/1346,96.4/1344,96.4/1345,101.4/1415,101.4/1415,101.4/1414,101.4/1409,101.4/1409,101.4/1409,96.4/1342,96.4/1338]; %120.5 mm est le côté du carré

format='*.tif';
