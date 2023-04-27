function dist = DistMetric(startInd, endInd, Manhatten)
%DISTMETRIC 此处显示有关此函数的摘要
%   此处显示详细说明
    global rows cols;
    [row1, col1] = ind2sub([rows, cols], startInd);
    [row2, col2] = ind2sub([rows, cols], endInd);
    if Manhatten == false
        dist = sqrt((row1-row2)^2 + (col1 - col2)^2);
    else
        dist = abs(row1-row2) + abs(col1 - col2);
    end

end

