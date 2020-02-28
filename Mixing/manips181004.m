%Méthode de background :
%Chemins où récupérer/enregistrer les données.
basePathVid='E:\ManipeCarbopol\Users\ccottin\Downloads\';
basePathAnalyse='E:\Clément\Mixing\Analyse\';


%Ne traiter qu'une image toutes les 'saut' images
saut=1;

sizeim=1790;
%fps of the videos
fps=20;

%numbre of videos in the set
nombreVid=11;

%date de prise des videos (pour le path)
date='181004\';

%Catalogue of paths (concatenation of  'Mixing\date\set\video\')
setCatalogue=cell(1,nombreVid);
setCatalogue{1}='comp_avecssbub_40\avec';setCatalogue{2}='comp_avecssbub_40\avec';setCatalogue{3}='varMass_bubblealone\1\';setCatalogue{4}='varMass_bubblealone\1\';setCatalogue{5}='varMass_bubblealone\4\';setCatalogue{6}='varMass_bubblealone\4\';setCatalogue{7}='varMass_bubblealone\4\';setCatalogue{8}='varMass_bubblealone\4\';setCatalogue{9}='varMass_bubblealone\6\';setCatalogue{10}='varMass_bubblealone\6\';setCatalogue{11}='varMass_bubblealone\6\';

videoCatalogue=cell(1,nombreVid);
videoCatalogue{1}='\3.5';videoCatalogue{2}='\13.5';videoCatalogue{3}='0';videoCatalogue{4}='15';videoCatalogue{5}='0';videoCatalogue{6}='15';videoCatalogue{7}='20';videoCatalogue{8}='90';videoCatalogue{9}='0';videoCatalogue{10}='15';videoCatalogue{11}='42';

%Diameter of the camphor swimmers
RCat=[5;5;0;0;0;0;0;0;0;0;0];


%radius of the area of interest in pixel 
radiusCellPx=1887/2;

%calibration in mm/px
calib=180./(2*radiusCellPx);

%Starting image for the process giving the concentration field (first image
%after the disappearance of the hands/stabilisation of the camera/etc.
startImgCatalogue=[1;1;619;1;418;1;1;1;475;1;1];

%top left corner of the square in which the free surface of water is
centerCellXCat=[27;27;52;52;40;40;40;40;29;29;29];
centerCellYCat=[4;4;97;97;77;77;77;77;92;92;92];

%top left corner of the square in which the free surface of water is (in
%the background images)
centerCellXBgCat=[25;25;52;52;39;39;39;39;29;29;29];
centerCellYBgCat=[3;3;98;98;78;78;78;78;91;91;91];


format='*.tif';
