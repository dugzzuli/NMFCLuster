function [ W_re,H_re,err_re,err_data]  = CMNMF( VData,r,tol,ite,change,lambda,plotIs,init)
%CMNMF �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

[m,n,k]=size(VData);
%��ʼ�� W H
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
else
    W=rand(m,r);
    W=normc(W);
    H=rand(r,n);
    H=normc(H);
end
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
        fprintf('err.....................�������\n')
        
        break
    end
    %
    if(abs(last_err-err)<change)
        fprintf('change..................�������\n')
        
        break
    end
    
    last_err=err;
    p_up=zeros(m,r);
    for i=1:k
        p_up=p_up+VData(:,:,i)*H_A(:,:,i);
    end
    p_down=zeros(m,r);
    
    for i=1:k
        p_down=p_down+W*H_A(:,:,i)'*H_A(:,:,i);
    end
	
	
    p_down=p_down+lambda*W;
    
    W=W.*p_up./max(p_down,eps);
    
    W=normc(W);
    for i=1:k %����HHH����
        V=VData(:,:,i);
        H_Q=H_A(:,:,i).*(V'*W)./max(H_A(:,:,i)*(W')*W+lambda*H_A(:,:,i),eps);
        H_A(:,:,i)=H_Q;
        
    end
    fprintf('ִ�д���:%d\n',count)
    W_re=W;
    H_re=H_A;
    err_re=err;
    
    
end

end


