function createDistMap()
%DISTMAP 此处显示有关此函数的摘要
%   此处显示详细说明
    global rows cols distMap nextMap map;
    for i = 1 : rows
        for j = 1 : cols
            ind = sub2ind([rows, cols], i, j);
            distMap(ind,ind) = 0;
            nextMap(ind,ind) = ind;
            adjList = findAdj(map, ind);
            if ~isempty(adjList)
                for k = 1 : size(adjList,1)
                    distMap(ind, adjList(k,1)) = adjList(k,2);
                    nextMap(ind, adjList(k,1)) = adjList(k,1);
                end
            end
        end
    end
end

