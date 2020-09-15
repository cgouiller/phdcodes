Lpivbis=dir(strcat(directoryPiv,'*.mat'));
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

load(strcat(directoryPiv,Lpivbis(1).name))
%load(strcat(directoryPiv,'alea.mat'))
    U_tot=zeros(size(u));
    V_tot=zeros(size(v));
    countsu=zeros(size(u));
    countsv=zeros(size(v));
    stdcat=zeros(size(u));
    ucat=zeros(no_fields,length(u),length(u));
    vcat=zeros(no_fields,length(v),length(v));
    umpas=zeros(length(u),length(v));
    vmpas=zeros(length(u),length(v));
    pascount=zeros(length(u),length(v));
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
    Umoy=U_tot./countsu;
    Vmoy=-V_tot./countsv; %sinon c'est dans le mauvais sens...
    
    
    Umed=zeros(size(Umoy));
    Vmed=zeros(size(Vmoy));
    Uvar=zeros(size(Umoy));
    Vvar=zeros(size(Vmoy));
    for i=1:length(u)
        for j=1:length(v)
            ul=ucat(:,i,j);
            vl=vcat(:,i,j);
            Umed(i,j)=median(ul(ul~=0));
            Vmed(i,j)=-median(vl(vl~=0)); %idem, pour le bon sens
            Uvar=var(ul(ul~=0));
            Vvar=var(vl(vl~=0));
    
        end
    end
    %for kkk=1:10
        %incu=ucat(1+50*(kkk-1):50*kkk,:,:);
        incu=ucat;
        incu(incu==0)=NaN;
        %incv=vcat(1+50*(kkk-1):50*kkk,:,:);
        incv=vcat;
        incv(incv==0)=NaN;
        %umpas(kkk,:,:)=nanmean(incu);
        %vmpas(kkk,:,:)=nanmean(incv);
        umpas=nanmean(incu);
        umpas=reshape(umpas,[120,120]);
        vmpas=nanmean(incv);
        vmpas=reshape(vmpas,[120,120]);

        %pascount(kkk,:,:)=50-max(sum(isnan(incu),1),sum(isnan(incv),1));
        pascount=no_fields*ones(size(umpas))-reshape(max(sum(isnan(incu),1),sum(isnan(incv),1)),[120,120]);
   % end
    save(strcat(baseDir,'PIV_unpasparprof'),'x','y','Umoy','Vmoy','no_fields','countsu','countsv','Umed','Vmed','Uvar','Vvar','umpas','vmpas','pascount')
