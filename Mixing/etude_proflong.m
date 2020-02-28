%% Extrait des profils moyens la maximum, sa position... Afin de les comparer entre eux

    
    load(strcat(directoryAnalyse,'long_profil'));
    [valmax,posmax]=max(proflong);
   
    save(strcat(directoryAnalyse,'etude_prof.mat'),'valmax','posmax')

