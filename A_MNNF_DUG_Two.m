function [ W_re,H_re,err_re,err_data,hom] = A_MNNF_DUG_Two( VData,r,tol,ite,lamda,change,plotIs,init)
%A_MNNF_DUG �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��


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
    %    ͨ��W��HHH�ع���ά����
    reVData=zeros(m,n,k);
    for j=1:k
        reVData(:,:,j)=reVData(:,:,j)+W*H_A(:,:,j)';
    end
    %ͨ���ع����ݽ���������
    err=0;
    for j=1:k
        err_mat=reVData(:,:,j)-VData(:,:,j);
        err=err+matrixNorm(err_mat);
    end
    err_data(count)=err;
    %�ж����
    if(tol>err)
        fprintf('�������\n')
        break
    end
    %
    if(abs(last_err-err)<change)
        fprintf('�������\n')
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
    
    
    
    
    for i=1:k %����HHH����
        V=VData(:,:,i);
        
        H_Q=kfcnnls(W,V);
        H_A(:,:,i)=H_Q';
    end
    
    fprintf('��ǰ���:%f\n',err)
end
fprintf('ִ�д���:%d\n',count)
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

