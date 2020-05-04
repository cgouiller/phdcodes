clear all;close all;run defaultfig;
run manips
commit='a5a5f2dbb5287826a6f5ef98f662dba13d8a5d0e';
for ii=120:nombreVid
    if exist(strcat('E:\Clément\SimuNum\Resultats2\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'))~=0
        load(strcat('E:\Clément\SimuNum\Resultats2\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'));
        old_nt=nt;
    else
        old_nt=1;
    end
    % for jj=1:length(ampeccat)
    %% Choix de simu
    % npart=ncat(ii); %Nombre de nageurs
    %amp_ec=ampeccat(ii);
    taup=manipCat200320.taup(ii);
    inertie=manipCat200320.inertie(ii);
    amp_ec=manipCat200320.amp_ec(ii);
    npart=manipCat200320.npart(ii);
    A=manipCat200320.A(ii);
    nt=manipCat200320.nt(ii);
    rdomstart=manipCat200320.randomstart(ii);
    ecoulement=1;
    marangoni=1;
    if amp_ec==0
        ecoulement=0;
    end
    if A==0
        marangoni=0;
    end
    
    
    affichage=0; %1 si on veut tracer le champ, 0 si non
    %npart=30; %Nombre de nageurs
    
    Dnag=5; %En mm, le diamètre des nageurs voulus
    
    %inertie=0; %1 si avec inertie, 0 si non
    %taup=0.2;%s'il y a de l'inertie, choix du temps caractéristique
    
    %marangoni=1; % allume ou éteint le coef v=-marangoni*A*gradC - 1 si camphre source d'écoulement Marangoni, 0 si non
    asrc=manipCat200320.asrc(ii); % Amplitude du flux de camphre libéré
    %A=0.8; % Amplitude des effets Marangoni
    %A=A*marangoni;
    
    advection=1; %1 si avec advection, 0 si non
    
    
        param_ecexterne=manipCat200320.paramec(ii); %Choix du type d'écoulement : 1 pour Taylor-Green, 2 pour un écoulement en 1/r^2
    
    if nt~=old_nt
        ii
        simu;
        calcEcandpdfs;

    end
calcEcandpdfs;
    %end
end
%transfer;