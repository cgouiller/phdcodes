clear all;

run('E:\Clément\phdcodes\Multi\manips.m');
%%
for numVid=51:nombreVid
  
 numVid
    load_param;
    %R_range
%     load(strcat(directoryAnalyse,'directory.mat'));
% k=startImg;
% fname=L(k).name;
%     fnamecompl=strcat(directoryVid,fname);
%     im=double(imread(fnamecompl));
%     imagesc(im>250);title(strcat(num2str(R_range(1)),'\t',num2str(R_range(2))));pause;
  %load(strcat(directoryAnalyse,'positions.mat'))
 % filtre_pos;
%  for i=1:length(c)
%      c(i).x=c(i).x/calib;
%      c(i).y=c(i).y/calib;
%      c(i).r=c(i).r/calib;
%  end
%  save(strcat(directoryAnalyse,'\','positions.mat'),'c')

% l=[];
% 
% for i=startImg:length(c)
%     l(i)=length(c(i).x);
% end
% figure;
% plot(startImg:length(c),l(startImg:length(c)));title(num2str(numVid))
    
 % track_particles; % Création de l'image de background (im0) et tracking de particules (sauvegardé dans positions.mat)
 % filtre_pos;
  %numVid
   %constr_traject;%Se servant des positions obtenues par track_particles en déduit les trajectoires sauvegardées dans trajectories.mat
  %   filtrage_traj;%Regarde dans trajectories.mat quelles particules sont assez éloignées des bords ainsi que des autres
%traj_plot;
%msd_calc;
center_analyze
end

