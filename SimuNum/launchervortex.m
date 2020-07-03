clear all;close all;run defaultfig;
run manips
commit='03402046d845ecbdbb62e173f83e13e2f1c7808c';
autosaves=1;
globalcount=0;
videocount=0;
for ii=1:nombreVid
    if exist(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'))~=0
        load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'));
        old_nt=nt;
    else
        old_nt=1;
    end
    nt=manipCat200320.nt(ii);

    globalcount=globalcount+nt-old_nt;
end
for ii=1:nombreVid
    if exist(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'))~=0
        load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'));
        old_nt=nt;
    else
        old_nt=1;
    end
    
   % figure;plot(mx(1:100:end));hold on;plot(my(1:100:end),'r');title(num2str(ii));
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
    
    Dnag=5; %En mm, le diam�tre des nageurs voulus
    
    %inertie=0; %1 si avec inertie, 0 si non
    %taup=0.2;%s'il y a de l'inertie, choix du temps caract�ristique
    
    %marangoni=1; % allume ou �teint le coef v=-marangoni*A*gradC - 1 si camphre source d'�coulement Marangoni, 0 si non
    asrc=manipCat200320.asrc(ii); % Amplitude du flux de camphre lib�r�
    %A=0.8; % Amplitude des effets Marangoni
    %A=A*marangoni;
    
    advection=1; %1 si avec advection, 0 si non
    
    
        param_ecexterne=manipCat200320.paramec(ii); %Choix du type d'�coulement : 1 pour Taylor-Green, 2 pour un �coulement en 1/r^2
%     load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'.mat'))
%     Ccamp=real(ifft2(Ccamp_f));
%     figure;imagesc(Ccamp);colorbar;title(num2str(ii));
   if nt~=old_nt
        ii
        simu;
     %   calcEcandpdfs;

   end
   
   videocount=videocount+nt-old_nt;
%     if exist(strcat('E:\Cl�ment\SimuNum\Resultats2\',manipCat200320.date{ii},'\',manipCat200320.set{ii},'\',manipCat200320.video{ii},'_analyze.mat'))==0
%         ii
% calcEcandpdfs;
%     end
    %end
end
%transfer;