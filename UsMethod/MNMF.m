function [ W_re,H_re,err_re,err_data] = MNMF( VData,r,tol,ite,change,plotIs,init)
eps=1e-10;
[m,n,k]=size(VData);
%初始化 W H
if strcmp(init,'svd')
    
    W_A=zeros(m,r);
    for i=1:k
        [W,H]=svdnmf_init(VData(:,:,k),r);
        W_A=W_A+W;
        H=normc(H);
        H_A(:,:,i)=H;
    end
    W=W_A/k;
else
    W=rand(m,r);
    W=normc(W);
    H=rand(r,n);
    H=normc(H);
end
last_err=1.5;

for count=1:ite

     %    通过W，HHH重构三维数据
    reVData=zeros(m,n,k);
    for j=1:k
        reVData(:,:,j)=reVData(:,:,j)+W*H_A(:,:,j);
    end

    err=0;
    for j=1:k
        err_mat=reVData(:,:,j)-VData(:,:,j);
        err=err+matrixNorm(err_mat);
    end
    err_data(count)=err;
    
    %判断误差
    if(tol>err)
        fprintf('err.....................收敛完成\n')
        flag=1;
        break
    end
    %
    if(abs(last_err-err)<change)
        fprintf('change..................收敛完成\n')
        flag=2;
        break
    end
    
    last_err=err;
    
    p_up=zeros(m,r);
    
    for i=1:k
        p_up=p_up+VData(:,:,i)*H_A(:,:,i)';
    end
    
    p_down=zeros(m,r);
    
    for i=1:k
        p_down=p_down+W*H_A(:,:,i)*H_A(:,:,i)';
    end
    
    W=W.*p_up./max(p_down,eps);
    
    
    W=normc(W);
    for i=1:k %更行HHH矩阵
        V=VData(:,:,i);
        H_Q=H_A(:,:,i).*(W'*V)./max((W'*W*H_A(:,:,i)),eps);
        H_A(:,:,i)=H_Q;
        
    end
    
    fprintf('当前误差:%f\n',err)
    
    
end

if (count<ite)
    if flag~=1 || flag~=2
        flag=3
    end
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

function cost=err_Calc(X,F,G)
    s=size(X);
    n=s(1);
    D = zeros(n,1);

    for i=1:n
        D(i)=norm(X(:,i)-F*G(:,i));
    end
    cost = sum(D);
end

function [D]=L21D(X,F,G)
eps=1e-5;
n=size(X,2);
d = zeros(1,n);
for i = 1:n
    deno = norm(X(:,i)- F * G(:,i));
    d(i) = 1/max(deno,eps);
end
D =diag(d);
end