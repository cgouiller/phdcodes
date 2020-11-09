function[uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad)

vxfiltp=padarray(vxfilt,[Npad Npad],'circular','both');
vyfiltp=padarray(vyfilt,[Npad Npad],'circular','both');
xsm=modulo(xs,2*pi);
ysm=modulo(ys,2*pi);
uxp=interp2(xpad,ypad,vxfiltp,xsm,ysm,'spline');
uyp=interp2(xpad,ypad,vyfiltp,xsm,ysm,'spline');