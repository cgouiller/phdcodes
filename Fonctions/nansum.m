function summed = nansum(im)
im(isnan(im))=0;
summed=sum(im);
