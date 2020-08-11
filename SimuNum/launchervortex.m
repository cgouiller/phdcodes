clear all;close all;run defaultfig;
run manips
commit='03402046d845ecbdbb62e173f83e13e2f1c7808c';
autosaves=0;
globalcount=0;
videocount=0;
for ii=1:nombreVid
    if exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0
        load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
        old_nt=nt;
    else
        old_nt=1;
    end
    nt=manipCat.nt(ii);

    globalcount=globalcount+nt-old_nt;
end
for ii=1:nombreVid%[53:nombreVid,42,49,4,5,6,8,10,13,16,20]
    if exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0
        load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
        old_nt=nt;
    else
        old_nt=1;
    end
    
   % figure;plot(mx(1:100:end));hold on;plot(my(1:100:end),'r');title(num2str(ii));
    % for jj=1:length(ampeccat)
    %% Choix de simu
    % npart=ncat(ii); %Nombre de nageurs
    %amp_ec=ampeccat(ii);
    taup=manipCat.taup(ii);
    inertie=manipCat.inertie(ii);
    amp_ec=manipCat.amp_ec(ii);
    npart=manipCat.npart(ii);
    A=manipCat.A(ii);
    nt=manipCat.nt(ii);
    rdomstart=manipCat.randomstart(ii);
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
    asrc=manipCat.asrc(ii); % Amplitude du flux de camphre libéré
    %A=0.8; % Amplitude des effets Marangoni
    %A=A*marangoni;
    
    advection=1; %1 si avec advection, 0 si non
    
    
        param_ecexterne=manipCat.paramec(ii); %Choix du type d'écoulement : 1 pour Taylor-Green, 2 pour un écoulement en 1/r^2
%     load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))
%     Ccamp=real(ifft2(Ccamp_f));
%     figure;imagesc(Ccamp);colorbar;title(num2str(ii));
   if nt~=old_nt
        ii
        simu;
     %   calcEcandpdfs;

   end
  % ii
 %  replay_profils;
   videocount=videocount+nt-old_nt;
%     if exist(strcat('E:\Clément\SimuNum\Resultats2\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_analyze.mat'))==0
%         ii
% calcEcandpdfs;
%     end
    %end
%  load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_profiles.mat'))
 %   hold on;color_line(linspace(-100,100,200),mean(profs),ones(1,200)*A);hold off;
end
%transfer;