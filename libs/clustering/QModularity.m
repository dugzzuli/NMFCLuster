function [ Q ] = QModularity( A, clusters )
     A(A < 0) = 0;
%     A = (A - min(A(:))) ./ (max(A(:)) - min(A(:)));
%      A = A ./ max(A(:));

%     A = (A - min(A(:))) ./ (max(A(:)) - min(A(:)));
    A = A - diag(diag(A));
    
    d_i = sum(A);
    Deg_prod = d_i'*d_i;

    w = sum(d_i);
    scaled_Deg_prod = Deg_prod ./ w;
    scaled_Deg_prod(isnan(scaled_Deg_prod)) = 0;
    
    Delta = A - scaled_Deg_prod;
    Delta = Delta - diag(diag(Delta));
    
    Q = sum(arrayfun(@(id) sum(nonzeros(Delta(clusters==id, clusters==id))), 1:numel(unique(clusters)))) / w;    

end

