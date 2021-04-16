clear all;

run('E:\Clément\phdcodes\Multi\manips.m');
for numVid=[71,72,73,86,67,69,70,87,83,84,85,88,74,78,79,89,80,81,82,90,55,56,57,91,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120]+1
%for numVid=97
 %numVid
    load_param;
   % changes(numVid)=1;
%    track_tmp2;
%     load(strcat(directoryAnalyse,'\','trajectories.mat'))
%     hold on;
%     plot(numVid,max(tracks(:,4)),'+')
%     hold off;
%     if max(tracks(:,4))>1
%         numVid
%     end
%     load(strcat(directoryAnalyse,'\','positions.mat'))
%  xl2=[];
%  yl2=[];
%  tl2=[];
%     for k=1:length(c)
%             xl2=[xl2;c(k).x];
%             yl2=[yl2;c(k).y];
%             tl2=[tl2;c(k).t];
% 
%     end
%     xl=[];
% tl=[];
% lenxl=[];
%     for k=1:length(c)
%         lenxl=[lenxl,length(c(k).x)];
%             xl=[xl;c(k).x];
%             tl=[tl;c(k).t];
% 
%     end
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
%  filtre_pos;

  %numVid
%  constr_traject;%Se servant des positions obtenues par track_particles en déduit les trajectoires sauvegardées dans trajectories.mat
%traj_plot;
%msd_calc;
%msd_inf;
%msd_truetum;
%msd_tum;
%msd_cuve;
msd_bouts;
%msd_trueinf;
%center_analyze
end

