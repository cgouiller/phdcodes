clear all;

run('E:\Clément\Mixing\Matlab\manipsfinales.m');
%%


list=32;
for i=1
    numVid=list(i);
  
 
    load_param;

    

    
   %track_particles; % Création de l'image de background (im0) et tracking de particules (sauvegardé dans positions.mat)
  
    %   corautournag;
   
   %  concentration; %Evolution des différents champs scalaires, obtenus à la fois par Beer-Lambert (ConcBL.mat) et par interpolation linéaire (Conclin.mat)
   %  constr_traject;%Se servant des positions obtenues par track_particles en déduit les trajectoires sauvegardées dans trajectories.mat
    % filtrage_traj;%Regarde dans trajectories.mat quelles particules sont assez éloignées des bords ainsi que des autres
   %  spectre; %Calcule avec pwelch le spectre moyen du champ de concentration réduit dans le carré, (C-CMoySq)/CstdSq
     % concmoyautournag; %Trace le champ de concentration moyen en bulles de verre autour des particules sélectionnees par le filtrage
    calc_profil; %Calcule le profil longitudinal moyen dans la direction de nage, proflong, sauvegardé dans long_profil.mat
    % aire_ellipse%Calcul l'aire de la zone de déplétion avec seuil à -0.5 sur (C-<C>)/<C>
%     etude_proflong%Trouve la valeur du max du profil et sa position
%     PDF_Cfield_et_grad;
%     calc_Rcc %Calcule S1, S2, S3 et S4
%     corRcc % Déduit Rcc de S2
%     hist_intensite %Calcule les histogrammes de (C-<C>)/<C> et des gradients de <C> normalisés par racine(grad_x^2+grad_y^2)
%     PIV_pretreatment_fullimg;
%     PIV_pretreatment;
%     PIV_treatment_mean
%     PIV_correlation;
    
    
end
%%
%  load(strcat(directoryAnalyse,'meanTrailc'));
%    
%     CMoyMT(numVid)=nanmean2(immoy(1200:1800,1200:1800));
%      CMoyMTtot(numVid)=nanmean2(immoy);
    %     directoryRomain=strcat('I:\Romain\',num2str(MCat(numVid)),'\');
%     mkdir(directoryRomain);
%     load(strcat(directoryAnalyse,'directory.mat'));
%     for k=round(linspace(1,length(L),50))
%         fname=L(k).name;
%     fnamecompl=strcat(directoryVid,fname);
%     im=double(imread(fnamecompl));
%     im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
%     imwrite(uint8(im),strcat(directoryRomain,fname),'tiff')
%     end
%     load(strcat(directoryAnalyse,'im0'));
%     save(strcat(directoryRomain,'im0'),'im0');
%     load(strcat(directoryAnalyse,'\PIV_mean.mat'));
%     Umoy(isnan(Umoy)==1)=0;
%         Vmoy(isnan(Vmoy)==1)=0;
% quiverC2D(X(1:2:215,1:2:165),Y(1:2:215,1:2:165),Umoy(1:2:215,1:2:165),Vmoy(1:2:215,1:2:165));axis equal
%     pause;
%     close;
%     [FX,FY]=gradient(Umoy);
%     FY(FY<-0.5)=-0.5;
% FY(FY>0.5)=0.5;
% FY=255*(FY+0.5);
% 
%    imwrite( uint8(FY), parula(256), strcat(directoryAnalyse,'\PIV_grady.png'))





%%

    
%     if exist(strcat(directoryAnalyse,'\PIV_mean.mat'))==2
%         load(strcat(directoryAnalyse,'\PIV_mean.mat'));
%         %dvg=divergence(X,Y,Umoy,Vmoy);
%         figure;imagesc(dvg,[-0.05 0.05]);
%         %save(strcat(directoryAnalyse,'\PIV_mean'),'X','Y','Umoy','Vmoy','countsu','countsv','dvg')
%     end

