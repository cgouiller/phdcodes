function loged = nanlog(im)
im2=im;
im2(isnan(im2))=1;
loged=log(im2);
end
