clear all;close all;run defaultfig;
manipCat200320.taup=[0,0,0.1,0.2,0.4,0.1,0.2,0.4,0,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2];
manipCat200320.inertie=[0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1];
manipCat200320.amp_ec=[1,5,1,1,1,5,5,5,0,0,0,0,0,0,0,2,4,6,3,3,3,0];
manipCat200320.npart=[1,1,1,1,1,1,1,1,10,10,7,15,30,45,1,1,1,1,1,1,1,10];
manipCat200320.A=[0,0,0,0,0,0,0,0,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.2,0.4,0.6,0.8];
manipCat200320.set={'test','test','test','test','test','test','test','test','test','test','varN','varN','varN','varN','varV','varV','varV','varV','varA','varA','varA','test'};
manipCat200320.video={'01','02','03','04','05','06','07','08','09','10','07','15','30','40','00','02','04','06','02','04','06','11'};
manipCat200320.advection=ones(1,22);
manipCat200320.asrc=0.1*ones(1,22);
manipCat200320.nt=1e4*[ones(1,21),4];
manipCat200320.date={'200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320','200320'};
for ii=22%:length(manipCat200320.save)
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