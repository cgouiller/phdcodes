directoryPiv='E:\Clément\Nappe\essaispiv\17\';
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

ucat=zeros(no_fields,length(u),length(u));
vcat=zeros(no_fields,length(v),length(v));
normvitcat=zeros(no_fields,length(v),length(v));
deplcat=zeros(no_fields,length(v),length(v));

ns=[100,10,12,15,1,20,2,30,3,40,50,5,75,7];
for field=1:length(sav_filename)
    load(strcat(sav_filename{field}(1:end-4),'.mat'));
    im=imread(image_filename_1{field});
    im2=imread(image_filename_2{field});
    image_filename_2{field}
    imf=imfilter(im,kg);
    imf2=imfilter(im2,kg);
    if numProf{numVid}>44
        mask=imf<75 & imf2<75 & imf>20 & imf2>20;
    else
        mask=imf<75 & imf2<75 & imf>12 & imf2>12;
    end
    for ii=1:length(x)
        for jj=1:length(y)
            if mask(x(1,ii),y(end+1-jj,1))==0
                u(ii,jj)=NaN;
                v(ii,jj)=NaN;
            end
        end
    end
    ucat(field,:,:)=u;
    vcat(field,:,:)=-v;
    normvitcat(field,:,:)=sqrt((reshape(ucat(field,:,:),[120,120])/ns(field)/8.09*fps).^2+(reshape(vcat(field,:,:),[120,120])/ns(field)/8.09*fps).^2);
    deplcat(field,:,:)=sqrt((reshape(ucat(field,:,:),[120,120])).^2+(reshape(vcat(field,:,:),[120,120])).^2);
end
figure;
for field=1:length(sav_filename)
[counts,bins]=hist_maison(reshape(normvitcat(field,:,:),[120,120]),0,max(max(max(normvitcat(isnan(normvitcat)==0)))),100,1);
    hold on;
color_line(bins,counts,ns(field)*ones(1,length(counts)),'LineWidth',2);
hold off;

end
title('Vitesse [mm/s]')
figure;
for field=1:length(sav_filename)
[counts,bins]=hist_maison(reshape(deplcat(field,:,:),[120,120]),0,max(max(max(deplcat(isnan(deplcat)==0)))),100,1);
    hold on;
color_line(bins,counts,ns(field)*ones(1,length(counts)),'LineWidth',2);
hold off;

end
title('Déplacement [px]')

close all
field=4;figure;quiverC2Dfixborn(x,y,reshape(ucat(field,:,:),[120,120])/ns(field)/8.09*fps,reshape(vcat(field,:,:),[120,120])/ns(field)/8.09*fps,1.5);title(num2str(ns(field)))
field=10;figure;quiverC2Dfixborn(x,y,reshape(ucat(field,:,:),[120,120])/ns(field)/8.09*fps,reshape(vcat(field,:,:),[120,120])/ns(field)/8.09*fps,1.5);title(num2str(ns(field)))
field=3;figure;quiverC2Dfixborn(x,y,reshape(ucat(field,:,:),[120,120])/ns(field)/8.09*fps,reshape(vcat(field,:,:),[120,120])/ns(field)/8.09*fps,1.5);title(num2str(ns(field)))



