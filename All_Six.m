close all
clear
clc
addpath D:/work/NMFCLUSTER/libs/nmf
path=sprintf('D:/pythonwork/NMFZhou/version_2/calc_net/45/');
V1=load([path,'data0.txt']);
V2=load([path,'data1.txt']);
V3=load([path,'data2.txt']);
V4=load([path,'data3.txt']);
V5=load([path,'data4.txt']);
V6=load([path,'data5.txt']);
% 将前几个相加
D=V1+V2+V3+V4+V5+V6;
% 将大于0的边赋值为1
D(D>0)=1;


