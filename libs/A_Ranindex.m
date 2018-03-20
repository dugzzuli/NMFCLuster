TCluster=indCluster;
for i=1:117
    if(i<=72)
    TCluster(i,1)=1
    end
    if i<=96 && i>72
    TCluster(i,1)=2;
    end
      if i<=117 && i>96
    TCluster(i,1)=3;
    end
    
end
I =RandIndex(indCluster,TCluster);
A=indCluster'
B=TCluster'