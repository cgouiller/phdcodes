%% On se base sur la proba d'être une zone de déplétion, analysée grâce à meanTrailbin qui moyenne des images binarisées (glass bubbles ou pas)


seuilmin=0.7;
seuil=0.75;
seuilmax=0.8;
load(strcat(directoryAnalyse,'meanTrailbin'));
probdepl(isnan(probdepl))=-50;
immin=probdepl;
immax=probdepl;

probdepl(probdepl<seuil)=-100;probdepl(probdepl>-50)=0;probdepl(probdepl==-100)=1;probdepl(isnan(probdepl)==1)=0;
probdepl=probdepl(450:1200,944-300:944+300);

immin(immin<seuilmin)=-100;immin(immin>-50)=0;immin(immin==-100)=1;immin(isnan(immin)==1)=0;
immin=immin(450:1200,944-300:944+300);

immax(immax<seuilmax)=-100;immax(immax>-50)=0;immax(immax==-100)=1;immax(isnan(immax)==1)=0;
immax=immax(450:1200,944-300:944+300);

probdepl=1-probdepl;
imagesc(probdepl);
immin=1-immin;
immax=1-immax;
% 
% for i=1:size(probdepl,1)
%     der=find(probdepl(i,:)==1,1,'last');
%     prem=find(probdepl(i,:)==1,1,'first');
%     if isempty(der) || isempty(prem)
%         long(i)=0;
%     else
%         long(i)=der-prem;
%     end
% end
% for i=1:size(probdepl,2)
%     der=find(probdepl(:,i)==1,1,'last');
%     prem=find(probdepl(:,i)==1,1,'first');
%     if isempty(der) || isempty(prem)
%         larg(i)=0;
%             else
%         larg(i)=der-prem;
%     end
% end
% largeur=max(long);
% longueur=max(larg);
%figure;imagesc(probdepl);title(video)
%imagesc(probdepl);pause(2)
aire=sum(sum(probdepl))/(sizeim^2/(18^2));
incplus=sum(sum(immax))/(sizeim^2/(18^2))-aire;
incmoins=aire-sum(sum(immin))/(sizeim^2/(18^2));
 comment='seuillage sur probdepl à 75% (+/-5% pour les incertitudes). Sans correction';
%comment='avec correction autour des nageur et seuil à zéro sur C';
 %save(strcat(directoryAnalyse,'\aire_ell.mat'),'aire','comment','incplus','incmoins','longueur','largeur')
 save(strcat(directoryAnalyse,'\aire_ellipse_proba.mat'),'aire','comment','incplus','incmoins','probdepl')
% 





