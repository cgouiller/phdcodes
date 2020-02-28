%% Compare la luminosité du panneau LED, utilisé quand il y avait des problèmes.
bgc=zeros(11,201);
noc=zeros(11,1000);
x=1:201;
for numVid=2:11
    %determine the current video/set/parameters
    video=strjoin(videoCatalogue(numVid));
    set=strjoin(setCatalogue(numVid));
    startImg=startImgCatalogue(numVid);
    startImgStat=round(startCatalogue(numVid)*fps);
    
    centerCellX=centerCellXCat(numVid)+radiusCellPx;
    centerCellY=centerCellYCat(numVid)+radiusCellPx;
    
    centerCellXBg=centerCellXBgCat(numVid)+radiusCellPx;
    centerCellYBg=centerCellYBgCat(numVid)+radiusCellPx;
    
    radiusCellPxBg=radiusCellPx;
    
    shiftX=centerCellX-centerCellXBg;
    shiftY=centerCellY-centerCellYBg;
    %trouver le coin haut gauche et bas droit du carré de référence
    refSqX0=referenceSqX0Cat(numVid);
    refSqY0=referenceSqY0Cat(numVid);
    refSqX1=refSqX0+referenceSqDXCat(numVid);
    refSqY1=refSqY0+referenceSqDYCat(numVid);
    %R_range contient les tailles min et max des cercles qui seront
    %détectés dans camphre_findpos_rom
    R_range=[floor(RCat(numVid)*0.85*0.5/calib) ceil(RCat(numVid)*1.15*0.5/calib)];
    
    fprintf(num2str(numVid));
    
    
    directoryVid=strcat(basePathVid,date,set,video,'\');
    
    directoryBg=strcat(directoryVid,'bg\');
    directoryAnalyse=strcat(basePathAnalyse,date,set,video);
    
    L=dir(strcat(directoryBg,format));
    % a typical image to get its size
    fname=L(1).name;
    fnamecompl=strcat(directoryBg,fname);
    im0=imread(fnamecompl);
    %im0=im0(:,:,1);
    im0=zeros(size(im0));
    
       
    
    %loop over the images of the background
    for k=1:length(L)
        %get the current image
        fname=L(k).name;
        fnamecompl=strcat(directoryBg,fname);
        im=double(imread(fnamecompl));
        %initialize a normalization factor for the background
        
        % and measure it in the reference square that is shifted compared to
        % the reference square in the movie
        refSquareBg=im(refSqY0-shiftY:refSqY1-shiftY,refSqX0-shiftX:refSqX1-shiftX);
        Ac_bg=mean(mean(refSquareBg));
        bgc(numVid,k)=Ac_bg;
    end
    L=dir(strcat(directoryVid,format));
    startIm=startImg;
    for k=1:1000
        fname=L(k+startIm).name;
        fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        %im=im(:,:,1); %à utiliser si RGB
        
        refSquare=im(refSqY0:refSqY1,refSqX0:refSqX1);
        Ac_im=mean(mean(refSquare));
        noc(numVid,k)=Ac_im;
    end
    
    hold on;
    color_line(x,bgc(numVid,:),ones(1,length(x)).*numVid);
    color_line(x,noc(numVid,:),ones(1,length(x)).*numVid,'o');
    hold off;
    
end



% grid
% xlabel('Frequence spatiale (mm$^{-1}$)','Interpreter','latex');
% ylabel('Puissance','Interpreter','latex');
% legend(videoCatalogue(12:17));
%legend(['1'; '2'; '3'; '4'; '5'; '6'])
% title('Pwelch des images seuillees');

meanbg=[];
meanim=[];
meansous=[];
meandiv=[];
for i=2:11
    meanbg(i)=mean(bgc(i,1:200));
    meanim(i)=mean(noc(i,1:1000));
    
end
meansous=meanim-meanbg;
meandiv=meanim./meanbg;
figure; plot(meansous(2:11));
figure; plot(meandiv(2:11));

for numVid=2:11
     hold on;
    color_line(x,bgc(numVid,:),ones(1,length(x)).*numVid);
    color_line(x,noc(numVid,:),ones(1,length(x)).*numVid,'o');
    hold off;
end
