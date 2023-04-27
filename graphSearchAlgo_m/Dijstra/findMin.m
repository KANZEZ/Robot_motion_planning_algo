function ind = findMin(mapMatrix, visited, rows, cols)
%FINDMIN 此处显示有关此函数的摘要
%   此处显示详细说明
    minVal = inf;
    ind = 0;
    for i = 1 : rows * cols
        if visited(i) == 0 && minVal >= mapMatrix(i, 2)
            minVal = mapMatrix(i, 2);
            ind = mapMatrix(i, 1);
        end
    end
end

