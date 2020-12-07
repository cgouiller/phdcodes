function [vxf,vyf]=ec_extern(marangoni,Ccamp_f,kx,ky,A,satur)

Ccampmean=mean(mean(real(ifft2(Ccamp_f))));
if marangoni==1
    if satur==0
        coefmar=A;
    else
        Ccampmean=mean(mean(real(ifft2(Ccamp_f))));
        coefmar=A/(1+Ccampmean/satur);
    end
    vxf=1i*kx.*Ccamp_f;vxf=-coefmar*vxf;
    vyf=1i*ky.*Ccamp_f;vyf=-coefmar*vyf;
end
if marangoni==0
    vxf=0.*Ccamp_f;
    vyf=0.*Ccamp_f;
end