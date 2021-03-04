% Date=[];
% Rayon=[];
% Nombre=[];
% MasseBbg=[];
% Sets=[];
% Projet=[];
% NomDoss=[];
% RadiusPx=[];
% CenterX=[];
% CenterY=[];
% Param=[];
% StartIm=[];
% %%
% %clear all;
%
% run('E:\Clément\Mixing\Matlab\manipsfinales.m');
% varM=[1:3,7,8,10:13,15,16,29:31];
%
%
% list=[varN,varR,varM];
% for i=1:length(list)
%     numVid=list(i);
%
%     d=dateCatalogue(numVid);
%     d = strrep(d,'\','');
%     Date=[Date,d];
%     Rayon=[Rayon,RCat(numVid)];
%     Nombre=[Nombre,NCat(numVid)];
%     MasseBbg=[MasseBbg,MCat(numVid)];
%     d=setCatalogue(numVid);
%     d = strrep(d,'\','');
%     Sets=[Sets,d];
%     Projet=[Projet;'Mixing'];
%     d=videoCatalogue(numVid);
%     d = strrep(d,'\','');
%     NomDoss=[NomDoss,d];
%     RadiusPx=[RadiusPx,radiusCellPxCat(numVid)];
%     CenterX=[CenterX,centerCellXCat(numVid)];
%     CenterY=[CenterY,centerCellYCat(numVid)];
%     StartIm=[StartIm,startImgCatalogue(numVid)];
%     if i<=length(varN)
%         Param=[Param;'N'];
%     elseif i<=length(varN)+length(varR)
%         Param=[Param;'R'];
%     else Param=[Param;'M'];
%     end
%     %load_param;
%     %mkdir(directoryAnalysePyt);
%     % load(strcat(directoryAnalyse,'im0.mat'))
%     % save(strcat(directoryAnalysePyt,'im0.mat'),'im0')
%     % load(strcat(directoryAnalyse,'positions.mat'))
%     % save(strcat(directoryAnalysePyt,'positions.mat'),'c')
%     % load(strcat(directoryAnalyse,'trajectories.mat'))
%     % save(strcat(directoryAnalysePyt,'trajectoires.mat'),'tracks')
%     % load(strcat(directoryAnalyse,'particules_selectionnees.mat'))
%     % save(strcat(directoryAnalysePyt,'traj_filtrees.mat'),'sample')
%     %load(strcat(directoryAnalyse,'Conc.mat'))
%     %save(strcat(directoryAnalysePyt,'conc.mat'),'time','CMoy','Cstd','C2Moy')
%     % load(strcat(directoryAnalyse,'meanTrail.mat'))
%     % save(strcat(directoryAnalysePyt,'champconcmoyen.mat'),'immoy')
%     % load(strcat(directoryAnalyse,'aire_ellipse_conc.mat'))
%     % save(strcat(directoryAnalysePyt,'aire_ellipse_conc.mat'),'aire','comment','incplus','incmoins','zone_depl')
%     % load(strcat(directoryAnalyse,'meanTrailbin.mat'))
%     % save(strcat(directoryAnalysePyt,'champprobmoyen.mat'),'probdepl')
%     % load(strcat(directoryAnalyse,'aire_ellipse_proba.mat'))
%     % save(strcat(directoryAnalysePyt,'aire_ellipse_prob.mat'),'aire','comment','incplus','incmoins','zone_depl')
%     %load(strcat(directoryAnalyse,'spectre.mat'))
%     %k=f;
%     %save(strcat(directoryAnalysePyt,'spectre.mat'),'k','Sp')
% end
%
% save('E:\Clément\MyCore\Analyse\Mixing\manips.mat','Date','Rayon','Nombre','MasseBbg','Sets','Projet','NomDoss','RadiusPx','CenterX','CenterY','StartIm','Param')
%% Pour le premier set de manips:

% Date=[];
% Rayon=[];
% Nombre=[];
% MasseBbg=[];
% Set=[];
% Projet=[];
% taup=[];
% Video=[];
% CoefMarangoni=[];
% Inertie=[];
% AmpVortex=[];
% Advection=[];
% AmpSourceCamphre=[];
% VMar=[];
% TauP=[];
% Duree=[];
% RandomStart=[];
% run manips200320
% for i=1:nombreVid
%
% %     fname=strcat('E:\Clément\SimuNum\Resultats\',manipCat200320.date{i},'\',manipCat200320.set{i},'\',manipCat200320.video{i},'.mat');
% %     if exist(fname) && exist(strcat(fname(1:end-4),'_analyze.mat'))
% %         load(fname)
% %      load(strcat(fname(1:end-4),'_analyze.mat'))
% %         directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat200320.date{i},'\',manipCat200320.set{i},'\');
% %          if exist(directoryPyt)==0
% %              mkdir(directoryPyt);
% %          end
% %          mx=mx(1:10:end);
% %          my=my(1:10:end);
% %          if strcmp(manipCat200320.set{i},'pieg')
% %              frenet;
% %              save(strcat(directoryPyt,manipCat200320.video{i},'.mat'),'mx','my','dt','prodscal','tau','MeanSD')
% %          else
% %          save(strcat(directoryPyt,manipCat200320.video{i},'.mat'),'mx','my','dt','tau','MeanSD')
% %          end
% %     elseif exist(fname)~=0
% %                 load(fname)
% %         directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat200320.date{i},'\',manipCat200320.set{i},'\');
% %         mx=mx(1:10:end);
% %          my=my(1:10:end);
% %          if strcmp(manipCat200320.set{i},'pieg')
% %              frenet;
% %              save(strcat(directoryPyt,manipCat200320.video{i},'.mat'),'mx','my','dt','prodscal')
% %          else
% %                      save(strcat(directoryPyt,manipCat200320.video{i},'.mat'),'mx','my','dt')
% %
% %          end
% %
% %     end
%
%     Date=[Date;manipCat200320.date{i}];
%     Rayon=[Rayon,2.5];
%     Duree=[Duree,manipCat200320.nt(i)];
%     Nombre=[Nombre,manipCat200320.npart(i)];
%     MasseBbg=[MasseBbg,0];
%     Projet=[Projet;'Vortex'];
%     Set=[Set;manipCat200320.set{i}];
%     if manipCat200320.A(i)<0.52966
%         VMar=[VMar,0];
%     else
%         VMar=[VMar,2.3664*(manipCat200320.A(i)-0.52966)^0.57171];
%     end
%     TauP=[TauP,manipCat200320.taup(i)];
%     Video=[Video;manipCat200320.video{i}];
%     CoefMarangoni=[CoefMarangoni,manipCat200320.A(i)];
%     Inertie=[Inertie,manipCat200320.inertie(i)];
%     AmpVortex=[AmpVortex,manipCat200320.amp_ec(i)];
%     Advection=[Advection,manipCat200320.advection(i)];
%     AmpSourceCamphre=[AmpSourceCamphre,manipCat200320.asrc(i)];
%     RandomStart=[RandomStart,manipCat200320.randomstart(i)];
% end
% save('E:\Clément\MyCore\Analyse\SimuNum\manips.mat','Nombre','AmpVortex','CoefMarangoni','TauP','VMar','Date','Set','Duree','Rayon','MasseBbg','Projet','Video','Inertie','Advection','AmpSourceCamphre')


%% Pour le deuxième set de manips:
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
run manips
Afin=zeros(1,nombreVid);
L=[];
if (exist('changes','var'))==0
    changes=zeros(1,nombreVid);
end

for i=1:nombreVid
    
    fname=strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{i},'\',manipCat.set{i},'\',manipCat.video{i},'.mat');
    if changes(i)==1
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
        
        save(strcat(directoryPyt,manipCat.video{i},'.mat'),'mx','my','mvxnage','mvynage')
        
    end
    
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
    if manipCat.A(i)<0.52022
        vtmp=0;
    else
        vtmp=2.336*(manipCat.A(i)-0.52022)^0.55252;
    end
   Pe=[Pe,vtmp*sqrt(4*pi*(5/2)^2/(90)^2)/0.15];
   M=[M,manipCat.A(i)*manipCat.asrc(i)/(4*0.15*0.15)];


       %if (((manipCat.set{i}(1)=='m') || (manipCat.set{i}(1)=='s')) || (i>91 && i<101)) && changes(i)==1
       if manipCat.npart(i)>3 && changes(i)==1
                   load(fname)

            directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{i},'\',manipCat.set{i},'\');
    
            d=zeros(manipCat.npart(i),round(length(mx)*0.5));
            for j=1:manipCat.npart(i)
                d(j,:)=sqrt((mx(1+round(length(mx)/2):length(mx),j)-mx(1+round(length(mx)/2))).^2+(my(1+round(length(mx)/2):length(mx),j)-my(1+round(length(mx)/2))).^2)';
            end
            [MSD,mdx,tau]=msd(d,dt,round(logspace(0,log10(length(d)/1.5),1000)));
            save(strcat(directoryPyt,manipCat.video{i},'_msd.mat'),'MSD','tau')
       end
    changes(i)=0;
    clear Ccampmean;
end
save('E:\Clément\MyCore\Analyse\SimuNum\manips.mat','Nombre','AmpVortex','CoefMarangoni','TauP','Date','Set','Duree','Rayon','MasseBbg','Projet','Video','Inertie','Advection','AmpSourceCamphre','Dt','C0','Afin','M','Pe','Theta','Delai','L')

% for i=
%
%     fname=strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{i},'\',manipCat.set{i},'\',manipCat.video{i},'.mat');
%
%         load(fname)
%         directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{i},'\',manipCat.set{i},'\');
%          if exist(directoryPyt)==0
%              mkdir(directoryPyt);
%          end
%
%          save(strcat(directoryPyt,manipCat.video{i},'.mat'),'profs','mx','my')
%
%
%
% end
