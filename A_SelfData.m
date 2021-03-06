close all
clear
clc
addpath(genpath(pwd));



clusterA=zeros(8,3);
A_ranIndex=zeros(1,8);
A_AdjustranIndex=zeros(1,8);
A_nmiInfo=zeros(1,8);
A_PU=zeros(1,8);
A_finFscore=zeros(1,8);
indClusterALL=zeros(12,8);
step=0.01;
for min_count=1:1
    for count=671:671
        path=sprintf('calc_net/%d/',count);
        V1=load([path,'data0.txt']);
        
        V2=load([path,'data1.txt']);
        V3=load([path,'data2.txt']);
        V4=load([path,'data3.txt']);
        V5=load([path,'data4.txt']);
        V6=load([path,'data5.txt']);
        
        %     VData(:,:,1)=V1+diag(-diag(V1));
        %     VData(:,:,2)=V2+diag(-diag(V2));
        %     VData(:,:,3)=V3+diag(-diag(V3));
        %     VData(:,:,4)=V4+diag(-diag(V4));
        %     VData(:,:,5)=V5+diag(-diag(V5));
        %     VData(:,:,6)=V6+diag(-diag(V6));
        
        VData(:,:,1)=V1;
        VData(:,:,2)=V2;
        VData(:,:,3)=V3;
        VData(:,:,4)=V4;
        VData(:,:,5)=V5;
        VData(:,:,6)=V6;
        
        lamda=step*min_count;
        tol=0.0001;
        r=3;
        ite=1000;
        change=0.001;
        
        [ W_re,H_re,err,err_data,~,last_err]=A_MNNF_DUG(VData,r,tol,ite,lamda,change,1,'svd');
        V_re=A_Calc(W_re,H_re);
        [indCluster,Xout,Aout,Yout]=A_Cluster(W_re');
        indClusterALL(:,count)=indCluster;
        a=indCluster(indCluster==1);
        b=indCluster(indCluster==2);
        c=indCluster(indCluster==3);
        ap=length(a)/12;
        bp=length(b)/12;
        cp=length(c)/12;
        clusterA(count,:)=[ap,bp,cp];
        
        
        TCluster=indCluster;
        for i=1:12
            if(i<=4)
                TCluster(i,1)=1
            end
            if i<=8 && i>4
                TCluster(i,1)=2;
            end
            if i<=12 && i>8
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
end












