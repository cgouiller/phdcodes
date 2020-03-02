
[im, imref, param]=mCINREAD2(strcat('D:\2019_12_gouiller\',dateCatalogue{numVid},'\',num2str(numProf{numVid}),'_',num2str(numPassage(numVid)),'.mcin2'),1,nbImg(numVid));

%%
mkdir(directoryVid)
kstart=1;
kstop=nbImg(numVid);
var=im;
fname='im_';
for kk=kstart:kstop;
    number=int2str(kk);
    for j=1:4-length(number)
        number=['0' number];
    end
imwrite(var(:,:,kk),[directoryVid '\' fname number '.tif'],'tiff');

end

