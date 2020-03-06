function [vxfilt,vyfilt]=ec_filtre(marangoni,ecoulement,vxf,vxextf,vyf,vyextf,gfilt_f)
% S'il n'y a ni Marangoni ni écoulement, le champ de vitesse est nul.
% S'il y a un des deux, on calcule normalement.


if marangoni || ecoulement
    vxfilt=real(ifft2((vxf+vxextf).*gfilt_f));
    vyfilt=real(ifft2((vyf+vyextf).*gfilt_f));
else
    vxfilt=zeros(size(vxf));
    vyfilt=zeros(size(vxf));
end