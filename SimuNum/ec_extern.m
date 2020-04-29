function [vx,vy,vxf,vyf]=ec_extern(onoff,choix,N,amplitude,x,y)


if onoff==0
    vx=0.*x;
    vy=0.*y;
end
if onoff==1
    if choix==1
        vx=amplitude*sin(x).*cos(y);
        vy=-amplitude*cos(x).*sin(y);
        
    end
    if choix==2
        vy=amplitude*(x-pi)./((x-pi).^2+(y-pi).^2);
        vx=-amplitude*(y-pi)./((x-pi).^2+(y-pi).^2);
        vx(33,33)=0;
        vy(33,33)=0;
    end
    if choix==3
        vx=amplitude*sin(y);
        vy=0;
    end
end


vxf=fft2(vx);
vyf=fft2(vy);