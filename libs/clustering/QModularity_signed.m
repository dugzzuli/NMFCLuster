function [ Q ] = QModularity_signed( A, labels )
    A_plus = A; 
    A_plus(A_plus < 0) = 0;
    
    if(nnz(A_plus) == 0)
        Q_plus = 0;
    else
        Q_plus = QModularity(A_plus, labels);
    end
    
    
    A_minus = -A; 
    A_minus(A_minus < 0) = 0;
    if(nnz(A_minus) == 0)
        Q_minus = 0;
    else
        Q_minus = QModularity(A_minus, labels);
    end
    
    
    alpha_plus = sum(nonzeros(A_plus)) / sum(nonzeros(abs(A)));
    Q = alpha_plus*Q_plus - (1-alpha_plus)*Q_minus;
end

