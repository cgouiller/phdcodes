%% Initialisations des tableaux
Date=[];
Rayon=[];
Nombre=[];
MasseBbg=[];
Set=[];
Projet=[];
taup=[];
Video=[];
CoefMarangoni=[];
Inertie=[];
AmpVortex=[];
Advection=[];
AmpSourceCamphre=[];
TauP=[];
Duree=[];
RandomStart=[];
VMar=[];
Dt=[];
C0=[];
Pe=[];
M=[];
Theta=[];
Delai=[];
ParamEc=[];
Bbg=[];
run manips
Afin=zeros(1,nombreVid);
L=[];
if (exist('changes','var'))==0
    changes=zeros(1,nombreVid);
end
%% Boucle de remplissage
for i=1:nombreVid
    bbg=manipCat.bbg(i);
    fname=strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{i},'\',manipCat.set{i},'\',manipCat.video{i},'.mat');
    if changes(i)==1 % On copie les fichiers nécessaires vers le dossier qu'utilisent les notebooks
        load(fname)
        if manipCat.satur(i)==0
            Afin(i)=0;
        else
            Ccampmean=mean(mean(real(ifft2(Ccamp_f))));
            Afin(i)=manipCat.A(i)/(1+Ccampmean/manipCat.satur(i));
        end
        directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{i},'\',manipCat.set{i},'\');
        if exist(directoryPyt)==0
            mkdir(directoryPyt);
        end
        if mx(end)==0
            fin=find(mx==0,1)-1;
            mx=mx(1:10:fin,:);
            my=my(1:10:fin,:);
            mvxnage=mvxnage(1:10:fin,:);
            mvynage=mvynage(1:10:fin,:);
        end
        if bbg==0
        save(strcat(directoryPyt,manipCat.video{i},'.mat'),'mx','my','mvxnage','mvynage')
        elseif bbg==1
         save(strcat(directoryPyt,manipCat.video{i},'.mat'),'mx','my','mstdbg')
        else
         save(strcat(directoryPyt,manipCat.video{i},'.mat'),'mx','my','mxbg','mybg')
        end
    end
    % Ci-dessous on prépare le fichier manips qui récap toute les infos
    % pour le notebook
    Dt=[Dt,manipCat.dt(i)];
    Date=[Date;manipCat.date{i}];
    Rayon=[Rayon,2.5];
    Duree=[Duree,manipCat.nt(i)];
    Nombre=[Nombre,manipCat.npart(i)];
    MasseBbg=[MasseBbg,0];
    Projet=[Projet;'Vortex'];
    Set=[Set;manipCat.set{i}];
    TauP=[TauP,manipCat.taup(i)];
    Video=[Video;manipCat.video{i}];
    CoefMarangoni=[CoefMarangoni,manipCat.A(i)];
    C0=[C0,manipCat.satur(i)];
    Inertie=[Inertie,manipCat.inertie(i)];
    AmpVortex=[AmpVortex,manipCat.amp_ec(i)];
    Advection=[Advection,manipCat.advection(i)];
    AmpSourceCamphre=[AmpSourceCamphre,manipCat.asrc(i)];
    RandomStart=[RandomStart,manipCat.randomstart(i)];
    Theta=[Theta,manipCat.theta(i)];
    Delai=[Delai,manipCat.delai(i)];
    L=[L,manipCat.L(i)];
    Bbg=[Bbg,manipCat.bbg(i)];
    ParamEc=[ParamEc,manipCat.paramec(i)];
    if manipCat.A(i)<0.52022
        vtmp=0;
    else
        vtmp=2.336*(manipCat.A(i)-0.52022)^0.55252;
    end
   Pe=[Pe,vtmp*sqrt(4*pi*(5/2)^2/(90)^2)/0.15];
   M=[M,manipCat.A(i)*manipCat.asrc(i)/(0.15*0.15)];

    changes(i)=0;
    clear Ccampmean;
end
save('E:\Clément\MyCore\Analyse\SimuNum\manips.mat','Nombre','AmpVortex','CoefMarangoni','TauP','Date','Set','Duree','Rayon','MasseBbg','Projet','Video','Inertie','Advection','AmpSourceCamphre','Dt','C0','Afin','M','Pe','Theta','Delai','L','Bbg','ParamEc')

