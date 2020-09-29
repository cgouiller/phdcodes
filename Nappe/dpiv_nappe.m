directoryPiv='E:\Clément\Nappe\essaispiv\49\';

    Lpiv=dir(strcat(directoryPiv,'*.tif'));
    global parload_pathname;
    estimator=1;
   index_header=6;
    % definition of the default parameters
    no_boxes_1_x = 60; no_boxes_1_y = 60;  box_size_1 = 24; window_1_x = 30; window_1_y = 30;
    no_boxes_2_x = 120; no_boxes_2_y = 120; box_size_2 = 8; window_2_x = 16; window_2_y = 16;
    mask = 0; calibration = 1; delta_t = 1; median_limit = 0.5; peak_ratio = 1.0;
    no_calculation = 1; gaussian_size = 0; direct_calculation = 0; stereo_splitting=0;image_split = 0; weighting = 0;
    
    
    
    index = 'tif';
    
    
    sav_index='mat';
    pathname_sav=directoryPiv;
    filename_sav='result';
    
    for field=1:length(Lpiv)/2
        image_filename_1(field)={strcat(directoryPiv,Lpiv(2*field-1).name)};
        image_filename_2(field)={strcat(directoryPiv,Lpiv(2*field).name)};
        sav_filename(field)={strcat(pathname_sav,num2str(field),'.',sav_index)};
    end
    pos = get(gcf,'Position');close;pause(.1)
    Automaticprocess_3;
    

        
    