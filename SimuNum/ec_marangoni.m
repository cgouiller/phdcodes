function [vxf,vyf]=ec_extern(marangoni,Ccamp_f,kx,ky,A)


if marangoni==1
    vxf=1i*kx.*Ccamp_f;vxf=-A*vxf;
    vyf=1i*ky.*Ccamp_f;vyf=-A*vyf;
end
if marangoni==0
    vxf=0.*Ccamp_f;
    vyf=0.*Ccamp_f;
end