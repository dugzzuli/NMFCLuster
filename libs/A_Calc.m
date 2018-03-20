function V=A_Calc(W,H_Data)
[m,n,k]=size(H_Data);
for i=1:k
    B=W*H_Data(:,:,i)';
    V(:,:,i)=B;
end
end