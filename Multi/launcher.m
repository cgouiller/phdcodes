clear all;

run('E:\Cl�ment\phdcodes\Multi\manips.m');
%%
for numVid=16:20;
  
 
    load_param;

    
   track_particles; % Cr�ation de l'image de background (im0) et tracking de particules (sauvegard� dans positions.mat)
  
  %  constr_traject;%Se servant des positions obtenues par track_particles en d�duit les trajectoires sauvegard�es dans trajectories.mat
  %   filtrage_traj;%Regarde dans trajectories.mat quelles particules sont assez �loign�es des bords ainsi que des autres

end

