function meaned = nanmean2(im)
meaned=mean(mean(im(isfinite(im))));