function [W,H] = snmf_single(V,a,W,H,WIS,HIS)
% SNMF sparse nonnegative matrix factorization
% L1-based sparsity constraint on H.
% Normalizes W column-wise.
% a - trade-off between sparsity of H and reconstruction quality; 0 for standard NMF
%       - meant to be positive, behaviour not guaranteed for negative values
% m - inner dimension

elapsed = 0;
tic;

[n,t] = size(V);
W = W; % unit sum columns 
H = H;
if WIS==1
updateW();
end
if HIS==1
updateH();
end

function updateW()
VC = V./(W*H + 1e-9);
VC(V==0 & W*H==0) = 1+1e-9;
W = W.*(VC*H')./(ones(n,1)*sum(H,2)');
[W,H] = colsum_L_one(W,H,1); % normalize columns in W
end

    function updateH()        
        VC = V./(W*H + 1e-9);
        VC(V==0 & W*H==0) = 1+1e-9;
        H = (H.*(W'*VC))/(1+a);
    end

end
