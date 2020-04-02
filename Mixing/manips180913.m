%numbre of videos in the set
nombreVid=14;
%Méthode de background :
%Chemins où récupérer/enregistrer les données.
basePathVidCatalogue=cell(1,nombreVid);
basePathVidCatalogue{1}='E:\Clément\Mixing\';basePathVidCatalogue{2}='E:\Clément\Mixing\';basePathVidCatalogue{3}='E:\Clément\Mixing\';basePathVidCatalogue{4}='E:\Clément\Mixing\';basePathVidCatalogue{5}='E:\Clément\Mixing\';basePathVidCatalogue{6}='E:\Clément\Mixing\';basePathVidCatalogue{7}='E:\Clément\Mixing\';basePathVidCatalogue{8}='E:\Clément\Mixing\';basePathVidCatalogue{9}='E:\Clément\Mixing\';basePathVidCatalogue{10}='E:\Clément\Mixing\';basePathVidCatalogue{11}='E:\Clément\Mixing\';basePathVidCatalogue{12}='E:\Clément\Mixing\';basePathVidCatalogue{13}='E:\Clément\Mixing\';basePathVidCatalogue{14}='E:\Clément\Mixing\';

basePathAnalyse='E:\Clément\Mixing\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;

sizeim=1888;
%fps of the videos
fps=20;



%date de prise des videos (pour le path)
dateCatalogue=cell(1,nombreVid);
dateCatalogue{1}='180913\';dateCatalogue{2}='180913\';dateCatalogue{3}='180913\';dateCatalogue{4}='180913\';dateCatalogue{5}='180913\';dateCatalogue{6}='180913\';dateCatalogue{7}='180913\';dateCatalogue{8}='180913\';dateCatalogue{9}='180913\';dateCatalogue{10}='180913\';dateCatalogue{11}='180913\';dateCatalogue{12}='180913\';dateCatalogue{13}='180913\';dateCatalogue{14}='180913\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='';setCatalogue{2}='';setCatalogue{3}='';setCatalogue{4}='';setCatalogue{5}='';setCatalogue{6}='';
setCatalogue{7}='';setCatalogue{8}='';setCatalogue{9}='';setCatalogue{10}='';setCatalogue{11}='';
setCatalogue{12}='';setCatalogue{13}='';setCatalogue{14}='';


videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='0\';videoCatalogue{2}='15\';videoCatalogue{3}='20\';videoCatalogue{4}='25\';videoCatalogue{5}='30\';videoCatalogue{6}='40\';
videoCatalogue{7}='50\';videoCatalogue{8}='60\';videoCatalogue{9}='75\';videoCatalogue{10}='90\';videoCatalogue{11}='105\';
videoCatalogue{12}='120\';videoCatalogue{13}='150\';videoCatalogue{14}='180\';

%Diameter of the camphor swimmers
RCat=[5;5;5;5;5;5;5;5;5;5;5;5;5;5];


%radius of the area of interest in pixel 
radiusCellPxCat=[1888/2,1888/2,1888/2,1888/2,1888/2,1888/2,1888/2,1888/2,1888/2,1888/2,1888/2,1888/2,1888/2,1888/2];

%calibration in mm/px
calibCat=180./(2*radiusCellPxCat);


%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.

startImgCatalogue=[325;1;1;1;1;1;1;1;1;1;1;1;1;1];

%top left corner of the square in which the free surface of water is
centerCellXCat=[74;74;74;74;74;74;74;74;74;74;74;74;74;74];
centerCellYCat=[69;69;69;69;69;69;69;69;69;69;69;69;69;69];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[74;74;74;74;74;74;74;74;74;74;74;74;74;74];
centerCellYBgCat=[68;68;68;68;68;68;68;68;68;68;68;68;68;68];

NCat=[10;10;10;10;10;10;10;10;10;10;10;10;10;10];
RCat=[2.5;2.5;2.5;2.5;2.5;2.5;2.5;2.5;2.5;2.5;2.5;2.5;2.5;2.5];





%Starting time (in s) of the stationnary zone
%startCatalogue=[NaN;0;0;0;0;0;0;0;0;0;0;0;0;0];
%endCatalogue=[NaN;50;50;50;50;50;50;50;50;50;50;50;50;50];



format='*.tif';
