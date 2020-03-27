clear all;close all;run defaultfig;
ncat=[7,15,30,40,1,1,1,1];
ampeccat=[0,0,0,0,0,2,4,6];
manipCat={strcat('E:\Clément\SimuNum\Resultats\200318\varN\7.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\15.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\30.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varN\40.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\0.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\2.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\4.mat'),strcat('E:\Clément\SimuNum\Resultats\200318\varamp\6.mat')};
manipCat200320.save={strcat('E:\Clément\SimuNum\Resultats\200320\tests\1.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\2.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\3.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\4.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\5.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\6.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\7.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\8.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\9.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\tests\10.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varN\7.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varN\15.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varN\30.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varN\40.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varamp\0.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varamp\2.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varamp\4.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varamp\6.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varA\2.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varA\4.mat'),strcat('E:\Clément\SimuNum\Resultats\200320\varA\6.mat')};  
manipCat200320.taup=[0,0,0.1,0.2,0.4,0.1,0.2,0.4,0,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2];
manipCat200320.inertie=[0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1];
manipCat200320.amp_ec=[1,5,1,1,1,5,5,5,0,0,0,0,0,0,0,2,4,6,3,3,3];
manipCat200320.npart=[1,1,1,1,1,1,1,1,10,10,7,15,30,45,1,1,1,1,1,1,1];
manipCat200320.A=[0,0,0,0,0,0,0,0,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.2,0.4,0.6];

for ii=2:21
   % for jj=1:length(ampeccat)
        %% Choix de simu
       % npart=ncat(ii); %Nombre de nageurs
        %amp_ec=ampeccat(ii);
        taup=manipCat200320.taup(ii);
        inertie=manipCat200320.inertie(ii);
        amp_ec=manipCat200320.amp_ec(ii);
        npart=manipCat200320.npart(ii);
        A=manipCat200320.A(ii);
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
        asrc=1; % Amplitude du flux de camphre libéré
        %A=0.8; % Amplitude des effets Marangoni
        %A=A*marangoni;
        
        advection=1; %1 si avec advection, 0 si non
        
        param_ecexterne=1; %Choix du type d'écoulement : 1 pour Taylor-Green, 2 pour un écoulement en 1/r^2
        
        vortex_200320;

       % calcEcandpdfs;
   %end
end