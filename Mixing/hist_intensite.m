%% Calcule l'histogramme des valeurs de Cfield, ou de ses gradients.
clear all;
run manips180329;
param='500 images, a signifie gradient de Cfield. x et y pour chaque direction. les variables commencant par x sont les abcisses associe a chaque';
countsax=zeros(11,100);
countstdax=zeros(11,100);
countsay=zeros(11,100);
countstday=zeros(11,100);
for numVid=2:11
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,set,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    
    
    %list the processed images/Cfield
    L=dir(strcat(directoryVid,'*.tif'));
    numberFrame=length(L)-startImgCatalogue(numVid)-startCatalogue(numVid)*fps;
    
    centerCellX=centerCellXCat(numVid)+radiusCellPx;
    centerCellY=centerCellYCat(numVid)+radiusCellPx;
    
    centerCellXBg=centerCellXBgCat(numVid)+radiusCellPx;
    centerCellYBg=centerCellYBgCat(numVid)+radiusCellPx;
    
    radiusCellPxBg=radiusCellPx;
    
    shiftX=(centerCellX-centerCellXBg);
    shiftY=(centerCellY-centerCellYBg);
    a=load(strcat(directoryAnalyse,num2str(video),'_positions.mat'));
    c=a.c;
    
    imbg=load(strcat(directoryAnalyse,'imbg'));
    imbg=imbg.im0;
    countx=zeros(500,100);
    county=zeros(500,100);
    cpt=0;
    for i=round(linspace(1,numberFrame,500))
        cpt=cpt+1;
        fname=L(i+startImgCatalogue(numVid)+startCatalogue(numVid)*fps).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
        
        pos=[];
        pos=[c(i+startCatalogue(numVid)*fps).x,c(i+startCatalogue(numVid)*fps).y,c(i+startCatalogue(numVid)*fps).r];
        pos=pos/calib;
        Cfield=calc_Cfield(im,imbg,pos);
        [ax,ay]=imgradientxy(Cfield);
        %figure;
        [countx(cpt,:),xcountx]=imhist(ax(isnan(ax)==0),100);
        [county(cpt,:),xcounty]=imhist(ay(isnan(ay)==0),100);
        
%        plot(x,counts./sum(counts))
        if mod(cpt,100)==0
            numVid
            cpt
        end
        
    end
    countx=countx./(sum(countx(1,:)));
    countsax(numVid,:)=mean(countx);
    countstdax(numVid,:)=std(countx);
     county=county./(sum(county(1,:)));
    countsay(numVid,:)=mean(county);
    countstday(numVid,:)=std(county);
    
end



countscfx=zeros(11,100);
countstdcfx=zeros(11,100);
countscfy=zeros(11,100);
countstdcfy=zeros(11,100);
for numVid=2:11
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,set,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    
    
    %list the processed images/Cfield
    L=dir(strcat(directoryVid,'*.tif'));
    numberFrame=length(L)-startImgCatalogue(numVid)-startCatalogue(numVid)*fps;
    
    centerCellX=centerCellXCat(numVid)+radiusCellPx;
    centerCellY=centerCellYCat(numVid)+radiusCellPx;
    
    centerCellXBg=centerCellXBgCat(numVid)+radiusCellPx;
    centerCellYBg=centerCellYBgCat(numVid)+radiusCellPx;
    
    radiusCellPxBg=radiusCellPx;
    
    shiftX=(centerCellX-centerCellXBg);
    shiftY=(centerCellY-centerCellYBg);
    a=load(strcat(directoryAnalyse,num2str(video),'_positions.mat'));
    c=a.c;
    
    imbg=load(strcat(directoryAnalyse,'imbg'));
    imbg=imbg.im0;
    count=zeros(500,100);
    
    cpt=0;
    for i=round(linspace(1,numberFrame,500))
        cpt=cpt+1;
        fname=L(i+startImgCatalogue(numVid)+startCatalogue(numVid)*fps).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        im=im(round(centerCellY-radiusCellPx):round(centerCellY+radiusCellPx),round(centerCellX-radiusCellPx):round(centerCellX+radiusCellPx));
        
        pos=[];
        pos=[c(i+startCatalogue(numVid)*fps).x,c(i+startCatalogue(numVid)*fps).y,c(i+startCatalogue(numVid)*fps).r];
        pos=pos/calib;
        Cfield=calc_Cfield(im,imbg,pos);
        
        %figure;
        [count(cpt,:),xcountcf]=imhist(Cfield(isnan(Cfield)==0),100);
        
%        plot(x,counts./sum(counts))
        if mod(cpt,100)==0
            numVid
            cpt
        end
        
    end
    count=count./(sum(count(1,:)));

    countscf(numVid,:)=mean(count);
    countstdcf(numVid,:)=std(count);
    
end
save('E:\Laurent\Mixing\Analyse\180329\varNumber_large\essais\histog.mat','xcountx','xcounty','xcountcf','countscf','countstdcf','countsax','countsay','countstdax','countstday','param')


%legend(videoCatalogue(2:11));
%title('Gradients')


% for numVid=2:11
%     video=strjoin(videoCatalogue(numVid));
%     set=strjoin(setCatalogue(numVid));
%     directoryVid=strcat(basePathVid,date,set,video,'\');
% directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
%
%
% list the processed images/Cfield
% L=dir(strcat(directoryVid,'*.tif'));
%     numberFrame=length(L)-startImgCatalogue(numVid);
%
%     centerCellX=centerCellXCat(numVid)+radiusCellPx;
%     centerCellY=centerCellYCat(numVid)+radiusCellPx;
%
%     centerCellXBg=centerCellXBgCat(numVid)+radiusCellPx;
%     centerCellYBg=centerCellYBgCat(numVid)+radiusCellPx;
%
%     radiusCellPxBg=radiusCellPx;
%
%     shiftX=(centerCellX-centerCellXBg);
%     shiftY=(centerCellY-centerCellYBg);
% a=load(strcat(directoryAnalyse,num2str(video),'_positions.mat'));
% c=a.c;
%
% imbg=load(strcat(directoryAnalyse,'imbg'));
% imbg=imbg.im0;
%     fname=L(startCatalogue(numVid)*fps+startImgCatalogue(numVid)+500).name;
%     fnamecompl=strcat(directoryVid,fname);
%     im=double(imread(fnamecompl));
%     im=im(round(centerCellYBg-radiusCellPxBg):round(centerCellYBg+radiusCellPxBg),round(centerCellXBg-radiusCellPxBg):round(centerCellXBg+radiusCellPxBg));
%
%     pos=[];
%     pos=[c(startCatalogue(numVid)*fps+500).x,c(startCatalogue(numVid)*fps+500).y,c(startCatalogue(numVid)*fps+500).r];
%     pos=pos/calib;
%     Cfield=calc_Cfield(im,imbg,pos);
%     a=imgradient(Cfield);
%     figure;
%     imhist(a);
%     title(num2str(N(numVid)))
% end