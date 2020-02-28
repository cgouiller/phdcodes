function [interp,count] = bilinear_clement( array, ind )

%%Permet de faire une rotation à une image de manière optimisé

interp=zeros(size(array));
count=ones(size(array));
    ind_0  = floor(ind);                          % top    - left
    
 
    ind_x  = ind_0;  ind_x(:,1) = ind_x(:,1) +1;  % top    - right
    ind_y  = ind_0;  ind_y(:,2) = ind_y(:,2) +1;  % bottom - left
    ind_xy = ind_0;  ind_xy     = ind_xy     +1;  % bottom - right

    alpha  = ind - ind_0;
    beta   = 1 - alpha;
    
    % check if still in array
    s = length(array);

    % clamp indices
    indout=ind_0 <1|ind_0 >s|ind_x<1|ind_x>s|ind_y<1|ind_y>s|ind_xy<1|ind_xy>s;
    indouttot=indout(:,1)|indout(:,2);

    % convert to 1D indices (same as sub2ind but quicker)
    ind_0 (:,1) = (ind_0 (:,2)-1)*s + ind_0 (:,1);
    ind_x (:,1) = (ind_x (:,2)-1)*s + ind_x (:,1);
    ind_y (:,1) = (ind_y (:,2)-1)*s + ind_y (:,1);
    ind_xy(:,1) = (ind_xy(:,2)-1)*s + ind_xy(:,1);
    A=find(~indouttot);
  
   
    
    B=~isfinite(array(ind_0((~indouttot),1)))|~isfinite(array(ind_x((~indouttot),1)))|~isfinite(array(ind_xy((~indouttot),1)))|~isfinite(array(ind_y((~indouttot),1)));
    indouttot(A(B))=1;

    % compute the sum of the bilinear interpolation
    % interp = zeros(size(alpha,1),1);


        interp(~indouttot) =          beta ((~indouttot),1).*beta ((~indouttot),2).*array(ind_0 ((~indouttot),1));
        interp(~indouttot) = interp(~indouttot) + alpha((~indouttot),1).*beta ((~indouttot),2).*array(ind_x ((~indouttot),1));
        interp(~indouttot) = interp(~indouttot) + beta ((~indouttot),1).*alpha((~indouttot),2).*array(ind_y ((~indouttot),1));
        interp(~indouttot) = interp(~indouttot) + alpha((~indouttot),1).*alpha((~indouttot),2).*array(ind_xy((~indouttot),1));

        count(indouttot)=0;
end