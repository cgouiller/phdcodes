function [counts,bins] = hist_maison(image,inf,sup,nbbins,norm)
% Fonction pour calculer un histogramme
%
% Returns the center of the bins and the count in each. Normalized if
% norm=1 and not normalized if not.
% inf and sup are the extreme values of the bins, while nbbins is the
% number of bins to put in between.
 counts=zeros(1,nbbins);
 step=(sup-inf)/nbbins;
 bins=(1:nbbins)*step+inf-step/2;

 for i=1:nbbins
    counts(i)=sum(sum(image<bins(i)+step/2))-sum(sum(image<bins(i)-step/2));
 end
 if norm==1
    counts=counts/sum(counts); 
 end

end