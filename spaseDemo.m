close all
clear
clc
addpath(genpath(pwd));
path=sprintf('norm_distance/');
V1=load([path,'data0.txt']);
V2=load([path,'data1.txt']);
V3=load([path,'data2.txt']);
V4=load([path,'data3.txt']);
V5=load([path,'data4.txt']);
V6=load([path,'data5.txt']);
VData(:,:,1)=V1;
VData(:,:,2)=V2;
VData(:,:,3)=V3;
VData(:,:,4)=V4;
VData(:,:,5)=V5;
VData(:,:,6)=V6;
VData_self=zeros(117,117,6);
for i=1:117
    for count=1:6
        temp=VData(:,:,count);
        
        A=construct_A(temp,i,1);
        VData_self(:,:,count)=A;
    end
    lamda=0.01;
    tol=0.0001;
    r=3;
    ite=1000;
    change=0.001;
    
    [ W_re,H_re,err,err_data]=A_MNNF_DUG_Two(VData_self,r,tol,ite,lamda,change,0,'svd');
    V_re=A_Calc(W_re,H_re);
    [indCluster,Xout,Aout,Yout]=A_Cluster(W_re');
    
    a=indCluster(indCluster==1);
    b=indCluster(indCluster==2);
    c=indCluster(indCluster==3);
    ap=length(a)/117;
    bp=length(b)/117;
    cp=length(c)/117;
    clusterA(count,:)=[ap,bp,cp];
    
    
    TCluster=indCluster;
    for i=1:117
        if(i<=72)
            TCluster(i,1)=1;
        end
        if i<=96 && i>72
            TCluster(i,1)=2;
        end
        if i<=117 && i>96
            TCluster(i,1)=3;
        end
        
    end
    
    I =RandIndex(indCluster,TCluster);
    A_ranIndex(count)=I;
    p=purity(indCluster,TCluster);
    A_PU(count)=p;
    ARI=adjustedrand(indCluster,TCluster);
    A_AdjustranIndex(count)=ARI;
    A_nmiInfo(count)=nmi(indCluster,TCluster);
    A_finFscore(count) = getFScore(indCluster,TCluster);
end
an_min=find(A_ranIndex==max(A_ranIndex))
minSave(min_count,1)=an_min(1)
minSave(min_count,2)=max(A_ranIndex)