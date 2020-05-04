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
%%

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
run manips
for i=1:nombreVid
    
    fname=strcat('E:\Clément\SimuNum\Resultats2\',manipCat200320.date{i},'\',manipCat200320.set{i},'\',manipCat200320.video{i},'.mat');
    load(fname)
    load(strcat(fname(1:end-4),'_analyze.mat'))  
    directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat200320.date{i},'\',manipCat200320.set{i},'\');
    mkdir(directoryPyt);
    
    save(strcat(directoryPyt,manipCat200320.video{i},'.mat'),'mx','my','dt','tau','MeanSD')
    
    
    Date=[Date;manipCat200320.date{i}];
    Rayon=[Rayon,2.5];
    Duree=[Duree,manipCat200320.nt(i)];
    Nombre=[Nombre,manipCat200320.npart(i)];
    MasseBbg=[MasseBbg,0];
    Projet=[Projet;'Vortex'];
    Set=[Set;manipCat200320.set{i}];
    TauP=[TauP,manipCat200320.taup(i)];
    Video=[Video;manipCat200320.video{i}];
    CoefMarangoni=[CoefMarangoni,manipCat200320.A(i)];
    Inertie=[Inertie,manipCat200320.inertie(i)];
    AmpVortex=[AmpVortex,manipCat200320.amp_ec(i)];
    Advection=[Advection,manipCat200320.advection(i)];
    AmpSourceCamphre=[AmpSourceCamphre,manipCat200320.asrc(i)];
    RandomStart=[RandomStart,manipCat200320.randomstart(i)];
end
save('E:\Clément\MyCore\Analyse\SimuNum\manips.mat','Nombre','AmpVortex','CoefMarangoni','TauP','Date','Set','Duree','Rayon','MasseBbg','Projet','Video','Inertie','Advection','AmpSourceCamphre')
