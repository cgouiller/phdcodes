clear all;close all;run defaultfig;
run manips % Catalogue de toutes les variables utilisées pour les exp demandées
autosaves=0; % Si on veut des enregistrements réguliers de l'avancée de la simu, en cas de pépin
 %% Juste pour l'affichage de l'avancée
globalcount=0;
videocount=0; %idem
affichage=1; %1 si on veut tracer le champ, 0 si non
changes=zeros(1,nombreVid);
start=1; % début de la boucle sur les manips
for ii=start:nombreVid % Pour l'affichage de l'avancée globale du programme on compte d'abord le nombre de pas de temps totaux à réaliser dans toutes les manips
    if exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0
        load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'nt');
        old_nt=nt;
    else
        old_nt=1;
    end
    nt=manipCat.nt(ii);
    
    globalcount=globalcount+nt-old_nt;
end
%% La boucle qui appelle le programme de simu
for ii=start:nombreVid
    ii
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

    if nt~=old_nt % c'es à dire que si la simu n'est pas déjà faite
        ii
        if exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0 % si il existe déjà des data pour cette vidéo, on repart du dernier pas de temps existant
            load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
            old_nt=nt;
        end
            nt=manipCat.nt(ii);

        simu; % on exécute la simulation si nt~=old_nt
        changes(ii)=1; % pour savoir que cette manip a été modifiée (utile dans transfer.m)
    end
  % INSERER ICI LES PROGRAMMES DE POST TRAITEMENT
    videocount=videocount+nt-old_nt;
    
end
transfer; % Code pour exporter vers MyCore les résultats et les utiliser dans les notebooks

