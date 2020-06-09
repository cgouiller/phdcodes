directoryVid='E:\Clément\Multi\200525\actif15\';
L=dir(strcat(directoryVid,'*.tif'));
fname=L(1).name;
fnamecompl=strcat(directoryVid,fname);
im=double(imread(fnamecompl));
im0=zeros(size(im));
for k=1:length(L)
    fname=L(k).name;
    fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        im0=im0+im;
           
end
im0=im0/length(L);
for k=1:length(L)
    fname=L(k).name;
    fnamecompl=strcat(directoryVid,fname);
        im=double(imread(fnamecompl));
        imagesc(im-im0,[30 90]);pause(0.1);
end
