close all
clear
clc
addpath(genpath(pwd));

clusterA=zeros(8,3);
A_ranIndex=zeros(1,1);
A_AdjustranIndex=zeros(1,1);
A_nmiInfo=zeros(1,1);
A_PU=zeros(1,1);
A_finFscore=zeros(1,8);
label_cluter=load( 'F:\\数据\\多变量事件序列数据集\\Network\\1000\\data1\\data1label.txt');
% label_cluter=load( 'F:\\数据\\多变量事件序列数据集\\Network\\1000\\data2\\data2label.txt');
% label_cluter=load( 'F:\\数据\\多变量事件序列数据集\\Network\\1000\\data3\\data3label.txt');
label_cluter=label_cluter+1;
tol=0.0001;
r= length(unique(label_cluter));
ite=1000;
for min_count=1:7
    min_count_change=1/power(10,min_count)
    for count=1:1000
        path=sprintf('F:\\数据\\多变量事件序列数据集\\Network\\1000\\data1\\calc_net\\%d\\',count);
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
        
        
        
        change=min_count_change;
        
        [W_re,H_re,err,err_data,flag]=A_MNNF_DUG_Two(VData,r,tol,ite,change,0,'svd');
        V_re=A_Calc(W_re,H_re);
        [indCluster,Xout,Aout,Yout]=A_Cluster(W_re');
        
        
        % NMFHeatMap(Xout,Aout,Yout);
        %         try
        %             NMFHeatMap(Xout,Aout,Yout)
        %         end
        
        
        TCluster=label_cluter;
        
        
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
    save result.txt -ascii minSave
end












