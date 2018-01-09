function drawdataset(dataset,label)
[n,m] = size(dataset);
if nargin == 1
    label = ones(1,n);
end
colorNumber = max(label);
colorMode = char('r+','b+','g+','y+','ro','bo','go','yo','rx','bx','gx','yx','r.','b.','g.','y.');

for i = 1:colorNumber
    colorAndMode = colorMode(i,:);
    theNum = find(label==i);
switch m
    case 2
        plot(dataset(theNum,1),dataset(theNum,2),colorAndMode);
    case 3
        plot3(dataset(theNum,1),dataset(theNum,2),dataset(theNum,3),colorAndMode);
    otherwise
        error('cant draw');

end
hold on
end
end


