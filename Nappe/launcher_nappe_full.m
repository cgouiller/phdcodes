clear all;
nombreVid=4;
dateCatalogue={'Multi-part','Multi-part','Multi-part','Multi-part'};
numProf={'22-228','30-228','petri236','188'};
nbImg=[5600;5600;5600;5600];
diamtrue=[5;5;5;5];
diamvid=[39;39;39;39];
format='*.tif';
no_fields=500;


c=struct(); % a structure to get the positions of the camphors
fps=200;
kg=fspecial('gaussian',[6 6],3);

%


for numVid=4
    
    directoryVid=strcat('E:\Clément\Nappe\',dateCatalogue{numVid},'\',numProf{numVid},'\');
    directoryPiv=strcat('E:\Clément\Nappe\',dateCatalogue{numVid},'\',numProf{numVid},'\Piv\');
    if exist(directoryPiv)==0
        mkdir(directoryPiv);
    end
    baseDir=strcat('E:\Clément\Nappe\',dateCatalogue{numVid},'\',numProf{numVid},'\');
    
    
    
    
    L=dir(strcat(directoryVid,format));
    if exist(strcat(directoryVid,'alea.mat'))==0
        alea=9+round(rand(1,no_fields)*(length(L)-18));
        while length(alea) ~= length(unique(alea))
            alea=[unique(alea),9+round(rand(1,no_fields-length(unique(alea)))*(length(L)-18))];
        end
        save(strcat(directoryVid,'alea.mat'),'alea');
    else
        load(strcat(directoryVid,'alea.mat'))
    end
    if exist(strcat(directoryVid,'\','positions.mat'))==0
        track_particles_nappe;
    end
    
    
    dpiv_nappe_full;
    load(strcat(directoryVid,'\','positions.mat'))
    PIV_treatment_nappe_full;
    
    
    
    
end

