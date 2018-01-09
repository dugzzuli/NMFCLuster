clear
clc
close all
loadpath
% D=load('data/data.txt');
D=load('selfData/23/data0.txt');

k=3;
% % Directly call a NMF algorithm to obtain the factor matrices.
% [A,Y]=nmfnnls(D,k);
% % Then clustering.
% [indCluster,Xout,Aout,Yout]=NMFCluster(Y);
[W,H,numIter,tElapsed,finalResidual]=nmfnnls(D,k);

[indCluster,Xout,Aout,Yout]=NMFCluster(H);
a=indCluster(indCluster==1);
b=indCluster(indCluster==2);
c=indCluster(indCluster==3);
TCluster=indCluster;
for i=1:12
    if(i<=4)
        TCluster(i,1)=1;
    end
    if i<=8 && i>4
        TCluster(i,1)=2;
    end
    if i<=12 && i>8
        TCluster(i,1)=3;
    end
    
end
count=1;
I =RandIndex(indCluster,TCluster);
A_ranIndex(count)=I;
p=purity(indCluster,TCluster);
A_PU(count)=p;
ARI=adjustedrand(indCluster,TCluster);
A_AdjustranIndex(count)=ARI;
A_nmiInfo(count)=nmi(indCluster,TCluster);
A_finFscore(count) = getFScore(indCluster,TCluster);

% NMFHeatMap(Xout,Aout,Yout);
% NMFHeatMap(Xout,Aout,Yout)
% HeatMap(Yout)


