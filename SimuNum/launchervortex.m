clear all;close all;run defaultfig;
run manips % Catalogue de toutes les variables utilisées pour les exp demandées
autosaves=1; % Si on veut des enregistrements réguliers de l'avancée de la simu, en cas de pépin
globalcount=0; % Juste pour l'affichage de l'avancée
videocount=0; %idem
affichage=0; %1 si on veut tracer le champ, 0 si non
changes=zeros(1,nombreVid);
start=768;%70;
for ii=start:768%nombreVid % Pour l'affichage de l'avancée globale du programme on compte d'abord le nombre de pas de temps totaux à réaliser dans toutes les manips
    if exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0
        load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'nt');
        old_nt=nt;
    else
        old_nt=1;
    end
    nt=manipCat.nt(ii);
    
    globalcount=globalcount+nt-old_nt;
end
%for ii=[526,542,558]% La boucle qui appelle le programme de simu
for ii=[728:733,736:740]
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
    %     Cfield=real(ifft2(Ccamp_f));
    % save(strcat('E:\Clément\SimuNum\SimusMultiN\',num2str(npart),'.mat'),'Cfield','mx','my')
    if nt~=old_nt
        ii
        if exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'))~=0 % si il existe déjà des data pour cette vidéo, on repart du dernier pas de temps existant
            load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
            old_nt=nt;
        end
            nt=manipCat.nt(ii);

        simu;
        changes(ii)=1;
    end
    % mean_vfield;
   % if bbg>1
%         ii
       %  concmoyautournag;
%         % pairMean2D_25032021;
%ii
            load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));

        %     calc_std;
%         
%         %if exist(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_msd','.mat'))==0
          calc_msdbbg 
%         %end
   %  end
%     if (manipCat.set{ii}(1)=='m') && (manipCat.set{ii}(2)=='u')
%         ii
%         load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_p6.mat'))
%         directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
%         p6list=abs(p6list);
%         save(strcat(directoryPyt,manipCat.video{ii},'_p6time.mat'),'tlist','p6list')
%     end
   % load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'mx','my');
%  calc_p6;
%calc_g6;
        calc_msdnag;
  %  end
%     if bbg>1
%         ii
%             load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'),'mxbg','mybg');
% 
    %     calc_msdbbg;
%     end
    %     if ((ii>34 && ii<45) || (ii>59 && ii<71)) && changes(ii)==1
    %     profiles;
    %     end
    %   replay_profils;
    %if (ii>100 && changes(ii)==1)
    %stabilite;
    %end
    %directoryPyt=strcat('E:\Clément\MyCore\Analyse\SimuNum\Vortex\',manipCat.date{ii},'\',manipCat.set{ii},'\');
    %stabilite_v2;
    %if A<2
    %     stabilite;
    %     stabilite_v2;
    %end
             %   load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'.mat'));
%concmoyautournag;
%     hold off;plot(mx,'b');hold on;plot(my,'r');
            %  hold off;
           % figure(1);plot(mx(:,1),my(:,1),'-b',mx(:,2),my(:,2),'+r');title(num2str(ii));
          % figure(2);plot(my);hold on;title(num2str(ii));pause;
    
    %  load(strcat('E:\Clément\SimuNum\Resultats\',manipCat.date{ii},'\',manipCat.set{ii},'\',manipCat.video{ii},'_profiles.mat'))
    %   hold on;color_line(linspace(-100,100,200),mean(profs),ones(1,200)*A);hold off;
    videocount=videocount+nt-old_nt;
    
end
transfer; % Code pour exporter vers MyCore les résultats et les utiliser dans les notebooks

