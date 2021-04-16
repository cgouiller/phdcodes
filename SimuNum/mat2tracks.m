function vtracks=mat2tracks(X,Y);

for k = 1:size(X,2)
    vtracks(k).X = X(:,k)';
    vtracks(k).Y = Y(:,k)';
    
end