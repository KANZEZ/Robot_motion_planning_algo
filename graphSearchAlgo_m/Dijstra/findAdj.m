function adjList = findAdj(map, curNode, rows, cols)
%FINDADJ: return adjacency list[linear index, weight] of current node(also linear index)

[curRow, curCol] = ind2sub([rows,cols], curNode);
adjList = [];

for i = -1 : 1
    for j = -1 : 1
        if curRow + i >= 1 && curRow + i <= rows && curCol + j >= 1 && curCol + j <= cols
            if i == 0 && j == 0
                continue
            end
            if map(curRow + i, curCol + j) ~= 2
                adjList = [adjList; [sub2ind([rows, cols], curRow + i, curCol + j), sqrt(i^2 + j^2)]];
            end
        end
    end
end
end

