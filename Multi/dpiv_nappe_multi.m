
    Lpiv=dir(strcat(directoryPiv,'*.tif'));
    global parload_pathname;
    estimator=1;
   index_header=6;
    % definition of the default parameters (piv2)
%     no_boxes_1_x = 30; no_boxes_1_y = 30;  box_size_1 = 32; window_1_x = 20; window_1_y = 20;
%     no_boxes_2_x = 100; no_boxes_2_y = 100; box_size_2 = 10; window_2_x = 20; window_2_y = 20;

% piv3
     no_boxes_1_x = 24; no_boxes_1_y = 24;  box_size_1 = 64; window_1_x = 50; window_1_y = 50;
     no_boxes_2_x = 128; no_boxes_2_y = 128; box_size_2 = 16; window_2_x = 30; window_2_y = 30;

    mask = 0; calibration = 1; delta_t = 1; median_limit = 0.5; peak_ratio = 1.0;
    no_calculation = 1; gaussian_size = 0; direct_calculation = 0; stereo_splitting=0;image_split = 0; weighting = 0;
    
    
    
    index = 'tif';
    
    
    sav_index='mat';
    pathname_sav=directoryPiv3;
    filename_sav='result';
    
    for field=1:length(Lpiv)/2
        image_filename_1(field)={strcat(directoryPiv,Lpiv(2*field-1).name)};
        image_filename_2(field)={strcat(directoryPiv,Lpiv(2*field).name)};
        sav_filename(field)={strcat(pathname_sav,num2str(field),'.',sav_index)};
    end
    pos = get(gcf,'Position');close;pause(.1)
    Automaticprocess_3_multi;
    

        
    