function meaned = nanstd(im)
meaned=std(im(isfinite(im)));