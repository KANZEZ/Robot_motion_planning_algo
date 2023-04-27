function ind = findMin(mapMatrix, visited)
%FINDMIN 此处显示有关此函数的摘要
%   此处显示详细说明
    global rows cols;
    minVal = inf;
    ind = 0;
    for i = 1 : rows * cols
        if visited(i) == 0 && minVal >= mapMatrix(i, 3)
            minVal = mapMatrix(i, 3);
            ind = mapMatrix(i, 1);
        end
    end
end

