Lpivbis=dir(strcat(directoryPiv3,'*.mat'));
    Lpiv=dir(strcat(directoryPiv,'*.tif'));

    index = 'tif';
    
    
    sav_index='mat';
    pathname_sav=directoryPiv3;
    filename_sav='result';
    
    for field=1:length(Lpiv)/2
        image_filename_1(field)={strcat(directoryPiv,Lpiv(2*field-1).name)};
        image_filename_2(field)={strcat(directoryPiv,Lpiv(2*field).name)};
        sav_filename(field)={strcat(pathname_sav,num2str(field),'.',sav_index)};
    end

load(strcat(directoryPiv3,Lpivbis(1).name))
%load(strcat(directoryPiv,'alea.mat'))
    U_tot=zeros(size(u));
    V_tot=zeros(size(v));
    countsu=zeros(size(u));
    countsv=zeros(size(v));
    stdcat=zeros(size(u));
    ucat=zeros(length(Lpiv)/2,length(u),length(u));
    vcat=zeros(length(Lpiv)/2,length(v),length(v));
    umpas=zeros(10,length(u),length(v));
    vmpas=zeros(10,length(u),length(v));
    pascount=zeros(10,length(u),length(v));
    
    kg=fspecial('gaussian',[10 10],6);

    for field=1:length(Lpiv)/2
        
        load(strcat(sav_filename{field}(1:end-4),'.mat'));
        
        im=imread(image_filename_1{field});
        im2=imread(image_filename_2{field});
        imf=imfilter(im,kg);
        imf2=imfilter(im2,kg);

        mask=imf<250 & imf2<250 & imf>30 & imf2>30;
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
%         
    end
    Umoy=U_tot./countsu;
    Vmoy=-V_tot./countsv; %sinon c'est dans le mauvais sens...
    %Umoy(countsu<20)=0;
    %Vmoy(countsv<20)=0;
    
    Umed=zeros(size(Umoy));
    Vmed=zeros(size(Vmoy));
    Uvar=zeros(size(Umoy));
    Vvar=zeros(size(Vmoy));
    for i=1:length(u)
        for j=1:length(v)
            ul=ucat(:,i,j);
            vl=vcat(:,i,j);
            Umed(i,j)=median(ul(ul~=0));
            Vmed(i,j)=-median(vl(vl~=0));
            Uvar=var(ul(ul~=0));
            Vvar=var(vl(vl~=0));
    
        end
    end

    save(strcat(directoryPiv3,'PIV_mean_mask'),'x','y','Umoy','Vmoy','countsu','countsv','Umed','Vmed','Uvar','Vvar')
