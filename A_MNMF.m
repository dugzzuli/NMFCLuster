clear
clc
close all
loadpath
% 随机生成数据
% V1=load('data/data.txt');
% V2=load('data/data.txt');
% V3=load('data/data.txt');;
% % 组装为三片数据 三维
% VData(:,:,1)=V1;
% VData(:,:,2)=V2;
% VData(:,:,3)=V3;


VData=A__REData(2);
lamda=0.2;
tol=0.001;
r=3;
ite=10000;
change=0.1;
[ W_re,H_re,err,err_data]=A_MNNF_DUG_Two(VData,r,tol,ite,lamda,change,0);
V_re=A_Calc(W_re,H_re);











