
    Lpiv=dir(strcat(directoryPiv,'*.tif'));
    global parload_pathname;
    estimator=1;
   index_header=6;
    % definition of the default parameters
    no_boxes_1_x = 30; no_boxes_1_y = 30;  box_size_1 = 32; window_1_x = 28; window_1_y = 28;
    no_boxes_2_x = 60; no_boxes_2_y = 60; box_size_2 = 32; window_2_x = 20; window_2_y = 20;
    mask = 0; calibration = 1; delta_t = 1; median_limit = 0.5; peak_ratio = 1.0;
    no_calculation = 1; gaussian_size = 0; direct_calculation = 0; stereo_splitting=0;image_split = 0; weighting = 0;
    
    
    
    index = 'tif';
    
    
    sav_index='mat';
    pathname_sav=directoryPiv;
    filename_sav='result';
    if length(Lpiv)~=1000
        numVid
    end
    clear image_filename
    for field=1:length(Lpiv)/2
        image_filename(field)={strcat(Lpiv(2*field-1).name)};
    end
    save(strcat(directoryPiv,'im_champ_corresp.mat'),'image_filename');
    