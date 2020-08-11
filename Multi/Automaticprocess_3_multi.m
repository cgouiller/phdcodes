% ################################################################ %
% Automaticprocess_3 : makes the calculation %
% ################################################################ %

ImageVisu=0;   % means that no figure will be shown
% answer=inputdlg('Duration of the pause   [in hours]','Pause :',1,{'0'});
% pause(str2num(char(answer))*3600);
% pause(0.1);

   dispstat('','init'); % One time only initialization
dispstat(sprintf('Begining the Piv calculation...'),'keepthis','timestamp');
for field=1:length(Lpiv)/2
   
          dispstat(sprintf('Progress video %d%%',round(field/length(Lpiv)/2*100)),'timestamp');

   %message=strcat('Velocity field number ','_',num2str(field),':',char(image_filename_1(field)));
   %disp(message);
   %disp('Part 3: Calculation');
   
   
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %reading of the first image
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
     if index_header~=1
         
        image_1 = double(imread(char(image_filename_1(field)),index)); 
        image_width = size(image_1,2);
        image_height = size(image_1,1);
        
     else
         
        image_height=raw_image_height(field);
        image_width=raw_image_width(field);
        fid = fopen(char(image_filename_1(field)),'r'); 
        header = fread(fid,[1,raw_image_header_1(field)],'uint8');
        image_1 = fread(fid,[image_width image_height],'uint8');
        image_1 = image_1';
        fclose(fid);
        
     end   %end if 
         
     % stereo-splitting of the image
           if stereo_splitting~=0 & mod(field,2)==1;
               image_1=image_1(:,1:floor(image_width/2));
               image_width=floor(image_width/2);
           elseif stereo_splitting~=0 & mod(field,2)==0;
               image_1=image_1(:,image_width-floor(image_width/2)+1:image_width);
               image_width=floor(image_width/2);
           end;
  
        
     
      
      
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %reading of the second image
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  if image_split==0
      
         if index_header~=1
             
            image_2 = double(imread(char(image_filename_2(field)),index)); 
            image_width = size(image_2,2);
            image_height = size(image_2,1);
            
         else
            fid = fopen(char(image_filename_2(field)),'r'); 
            header = fread(fid,[1,raw_image_header_2(field)],'uint8');
            image_2 = fread(fid,[image_width image_height],'uint8');
            image_2 = image_2';
            fclose(fid);
         end   %end if 
   end     %end  if image_split==0
  
 
   % stereo-splitting of the image
           if stereo_splitting~=0 & mod(field,2)==1;
               image_2=image_2(:,1:floor(image_width/2));
               image_width=floor(image_width/2);
           elseif stereo_splitting~=0 & mod(field,2)==0;
               image_2=image_2(:,image_width-floor(image_width/2)+1:image_width);
               image_width=floor(image_width/2);
           end;

      % splitting of the image
   if image_split==1 
      image_height = round((image_height-1)/2);
      total_image=image_1;
      image_1=zeros(image_height,image_width);
      for j = 1:image_height
          image_1(j,:)=total_image(2*j-1,:);
          image_2(j,:)=total_image(2*j,:);
      end   %end for 
      
   end  %end if
   

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % load the mask images
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if mask==1
        ImageMask_filename_1 = strcat(truncname(char(image_filename_1(field)),'','.','beforelast'),'_mask.',truncname(char(image_filename_1(field)),'','.','afterlast'));
        image_index=truncname(char(image_filename_1(field)),'','.','afterlast');
        image_mask_1 = max(0,sign(double(imread(ImageMask_filename_1,image_index))-127)); 
        ImageMask_filename_2 = strcat(truncname(char(image_filename_2(field)),'','.','beforelast'),'_mask.',truncname(char(image_filename_2(field)),'','.','afterlast'));
        image_mask_2 = max(0,sign(double(imread(ImageMask_filename_2,image_index))-127)); 
    else;
        image_mask_1=[];image_mask_2=[];
    end;
   
   
   
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %        first run, first iteration (no deformation)
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if direct_calculation ~= 1            
           
    [x_1,y_1,u_1,v_1]=calculationFFT1(image_1,image_2,no_boxes_1_x,no_boxes_1_y,box_size_1,window_1_x,window_1_y, ...
          no_boxes_2_x,no_boxes_2_y,box_size_2,window_2_x,window_2_y,mask,calibration,delta_t,median_limit, ... 
          peak_ratio,no_calculation,gaussian_size,direct_calculation,image_split,weighting,ImageVisu,image_mask_1,image_mask_2) ;    
else
     [x_1,y_1,u_1,v_1]=calculationDirect1(image_1,image_2,no_boxes_1_x,no_boxes_1_y,box_size_1,window_1_x,window_1_y, ...
          no_boxes_2_x,no_boxes_2_y,box_size_2,window_2_x,window_2_y,mask,calibration,delta_t,median_limit, ...
          peak_ratio,no_calculation,gaussian_size,direct_calculation,image_split,weighting) ;   
end;



     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %        first run, other iterations (with deformation)
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if no_calculation >= 2
       [x_1,y_1,u_1,v_1]=calculationFFT1bis(image_1,image_2,no_boxes_1_x,no_boxes_1_y,box_size_1,window_1_x,window_1_y, ...
          no_boxes_2_x,no_boxes_2_y,box_size_2,window_2_x,window_2_y,mask,calibration,delta_t,median_limit, ...
          peak_ratio,no_calculation,gaussian_size,direct_calculation,image_split,weighting,x_1,y_1,u_1,v_1,ImageVisu,image_mask_1,image_mask_2);     
end

[u_1 v_1 err_vect] = Med_fil(u_1,v_1,median_limit);



     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %        second run (with deformation)
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
noise2peak=0;
[x_2,y_2,u_2,v_2,du_dx,du_dy,dv_dx,dv_dy]=calculationFFT2(image_1,image_2,no_boxes_1_x,no_boxes_1_y,box_size_1,window_1_x,window_1_y, ...
          no_boxes_2_x,no_boxes_2_y,box_size_2,window_2_x,window_2_y,mask,calibration,delta_t,median_limit, ...
          peak_ratio,no_calculation,gaussian_size,direct_calculation,image_split,weighting,x_1,y_1,u_1,v_1,noise2peak,ImageVisu,image_mask_1,image_mask_2);     

y_2=image_height-y_2;
v_2=-v_2;
%   The result is : +u_2(x_2,y_2)  and  +v_2(x_2,y_2)

% in case of splitted image, correction of the vertical velocity
if (image_split==1)
    y_2=y_2*2;
	v_2=(v_2-.5)*2;
end;

[u_2 v_2 err_vect] = Med_fil(u_2,v_2,median_limit);


     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %        save field
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Automaticprocess_4_multi;   



end         %end of  for field=...



