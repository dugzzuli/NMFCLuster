function X=A__REData(flag)
if flag==1
    W=zeros(12,3);
    H_Data=zeros(12,3,3);
    for i=1:12
        if(i<=4)
            W(i,1)=1;
        end
        if(5<=i&&i<=8)
            W(i,2)=1;
        end
        if(9<=i&&i<=12)
            W(i,3)=1;
        end
    end
    
    for i=1:12
        if(i<=4)
            H_Data(i,1,1)=1;
        end
        if(5<=i&&i<=8)
            H_Data(i,2,2)=1;
        end
        if(9<=i&&i<=12)
            H_Data(i,3,3)=1;
        end
    end
    X=zeros(12,12,3);
    for i=1:3
        B=W*H_Data(:,:,i)';
        B=B+diag(-diag(B));
        X(:,:,i)=B;
        
    end
elseif flag==2
    X=zeros(12,12,6);
    S=zeros(12,12);
    for i=1:12
        for j=1:12
            if(i<=4 && j<4)
                S(i,j)=1;
            elseif i<=8 && i>4 &&j<=8 && j>4
                      S(i,j)=1;
               elseif i<=12 && i>8 &&j<=12 && j>8 
                     S(i,j)=1;
            end
            
        end
    end
    for z=1:6
        X(:,:,z)=S;
    end
end
end
