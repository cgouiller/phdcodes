clear all;

run('E:\Cl�ment\phdcodes\Multi\manips.m');
%%
for numVid=1:nombreVid
  
 
    load_param;
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
    
  % track_tmp; % Cr�ation de l'image de background (im0) et tracking de particules (sauvegard� dans positions.mat)
  %numVid
   %constr_traject;%Se servant des positions obtenues par track_particles en d�duit les trajectoires sauvegard�es dans trajectories.mat
  %   filtrage_traj;%Regarde dans trajectories.mat quelles particules sont assez �loign�es des bords ainsi que des autres
traj_plot;
end

