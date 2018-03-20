function [ W_re,H_re,err_re,err_data] = RDMNMF( VData,r,tol,ite,change,plotIs,init)
eps=1e-10;
%A_MNNF_DUG 此处显示有关此函数的摘要
%   此处显示详细说明


% lamda=0.2;
% tol=0.001;
% r=2
% ite=100000;
flag=0;

[m,n,k]=size(VData)
if strcmp(init,'svd')
    
    W_A=zeros(m,r);
    for i=1:k
        [W,H]=svdnmf_init(VData(:,:,k),r);
        W_A=W_A+W;
        H=normc(H);
        H_A(:,:,i)=H;
    end
    W=W_A/k;
    % W=rand(m,r);
else
    W=rand(m,r);
    W=normc(W);
    H=rand(r,n);
    H=normc(H);
end



[m,n,k]=size(VData);
last_err=1.5;
flag=3;
for count=1:ite
    err=0;
	for j=1:k
		V=VData(:,:,j);
		err=err+CalculateObj(V,W,H_A(:,:,j));
		
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
	for j=1:k
		V=VData(:,:,j);
		Di=L21D(V,W,H_A(:,:,j));
		p_up=p_up+V*Di*H_A(:,:,j)'
	end
	p_down=zeros(m,r);
	for j=1:k
		V=VData(:,:,j);
		Di=L21D(V,W,H_A(:,:,j));
		p_down=p_down+W*H_A(:,:,j)*Di*H_A(:,:,j)'
	end
	W=W.*p_up./max(p_down,eps);
	W=normc(W);
    for j=1:k %更行HHH矩阵
        V=VData(:,:,j);
		Di=L21D(V,W,H_A(:,:,j));
        H_Q=H_A(:,:,j).*(W'*V*Di)./max((W'*W*H_A(:,:,j)*Di),eps);
        H_A(:,:,j)=H_Q;
        
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
function [obj] = CalculateObj(X,F,G)
    s=size(X);
    n=s(1);
    D = zeros(n,1);

    for i=1:n
        D(i)=norm(X(:,i)-F*G(:,i));
    end
    obj = sum(D);
end
