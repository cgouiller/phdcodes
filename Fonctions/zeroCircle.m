function im = zeroCircle(im,xc,yc,r)
    for i=(max(xc-r,1)):(min(xc+r,length(im)))
        for j=(max(yc-r,1)):(min(yc+r,length(im)))
            if ((i-xc)^2+(j-yc)^2)<r^2
                im(i,j)=0;
            end
        end
    end
end