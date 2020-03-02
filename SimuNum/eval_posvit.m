function [xs,ys,vsx,vsy]=eval_posvit(methode,inertie,pas,xs,ys,vsx,vsy,uxp,uyp,gfilt_f,vxextf,vyextf,Npad,xpad,ypad,uxp_old,vsx_old,uyp_old,vsy_old,vx,vy,taup)


if methode==0
    xs=xs+vsx*pas;
    ys=ys+vsy*pas;
    if inertie
        vsx=vsx+pas*(vsx-uxp);% vitesse en t=1/2
        vsy=vsy+pas*(vsy-uyp);% vitesse en t=1/2
    else
        vsx=vx+real(ifft2(gfilt_f.*vxextf));
        vsy=vy+real(ifft2(gfilt_f.*vyextf));
        vsxp=padarray(vsx,[Npad Npad],'circular','both');
        vsyp=padarray(vsy,[Npad Npad],'circular','both');
        xsm=modulo(xs,2*pi); %nouvelles positions des particules de fluide
        ysm=modulo(ys,2*pi);
        vsx=interp2(xpad,ypad,vsxp,xsm,ysm,'spline');
        vsy=interp2(xpad,ypad,vsyp,xsm,ysm,'spline');
    end
end
if methode==1
    xs=xs+pas*(3/2*uxp-1/2*uxp_old);% position en t+pas
    ys=ys+pas*(3/2*uyp-1/2*uyp_old);
    if inertie
        vsx=vsx+pas/taup*(3/2*(uxp-vsx)-1/2*(uxp_old-vsx_old));
        vsy=vsy+pas/taup*(3/2*(uyp-vsy)-1/2*(uyp_old-vsy_old));
    else
        vsx=vx+real(ifft2(gfilt_f.*vxextf));
    vsy=vy+real(ifft2(gfilt_f.*vyextf));
     vsxp=padarray(vsx,[Npad Npad],'circular','both');
    vsyp=padarray(vsy,[Npad Npad],'circular','both');
    xsm=modulo(xs,2*pi); %nouvelles positions des particules de fluide
    ysm=modulo(ys,2*pi);
    vsx=interp2(xpad,ypad,vsxp,xsm,ysm,'spline');
    vsy=interp2(xpad,ypad,vsyp,xsm,ysm,'spline');
    end
end