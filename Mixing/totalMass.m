function [totMass] = totalMass(im)
totMass=0;
for i=1:1024
    for j=1:1024
        if isnan(im(i,j))==0
            totMass=totMass+im(i,j);
        end
    end
end
end