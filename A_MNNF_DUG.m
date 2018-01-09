function [ W_re,H_re,err_re,err_data,hom] = A_MNNF_DUG(VData,r,tol,ite,lamda,change,plotIs,init)
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
        H_A(:,:,i)=H;
    end
    W=W_A/k;
else
    W=rand(m,r);
    W=normc(W);
    H=rand(n,r);
    H=normc(H);
    for i=1:k
        H_A(:,:,i)=H;
    end
end



last_err=1+tol;
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
    
    for i=1:k %����HHH����
        a=VData(:,:,i)'*W;
        
        b=H_A(:,:,i)*W'*W;
        
        H_Q=H_A(:,:,i);
        for i_1=1:n
            for j_1=1:r
                if b(i_1, j_1)~= 0
                    fprintf('���ڼ�����....����H_Q......��\n');
                    H_Q(i_1, j_1)= H_Q(i_1, j_1) * a(i_1, j_1) / (b(i_1, j_1)+lamda*H_Q(i_1, j_1));
                end
            end
            
        end
        H_A(:,:,i)=H_Q;
    end
    %
    %     for update_index=1:k
    %         H=H_A(:,:,update_index);
    %         H=H./(ones(n,1)*sum(H));
    %         H_A(:,:,i)=H;
    %     end
    
    c=zeros(m,r);
    for i=1:k
        c=c+VData(:,:,i)*H_A(:,:,i);
    end
    
    d=zeros(m,r);
    for i=1:k
        d=d+W*H_A(:,:,i)'*H_A(:,:,i);
    end
    
    for i_2=1:m
        for j_2=1:r
            if d(i_2, j_2)~= 0
                fprintf('���ڼ�����....����W......��\n');
                W(i_2,j_2) = W(i_2,j_2) * c(i_2,j_2) / (d(i_2, j_2)+lamda*W(i_2, j_2));
            end
        end
    end
    %     W=W./(ones(m,1)*sum(W));
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

