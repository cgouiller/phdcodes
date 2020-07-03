    Lpiv=dir(strcat(directoryPiv,'*.tif'));

    index = 'tif';
    no_fields=500;
    
    sav_index='mat';
    pathname_sav=directoryPiv;
    filename_sav='result';
    
    for field=1:length(Lpiv)/2
        image_filename_1(field)={strcat(directoryPiv,Lpiv(2*field-1).name)};
        image_filename_2(field)={strcat(directoryPiv,Lpiv(2*field).name)};
        sav_filename(field)={strcat(pathname_sav,num2str(field),'.',sav_index)};
    end 

for field=1:length(Lpiv)/2
        
        load(sav_filename{field});
        im=imread(image_filename_1{field});
        im2=imread(image_filename_2{field});
        imf=imfilter(im,kg);
        imf2=imfilter(im2,kg);

        mask=imf<75 & imf2<75 & imf>12 & imf2>12;
        for ii=1:length(x)
            for jj=1:length(y)
                if mask(x(1,ii),y(end+1-jj,1))==0
                    u(ii,jj)=0;
                    v(ii,jj)=0;
                end
            end
        end
       
       save(strcat(sav_filename{field}(1:end-4),'_mask.mat'),'x','y','u','v') 
end