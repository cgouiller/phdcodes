
% ############################################### %
% Automaticdpiv_part4: Dimensional output to file %
% ############################################### %

%disp('Part 4: Save the results')


%%%%%%%%%%%%%%%%%%%%%
% save a .piv file
if sav_index =='piv'
%%%%%%%%%%%%%%%%%%%%%
                                
    fid=fopen(char(sav_filename(field)),'w');
 
    % save parameters
    fprintf(fid,'%5.1f %5.1f %5.1f %5.1f %5.1f \n',no_boxes_1_x,no_boxes_1_y,box_size_1,window_1_x,window_1_y); 
    fprintf(fid,'%5.1f %5.1f %5.1f %5.1f %5.1f \n',no_boxes_2_x,no_boxes_2_y,box_size_2,window_2_x,window_2_y);
    fprintf(fid,'%f %f %f %f %f \n',mask,calibration,delta_t,median_limit,peak_ratio);
    fprintf(fid,'%f %f %f %f %f \n',no_calculation,gaussian_size,direct_calculation,image_split,weighting);
 
    % save velocity field
	for j=1:no_boxes_2_x
        for i=1:no_boxes_2_y
            fprintf(fid,'%11.3e %11.3e %11.3e %11.3e\n',x_2(i,j),y_2(i,j),u_2(i,j),v_2(i,j));
        end;
    end;
 
    % save image height, width, name and type
    if (image_split==1)
       fprintf(fid,'%f \n',2*image_height);
    else
       fprintf(fid,'%f \n',image_height);
    end 
    fprintf(fid,'%f \n',image_width);
    fprintf(fid,'%f \n',index_header);
%    fprintf(fid,'%s \n',truncname(char(image_filename_1(field)),'\','','afterlast'));
    fprintf(fid,'%s \n',char(image_filename_1(field)));

    fclose(fid);
 

%%%%%%%%%%%%%%%%%%%%%
% save a .mat file
elseif sav_index=='mat'
%%%%%%%%%%%%%%%%%%%%%
                        
    x=x_2; % for file.mat
    y=y_2;
    u=u_2;
    v=v_2;
%    Image_filenam=truncname(char(image_filename_1(field)),'\','','afterlast');
    Image_filenam=char(image_filename_1(field));
    if (image_split==1)
       image_height=2*image_height;
       save (strcat(char(sav_filename(field)),'_bis'),'no_boxes_1_x','no_boxes_1_y','box_size_1','window_1_x','window_1_y',...
                                       'no_boxes_2_x','no_boxes_2_y','box_size_2','window_2_x','window_2_y',...
                                       'mask','calibration','delta_t','median_limit','peak_ratio',...
                                       'no_calculation','gaussian_size','direct_calculation','stereo_splitting','weighting',...
                                       'x','y','u','v','2*image_height','image_width','index_header','Image_filenam');
     else
        save (strcat(char(sav_filename(field))),'no_boxes_1_x','no_boxes_1_y','box_size_1','window_1_x','window_1_y',...
                               'no_boxes_2_x','no_boxes_2_y','box_size_2','window_2_x','window_2_y',...
                               'mask','calibration','delta_t','median_limit','peak_ratio',...
                               'no_calculation','gaussian_size','direct_calculation','image_split','weighting',...
                               'x','y','u','v','image_height','image_width','index_header','Image_filenam');
     end 
     
     
end     % end if save .mat or .piv
      

 
 
 
% if field==no_fields
    % disp('End of automatic calculation');
     %DPIVsoft; 
% end