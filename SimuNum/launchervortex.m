clear all;close all;run defaultfig;
run manips % Catalogue de toutes les variables utilis�es pour les exp demand�es
autosaves=1; % Si on veut des enregistrements r�guliers de l'avanc�e de la simu, en cas de p�pin
globalcount=0; % Juste pour l'affichage de l'avanc�e
videocount=0; %idem
affichage=0; %1 si on veut tracer le champ, 0 si non    
changes=zeros(1,nombreVid);
for ii=1:nombreVid % Pour l'affichage de l'avanc�e globale du programme on compte d'abord le nombre de pas de temps totaux � r�aliser dans toutes les manips
    if exist(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0
        load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
        old_nt=nt;
    else
        old_nt=1;
    end
    nt=manipCat.nt(ii);

    globalcount=globalcount+nt-old_nt;
end
for ii=117%:nombreVid% La boucle qui appelle le programme de simu
   ii
    if exist(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0 % si il existe d�j� des data pour cette vid�o, on repart du dernier pas de temps existant
        load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
        old_nt=nt;
    else
        old_nt=1;
    end
    
    %% Choix des param�tres de la simu
    
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
    ecoulement=1;
    marangoni=1;
    if amp_ec==0
        ecoulement=0;
    end
    if A==0
        marangoni=0;
    end
    
    
    Dnag=5; %En mm, le diam�tre des nageurs voulus
    asrc=manipCat.asrc(ii); % Amplitude du flux de camphre lib�r�
    advection=1; %1 si avec advection, 0 si non
    
    
    param_ecexterne=manipCat.paramec(ii); 

   if nt~=old_nt
        simu;
        changes(ii)=1;
   end
    if ((ii>34 && ii<45) || (ii>59 && ii<71)) && changes(ii)==1
    profiles;
    end
%   replay_profils;
%if (ii>100 && changes(ii)==1) 
%stabilite;
%end
directoryPyt=strcat('E:\Cl�ment\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');

if exist(strcat(directoryPyt,manipCat.video{ii},'_stab.mat'))~=0
    stab_teleport;
end
   videocount=videocount+nt-old_nt;

%  load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_profiles.mat'))
 %   hold on;color_line(linspace(-100,100,200),mean(profs),ones(1,200)*A);hold off;
end
transfer; % Code pour exporter vers MyCore les r�sultats et les utiliser dans les notebooks
