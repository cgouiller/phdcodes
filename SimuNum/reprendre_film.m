clear all;close all;run defaultfig;
run manips % Catalogue de toutes les variables utilis�es pour les exp demand�es
autosaves=0; % Si on veut des enregistrements r�guliers de l'avanc�e de la simu, en cas de p�pin
affichage=1; %1 si on veut tracer le champ, 0 si non

ii=272 %num�ro de la vid�o
load(strcat('E:\Cl�ment\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
old_nt=nt;


%% Choix des param�tres de la simu

taup=manipCat.taup(ii);
inertie=manipCat.inertie(ii);
amp_ec=manipCat.amp_ec(ii);
npart=manipCat.npart(ii);
A=manipCat.A(ii);
nt=old_nt+1000000;
rdomstart=manipCat.randomstart(ii);
dt=manipCat.dt(ii);
satur=manipCat.satur(ii);
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

simu;



