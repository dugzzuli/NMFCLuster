close all
clear
clc
addpath(genpath(pwd));
% 随机生成数据
% for i=1:6
%     B=load('net/data%d.txt',i);
%     B=B+diag(-diag(B));
%     VData(:,:,i)=B;
% end



% V1=load('net/data0.txt');
% V2=load('net/data1.txt');
% V3=load('net/data2.txt');
% V4=load('net/data3.txt');
% V5=load('net/data4.txt');
% V6=load('net/data5.txt');


% V1=load('D:/pythonwork/NMFZhou/version_2/net/4/data0.txt');
% V2=load('D:/pythonwork/NMFZhou/version_2/net/4/data1.txt');
% V3=load('D:/pythonwork/NMFZhou/version_2/net/4/data2.txt');
% V4=load('D:/pythonwork/NMFZhou/version_2/net/4/data3.txt');
% V5=load('D:/pythonwork/NMFZhou/version_2/net/4/data4.txt');
% V6=load('D:/pythonwork/NMFZhou/version_2/net/4/data5.txt');
% 组装为三片数据 三维


%
% VData(:,:,1)=V1;
% VData(:,:,2)=V2;
% VData(:,:,3)=V3;
% VData(:,:,4)=V4;
% VData(:,:,5)=V5;
% VData(:,:,6)=V6;

%
% VData(:,:,1)=V1+diag(-diag(V1));
% VData(:,:,2)=V2+diag(-diag(V2));
% VData(:,:,3)=V3+diag(-diag(V3));
% VData(:,:,4)=V4+diag(-diag(V4));
% VData(:,:,5)=V5+diag(-diag(V5));
% VData(:,:,6)=V6+diag(-diag(V6));


clusterA=zeros(8,3);
A_ranIndex=zeros(1,8);
A_AdjustranIndex=zeros(1,8);
A_nmiInfo=zeros(1,8);
A_PU=zeros(1,8);
A_finFscore=zeros(1,8);
indClusterALL=zeros(12,8);
% for min_count=1:10
    for count=1:1
        path=sprintf('selfData_non/%d/',count);
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
        boxplot(reshape(VData,1,864))
        max_V=max(reshape(VData,1,864));
        min_V=min(reshape(VData,1,864));
        
       
        
    end

% end












