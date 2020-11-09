function [xsnew,ysnew,vsxnew,vsynew]=eval_posvit(methode,inertie,pas,xs,ys,vsx,vsy,uxp,uyp,gfilt_f,vxextf,vyextf,Npad,xpad,ypad,uxp_old,vsx_old,uyp_old,vsy_old,vx,vy,taup)


if methode==0 % On le fait que pour le pas de temps t=1/2 parce qu'on n'a pas deux antécédents pour faire du Adams
    xsnew=xs+vsx*pas;
    ysnew=ys+vsy*pas;
    if inertie==0
        vsxnew=uxp;
        vsynew=uyp;
    elseif inertie==1
        vsxnew=vsx+pas/taup*(uxp-vsx);% vitesse en t=1/2
        vsynew=vsy+pas/taup*(uyp-vsy);% vitesse en t=1/2
    end
end

if methode==1 % Pour tous les autres
    xsnew=xs+pas*(3/2*vsx-1/2*vsx_old);% position en t+pas
    ysnew=ys+pas*(3/2*vsy-1/2*vsy_old);
    if inertie==0
        vsxnew=uxp;
        vsynew=uyp;
    elseif inertie==1
        vsxnew=vsx+pas/taup*(3/2*(uxp-vsx)-1/2*(uxp_old-vsx_old));% vitesse en t+dt
        vsynew=vsy+pas/taup*(3/2*(uyp-vsy)-1/2*(uyp_old-vsy_old));
    end
    
end
end