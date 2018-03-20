close all
clear
clc
addpath(genpath(pwd));
A_ranIndex=zeros(5,5);
for data_index=1:5
    label_cluter=load(sprintf( 'F:\\数据\\多变量事件序列数据集\\Network\\1000\\data%d\\data%dlabel.txt',data_index,data_index));
    label_cluter=label_cluter+1;
    numberOfCluster= length(unique(label_cluter));
    for HMM_state=1:5
        mat=load( sprintf('F:\\data\\HMM%d\\mat%d.txt',data_index,HMM_state));
        [ clusteredData,result,clusterCenter_id ] = clusteringPearsonPAM(mat, numberOfCluster);
        I =RandIndex(label_cluter,result);
        A_ranIndex(data_index,HMM_state)=I;
    end
end