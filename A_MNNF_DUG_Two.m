function [ W_re,H_re,err_re,err_data,hom] = A_MNNF_DUG_Two( VData,r,tol,ite,lamda,change,plotIs,init)
%A_MNNF_DUG 此处显示有关此函数的摘要
%   此处显示详细说明


% lamda=0.2;
% tol=0.001;
% r=2
% ite=100000;


[m,n,k]=size(VData)
if strcmp(init,'svd')
    
    W_A=zeros(m,r);
    for i=1:k
        [W,H]=svdnmf_init(VData(:,:,k),r);
        W_A=W_A+W;
        H=H';
        H=normc(H);
        H_A(:,:,i)=H;
    end
    W=W_A/k;
    W=rand(m,r);
else
    W=rand(m,r);
    W=normc(W);
    H=rand(n,r);
    H=normc(H);
end



[m,n,k]=size(VData)
last_err=1.5;
for count=1:ite
    %    通过W，HHH重构三维数据
    reVData=zeros(m,n,k);
    for j=1:k
        reVData(:,:,j)=reVData(:,:,j)+W*H_A(:,:,j)';
    end
    %通过重构数据进行误差计算
    err=0;
    for j=1:k
        err_mat=reVData(:,:,j)-VData(:,:,j);
        err=err+matrixNorm(err_mat);
    end
    err_data(count)=err;
    %判断误差
    if(tol>err)
        fprintf('收敛完成\n')
        break
    end
    %
    if(abs(last_err-err)<change)
        fprintf('收敛完成\n')
        break
    end
    last_err=err;
    
    
    c=zeros(m,n);
    for i=1:k
        c=c+VData(:,:,i)
    end
    
    d=zeros(n,r);
    for i=1:k
        d=d+H_A(:,:,i);
    end
    
    
    W=kfcnnls(d,c')';
    W=normc(W);
    
    
    
    
    for i=1:k %更行HHH矩阵
        V=VData(:,:,i);
        
        H_Q=kfcnnls(W,V);
        H_A(:,:,i)=H_Q';
    end
    
    fprintf('当前误差:%f\n',err)
end
fprintf('执行次数:%d\n',count)
W_re=W;
H_re=H_A;
err_re=err;

if plotIs==1
    hom=HeatMap(flipud(W_re));
    for i=1:k
        HeatMap(H_re(:,:,i));
    end
end
end

