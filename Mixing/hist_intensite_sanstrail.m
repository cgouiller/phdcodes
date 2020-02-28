%% Calcule l'histogramme des valeurs de Cfield, ou de ses gradients en enlevant les zones de déplétion

clear all;
run manips180329;
param='500 images, a signifie gradient de Cfield. x et y pour chaque direction. les variables commencant par x sont les abcisses associe a chaque';
    


derrieregauchey=[0;28;334;442;376;343;503;597;617;654;758];
derrieregauchex=[0;590;597;607;541;605;571;586;746;799;817];
devantdroitey=[0;997;1004;994;1043;1025;1072;1069;1017;966;1001];
devantdroitex=[0;1587;1303;1199;1214;1150;1233;1155;1037;999;996];
distdevant=round((devantdroitey-895)*calib);
distderriere=round((895-derrieregauchey)*calib);
distdroite=round((895-derrieregauchex)*calib);
distgauche=round((devantdroitex-895)*calib);

countsax=zeros(11,200);
countstdax=zeros(11,200);
countsay=zeros(11,200);
countstday=zeros(11,200);
countscf=zeros(11,200);
countstdcf=zeros(11,200);

for numVid=2:11
    numVid
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,set,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    load(strcat(directoryAnalyse,'trailtest'));
    tracks(:,12)=-tracks(:,12);
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
    countx=zeros(500,200);
    county=zeros(500,200);
    countcf=zeros(500,200);

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
        
        y=1:1789;
        liste=tracks(tracks(:,3)==i+startCatalogue(numVid)*fps,:);
        for k=1:length(liste(:,1))        
            xv=[liste(k,1)+distdevant(numVid)*cos(liste(k,12))-distgauche(numVid)*sin(liste(k,12)),liste(k,1)+distdevant(numVid)*cos(liste(k,12))+distdroite(numVid)*sin(liste(k,12)),liste(k,1)-distderriere(numVid)*cos(liste(k,12))+distdroite(numVid)*sin(liste(k,12)),liste(k,1)-distderriere(numVid)*cos(liste(k,12))-distgauche(numVid)*sin(liste(k,12))]/calib;
            yv=[liste(k,2)+distgauche(numVid)*cos(liste(k,12))+distdevant(numVid)*sin(liste(k,12)),liste(k,2)+distdevant(numVid)*sin(liste(k,12))-distdroite(numVid)*cos(liste(k,12)),liste(k,2)-distdroite(numVid)*cos(liste(k,12))-distderriere(numVid)*sin(liste(k,12)),liste(k,2)+distgauche(numVid)*cos(liste(k,12))-distderriere(numVid)*sin(liste(k,12))]/calib;
%                   hold on;
%                   plot(liste(k,1)/calib,liste(k,2)/calib,'og')
%                   plot([xv,xv(1)],[yv,yv(1)],'r')
%                   hold off;

                    for iii=1:1789
                        x=iii*ones(1,1789);
                        in = inpolygon(x,y,xv,yv);
                        xin=x(in);
                        yin=y(in);
                        for jj=1:length(xin)
                            Cfield(yin(jj),xin(jj))=NaN;
                        end
                        
                    end

        end   
            
        Cfieldsave=Cfield;
        Cfield=(Cfield-nanmean(nanmean(Cfield)))/nanmean(nanmean(Cfield));
   
    
  
   
   
   
   
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [ax,ay]=imgradientxy(Cfieldsave);
    ax=(ax-nanmean(nanmean(ax)))/nanmean(nanmean(ax));
    ay=(ay-nanmean(nanmean(ay)))/nanmean(nanmean(ay));
    %figure;
    [countx(cpt,:),xcountx]=hist_maison(ax(isnan(ax)==0),-2,2,200,0); %function [counts,bins] = hist_maison(image,inf,sup,nbbins,norm)
    [county(cpt,:),xcounty]=hist_maison(ay(isnan(ay)==0),-2,2,200,0);
    [countcf(cpt,:),xcountcf]=hist_maison(Cfield(isnan(Cfield)==0),-0.5,1,200,0);
     
    
  end

countsax(numVid,:)=sum(countx);
countsax(numVid,:)=countsax(numVid,:)/sum(countsax(numVid,:));
%countstdax(numVid,:)=std(countx);

countsay(numVid,:)=sum(county);
countsay(numVid,:)=countsay(numVid,:)/sum(countsay(numVid,:));
%countstday(numVid,:)=std(county);

countscf(numVid,:)=sum(countcf);
countscf(numVid,:)=countscf(numVid,:)/sum(countscf(numVid,:));
%countstdcf(numVid,:)=std(count);
save(strcat(directoryAnalyse,'histog_norm_sans trail.mat'),'xcountx','xcounty','xcountcf','countscf','countsax','countsay','param')

end







countsax=zeros(11,200);
countstdax=zeros(11,200);
countsay=zeros(11,200);
countstday=zeros(11,200);
countscf=zeros(11,200);
countstdcf=zeros(11,200);

for numVid=2:11
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    directoryVid=strcat(basePathVid,date,set,video,'\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video,'\');
    load(strcat(directoryAnalyse,'trailtest'));
    tracks(:,12)=-tracks(:,12);
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
    countx=zeros(500,200);
    county=zeros(500,200);
    countcf=zeros(500,200);

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
        Cfieldsave=Cfield;
        Cfield=(Cfield-nanmean(nanmean(Cfield)))/nanmean(nanmean(Cfield));
   
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [ax,ay]=imgradientxy(Cfieldsave);
    ax=(ax-nanmean(nanmean(ax)))/nanmean(nanmean(ax));
    ay=(ay-nanmean(nanmean(ay)))/nanmean(nanmean(ay));
    %figure;
    [countx(cpt,:),xcountx]=hist_maison(ax(isnan(ax)==0),-2,2,200,0); %function [counts,bins] = hist_maison(image,inf,sup,nbbins,norm)
    [county(cpt,:),xcounty]=hist_maison(ay(isnan(ay)==0),-2,2,200,0);
    [countcf(cpt,:),xcountcf]=hist_maison(Cfield(isnan(Cfield)==0),-0.5,1,200,0);
     
    
  end

countsax(numVid,:)=sum(countx);
countsax(numVid,:)=countsax(numVid,:)/sum(countsax(numVid,:));
%countstdax(numVid,:)=std(countx);

countsay(numVid,:)=sum(county);
countsay(numVid,:)=countsay(numVid,:)/sum(countsay(numVid,:));
%countstday(numVid,:)=std(county);

countscf(numVid,:)=sum(countcf);
countscf(numVid,:)=countscf(numVid,:)/sum(countscf(numVid,:));
%countstdcf(numVid,:)=std(count);
save(strcat(directoryAnalyse,'histog_norm.mat'),'xcountx','xcounty','xcountcf','countscf','countsax','countsay','param')

end

