function [Sf] = Sscal_adams(advection,scal_f,vx,vy,kx,ky,alias)

% Pseudospectral calculation of - div(v.scal)
% S = - div(v.scal)
% we stay in fourier space and only deal with non linear terms

alias_flag=1;
if size(vx)==size(scal_f) 

if size(alias)==size(scal_f)
vxf=fft2(vx);
vx=real(ifft2(vxf.*alias));
vyf=fft2(vy);
vy=real(ifft2(vyf.*alias));
scal=real(ifft2(scal_f.*alias));
nscal=mean(mean(abs(scal)));    
phix=vx.*scal;
phiy=vy.*scal;
phix_f=fft2(phix);
phix_f=phix_f.*alias;
phiy_f=fft2(phiy);
phiy_f=phiy_f.*alias;

else
    
    scal=real(ifft2(scal_f));
    nscal=mean(mean(abs(scal)));    
    phix=vx.*scal;
    phiy=vy.*scal;
    phix_f=fft2(phix);
    phiy_f=fft2(phiy);

end

dphix_f = 1i*kx.*phix_f;
dphiy_f = 1i*ky.*phiy_f;
  
Sf = - dphix_f - dphiy_f;


else
    
Sf = zeros(size(scal_f));    

end  

if advection==0
    Sf=zeros(size(scal_f));
end