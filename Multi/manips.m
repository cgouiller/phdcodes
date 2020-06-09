run defaultfig;
%numbre of videos in the set
nombreVid=20;

%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='E:\Clément\Multi\';basePathVidCatalogue{2}='E:\Clément\Multi\';basePathVidCatalogue{3}='E:\Clément\Multi\';basePathVidCatalogue{4}='E:\Clément\Multi\';basePathVidCatalogue{5}='E:\Clément\Multi\';basePathVidCatalogue{6}='E:\Clément\Multi\';basePathVidCatalogue{7}='E:\Clément\Multi\';basePathVidCatalogue{8}='E:\Clément\Multi\';basePathVidCatalogue{9}='E:\Clément\Multi\';basePathVidCatalogue{10}='E:\Clément\Multi\';
basePathVidCatalogue{11}='E:\Clément\Multi\';basePathVidCatalogue{12}='E:\Clément\Multi\';basePathVidCatalogue{13}='E:\Clément\Multi\';basePathVidCatalogue{14}='E:\Clément\Multi\';basePathVidCatalogue{15}='E:\Clément\Multi\';basePathVidCatalogue{16}='E:\Clément\Multi\';basePathVidCatalogue{17}='E:\Clément\Multi\';basePathVidCatalogue{18}='E:\Clément\Multi\';basePathVidCatalogue{19}='E:\Clément\Multi\';basePathVidCatalogue{20}='E:\Clément\Multi\';
basePathAnalyse='E:\Clément\Multi\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;


%fps of the videos
fps=30;



%date de prise des videos (pour le path)
dateCatalogue=cell(1,nombreVid);
dateCatalogue{1}='200603\';dateCatalogue{2}='200603\';dateCatalogue{3}='200603\';dateCatalogue{4}='200603\';dateCatalogue{5}='200603\';dateCatalogue{6}='200603\';dateCatalogue{7}='200603\';dateCatalogue{8}='200603\';dateCatalogue{9}='200603\';dateCatalogue{10}='200603\';
dateCatalogue{11}='200603\';dateCatalogue{12}='200603\';dateCatalogue{13}='200603\';dateCatalogue{14}='200603\';dateCatalogue{15}='200603\';dateCatalogue{16}='200603\';dateCatalogue{17}='200603\';dateCatalogue{18}='200603\';dateCatalogue{19}='200603\';dateCatalogue{20}='200603\';
%Catalogue of paths (concatenation of 'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='actif\';setCatalogue{2}='actif\';setCatalogue{3}='actif\';setCatalogue{4}='actif\';setCatalogue{5}='actif\';setCatalogue{6}='actif\';setCatalogue{7}='actif\';setCatalogue{8}='actif\';setCatalogue{9}='actif\';setCatalogue{10}='actif\';
setCatalogue{11}='passif\';setCatalogue{12}='passif\';setCatalogue{13}='passif\';setCatalogue{14}='passif\';setCatalogue{15}='passif\';setCatalogue{16}='passif\';setCatalogue{17}='passif\';setCatalogue{18}='passif\';setCatalogue{19}='passif\';setCatalogue{20}='passif\';

%Name of the folders
videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='60\';videoCatalogue{2}='90\';videoCatalogue{3}='120\';videoCatalogue{4}='150\';videoCatalogue{5}='180\';videoCatalogue{6}='240\';videoCatalogue{7}='300\';videoCatalogue{8}='360\';videoCatalogue{9}='450\';videoCatalogue{10}='600\';
videoCatalogue{11}='60\';videoCatalogue{12}='90\';videoCatalogue{13}='120\';videoCatalogue{14}='150\';videoCatalogue{15}='180\';videoCatalogue{16}='240\';videoCatalogue{17}='300\';videoCatalogue{18}='360\';videoCatalogue{19}='450\';videoCatalogue{20}='600\';

NCat=[1;1;1;1;1;1;1;1;1;1;
      1;1;1;1;1;1;1;1;1;1];
%Radii of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5;
      5;5;5;5;5;5;5;5;5;5]/2;
Rdetect=[5;5;5;5;5;5;5;5;5;5;
    2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3;2.3]/2;
    

startImgCatalogue=[61;61;61;61;61;61;61;61;61;61;
                   61;61;61;61;61;61;61;61;61;61];
  
hgxcat=[165;166;166;168;166;164;175;174;174;174;92;87;87;86;87;87;90;90;87;87]; % Coord x du coin en haut à gauche
hgycat=[142;143;144;144;147;150;154;155;154;154;178;179;179;175;171;171;168;167;167;170]; % Coord y du coin en haut à gauche
hdxcat=[1912;1913;1912;1913;1909;1908;1919;1919;1919;1918;1839;1835;1834;1832;1834;1834;1836;1837;1835;1835]; % x haut droite
hdycat=[153;155;156;156;157;159;161;161;162;162;157;157;159;156;152;152;151;150;151;156]; % y haut droite
bgxcat=[1906;1905;1906;1907;1905;1904;1918;1917;1917;1916;1864;1859;1859;1857;1855;1855;1859;1858;1856;1857]; % x bas gauche
bgycat=[1892;1892;1893;1892;1894;1897;1899;1899;1899;1900;1896;1896;1897;1894;1891;1891;1889;1890;1889;1893]; % y bas gauche
bdxcat=[156;158;159;160;158;156;170;169;170;170;114;112;112;106;108;106;109;108;108;110]; % x bas droit
bdycat=[1886;1886;1888;1886;1890;1892;1897;1897;1897;1897;1922;1924;1923;1918;1915;1915;1912;1911;1911;1914]; % y bas droit

coteCarre=mean([sqrt((hgxcat-hdxcat).^2+(hgycat-hdycat).^2),sqrt((hdxcat-bdxcat).^2+(hdycat-bdycat).^2),sqrt((bdxcat-bdxcat).^2+(bdycat-bdycat).^2),sqrt((bgxcat-bdxcat).^2+(bdycat-bdycat).^2)]'); %#ok<UDIM> % On fait le moyenne des 4 longueurs du carré pour chaque manip
calib=120.5./mean(coteCarre); %120.5 mm est le côté du carré
format='*.tif';
