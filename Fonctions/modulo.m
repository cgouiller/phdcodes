

function [r,q] = modulo(a,n)

% Calcule la valeur de a modulo n en prenant pour systeme de residus
% 0, ... , n-1.
%
% appel : [r,q] = modulo(a,n)
%
% Arguments de sortie :
%  r : le residu
%  q : le quotient

q = floor(a./n);
r = a - n*q;

% si le reste de la division entiere vaut 0, le residu vaut par convention n
%if r == 0
    %if q==0   
        %r = 0;
    %else
        %r=n;
    %end
%end


