clear all;

run('E:\Clément\phdcodes\Multi\manips.m');
%%
for numVid=16:20;
  
 
    load_param;

    
   track_particles; % Création de l'image de background (im0) et tracking de particules (sauvegardé dans positions.mat)
  
  %  constr_traject;%Se servant des positions obtenues par track_particles en déduit les trajectoires sauvegardées dans trajectories.mat
  %   filtrage_traj;%Regarde dans trajectories.mat quelles particules sont assez éloignées des bords ainsi que des autres

end

