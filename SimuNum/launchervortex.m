clear all;close all;run defaultfig;
ncat=[7,15,30,40,1,1,1,1];
ampeccat=[0,0,0,0,0,2,4,6];
manipCat={strcat('E:\Clément\SimuNum\Resultats\200318\varN\7.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\15.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\30.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\40.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\0.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\2.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\4.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\6.mat')};
    
for i=5:length(manipCat)
   % for jj=1:length(ampeccat)
        %% Choix de simu
        npart=ncat(i); %Nombre de nageurs
        amp_ec=ampeccat(i);
        
        
        
        
        affichage=0; %1 si on veut tracer le champ, 0 si non
        %npart=30; %Nombre de nageurs
        
        Dnag=5; %En mm, le diamètre des nageurs voulus
        
        inertie=0; %1 si avec inertie, 0 si non
        taup=0.2;%s'il y a de l'inertie, choix du temps caractéristique
        
        marangoni=1; % allume ou éteint le coef v=-marangoni*A*gradC - 1 si camphre source d'écoulement Marangoni, 0 si non
        asrc=1; % Amplitude du flux de camphre libéré
        
        advection=1; %1 si avec advection, 0 si non
        
        ecoulement=1; %1 si avec écoulement externe, 0 si non
        param_ecexterne=1; %Choix du type d'écoulement : 1 pour Taylor-Green, 2 pour un écoulement en 1/r^2
        %amp_ec=6; %S'il y a un écoulement, son amplitude
        
        vortex_2;

        calcEcandpdfs;
   %end
end