function im = nanOutCircle(im,yc,xc,r)
    for i=1:length(im)
        for j=1:length(im)
            if ((i-xc)^2+(j-yc)^2)>r^2
                im(i,j)=nan;
            end
        end
    end
end