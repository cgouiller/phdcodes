
    U_tot=zeros(size(u));
    V_tot=zeros(size(v));
    countsu=zeros(size(u));
    countsv=zeros(size(v));
    
    for field=1:no_fields
        
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
        U_tot=U_tot+u;
        V_tot=V_tot+v;
        u(u==0)=NaN;
        v(v==0)=NaN;
        countsu=countsu+(ones(size(u))-isnan(u));
        countsv=countsv+(ones(size(v))-isnan(v));
        
    end
    U=U_tot./countsu;
    V=-V_tot./countsv; %sinon c'est dans le mauvais sens...
    save(strcat(baseDir,'PIV_mean'),'x','y','U','V','countsu','countsv','no_fields','alea')
