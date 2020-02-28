%Calcule Cfield linéaire

function [Cfield] = calc_Cfield2(im,imbg,pos,immask)
        % divide the image by the background image
        
        
        %and take the log to get beer-lambert's estimation of the concentration
        Cfield=(imbg-im)./imbg;
       
        for m=1:length(pos(:,3))
            Cfield=nanCircle(Cfield,round(pos(m,1)),round(pos(m,2)),round(pos(m,3))+7);
        end
        
        % nan the pixels outside the free surface of water
        Cfield=immask.*Cfield;








end