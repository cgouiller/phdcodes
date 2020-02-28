%Calcule Cfield avec Beer-Lambert

function [Cfield] = calc_CfieldBL(im,imbg,pos,immask)
        % divide the image by the background image
        im=(im)./imbg;
        
        %and take the log to get beer-lambert's estimation of the concentration
        Cfield=real(-nanlog(im));
       
        for m=1:length(pos(:,3))
            Cfield=nanCircle(Cfield,round(pos(m,2)),round(pos(m,1)),7+round(pos(m,3)));
        end
        
        % nan the pixels outside the free surface of water
        Cfield=immask.*Cfield;

end

