
    Lpiv=dir(strcat(directoryPiv,'*.tif'));
  
    
    

    index = 'tif';
    
    
    sav_index='mat';
    pathname_sav=directoryPiv;
    filename_sav='result';
    
    for field=1:length(Lpiv)/2
        image_filename_1(field)={strcat(directoryPiv,Lpiv(2*field-1).name)};
        image_filename_2(field)={strcat(directoryPiv,Lpiv(2*field).name)};
        sav_filename(field)={strcat(pathname_sav,num2str(field),'.',sav_index)};
    end
    
            load(sav_filename{1});


    U_tot=zeros(size(u));
    V_tot=zeros(size(v));
    countsu=zeros(size(u));
    countsv=zeros(size(v));
    stdcat=zeros(size(u));
    ucat=zeros(no_fields,length(u),length(u));
    vcat=zeros(no_fields,length(v),length(v));
    umpas=zeros(10,length(u),length(v));
    vmpas=zeros(10,length(u),length(v));
    pascount=zeros(10,length(u),length(v));
    for field=1:no_fields
        
        load(strcat(sav_filename{field}(1:end-4),'.mat'));
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
        ucat(field,:,:)=u;
        vcat(field,:,:)=v;
        U_tot=U_tot+u;
        V_tot=V_tot+v;
        u(u==0)=NaN;
        v(v==0)=NaN;
        countsu=countsu+(ones(size(u))-isnan(u));
        countsv=countsv+(ones(size(v))-isnan(v));
        
    end
    u=U_tot./countsu;
    v=-V_tot./countsv; %sinon c'est dans le mauvais sens...
    

    save(strcat(baseDir,'PIV_mean'),'x','y','u','v')
