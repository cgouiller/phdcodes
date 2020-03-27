%% On se base sur un seuil de concentration de meanTrail pour définir la zone de déplétion


seuilmin=-0.006;
seuil=-0.005;
seuilmax=-0.004;
load(strcat(directoryAnalyse,'meanTrail'));
immoy(isnan(immoy))=-50;
immin=immoy;
immax=immoy;

immoy(immoy<seuil)=-100;immoy(immoy>-50)=0;immoy(immoy==-100)=1;immoy(isnan(immoy)==1)=0;
immoy=immoy(250:1200,944-300:944+300);

immin(immin<seuilmin)=-100;immin(immin>-50)=0;immin(immin==-100)=1;immin(isnan(immin)==1)=0;
immin=immin(250:1200,944-300:944+300);

immax(immax<seuilmax)=-100;immax(immax>-50)=0;immax(immax==-100)=1;immax(isnan(immax)==1)=0;
immax=immax(250:1200,944-300:944+300);
% 
% for i=1:size(immoy,1)
%     der=find(immoy(i,:)==1,1,'last');
%     prem=find(immoy(i,:)==1,1,'first');
%     if isempty(der) || isempty(prem)
%         long(i)=0;
%     else
%         long(i)=der-prem;
%     end
% end
% for i=1:size(immoy,2)
%     der=find(immoy(:,i)==1,1,'last');
%     prem=find(immoy(:,i)==1,1,'first');
%     if isempty(der) || isempty(prem)
%         larg(i)=0;
%             else
%         larg(i)=der-prem;
%     end
% end
% largeur=max(long);
% longueur=max(larg);
%figure;imagesc(immoy);title(video);pause(3);

aire=sum(sum(immoy))/(sizeim^2/(18^2));
incplus=sum(sum(immax))/(sizeim^2/(18^2))-aire;
incmoins=aire-sum(sum(immin))/(sizeim^2/(18^2));
 comment='seuillage sur meanTrail à -0.005 (+/-0.001 pour les incertitudes). Sans correction. Aire en cm^2';
 zone_depl=immoy;
%comment='avec correction autour des nageur et seuil à zéro sur C';
 %save(strcat(directoryAnalyse,'\aire_ell.mat'),'aire','comment','incplus','incmoins','longueur','largeur')
 save(strcat(directoryAnalyse,'\aire_ellipse_conc.mat'),'aire','comment','incplus','incmoins','zone_depl')
% 





