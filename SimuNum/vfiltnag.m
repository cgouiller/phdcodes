function[uxp,uyp]=vfiltnag(vxfilt,vyfilt,Npad,xs,ys,xpad,ypad,L)

vxfiltp=padarray(vxfilt,[Npad Npad],'circular','both');
vyfiltp=padarray(vyfilt,[Npad Npad],'circular','both');
xsm=modulo(xs,L);
ysm=modulo(ys,L);
uxp=interp2(xpad,ypad,vxfiltp,xsm,ysm,'spline');
uyp=interp2(xpad,ypad,vyfiltp,xsm,ysm,'spline');