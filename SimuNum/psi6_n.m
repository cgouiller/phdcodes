%clear all;close all;run defaultfig;
run manips % Catalogue de toutes les variables utilisées pour les exp demandées
nbs=[];
psi6=[];
incert=[];
for ii=1:890
    
    
    if exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0 % si il existe déjà des data pour cette vidéo, on repart du dernier pas de temps existant
        load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'nt');
        old_nt=nt;
    else
        old_nt=1;
    end
    nt=manipCat.nt(ii);
    %% Choix des paramètres de la simu
    bbg=manipCat.bbg(ii);
    taup=manipCat.taup(ii);
    inertie=manipCat.inertie(ii);
    amp_ec=manipCat.amp_ec(ii);
    npart=manipCat.npart(ii);
    A=manipCat.A(ii);
    nt=manipCat.nt(ii);
    rdomstart=manipCat.randomstart(ii);
    dt=manipCat.dt(ii);
    satur=manipCat.satur(ii);
    theta=manipCat.theta(ii);
    delai=manipCat.delai(ii);
    L=manipCat.L(ii);
    ecoulement=1;
    marangoni=1;
    if amp_ec==0
        ecoulement=0;
    end
    if A==0
        marangoni=0;
    end
    Dbg=manipCat.Dbg(ii);
    
    Dnag=5; %En mm, le diamètre des nageurs voulus
    asrc=manipCat.asrc(ii); % Amplitude du flux de camphre libéré
    advection=1; %1 si avec advection, 0 si non
    
    
    param_ecexterne=manipCat.paramec(ii);

     if (manipCat.set{ii}(1)=='m') && (manipCat.set{ii}(2)=='u')
         ii
         load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_p6.mat'))
                 p6=p6list(round(linspace(end-100000,end-1,round(20000/npart))),:);

        nbs=[nbs,npart];
        psi6=[psi6,abs(mean(mean(p6)))/6];
        incert=[incert,abs(std(reshape(p6,[numel(p6),1])))/(6*sqrt(npart))];
     end

end
N=nbs;
param=psi6;
save('E:\Clément\MyCore\analyse\SimuNum\Vortex\paramordre.mat','N','param','incert')

