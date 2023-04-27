%%
%%% A* (Euler distance) implement using traditional method- Dijstra algo logic
clc
clear
close all

%%
% map setting
global rows cols;
rows = 100;
cols = 100;
pStart = 10000;
pEnd = 1;
obsRate = 0.8;
map = setMap(obsRate, pStart, pEnd);


%%
% create parent matrix, map matrix[linear index, d = distance, f = d + H] and if visited matrix
mapMatrix = zeros(rows*cols, 3);
parent = zeros(rows*cols, 1);
visited = zeros(rows*cols, 1);
for i = 1:rows*cols
    parent(i) = i;
    mapMatrix(i,1) = i;
    mapMatrix(i,2) = inf;
    mapMatrix(i,3) = inf;
end

% initialize
mapMatrix(pStart, 2) = 0;
mapMatrix(pStart, 3) = mapMatrix(pStart, 2) + Hfunc(pStart, pEnd, false);
count = 1;

%%
flag = 0;
while count <= rows * cols
    parentInd = findMin(mapMatrix, visited);
    if parentInd == pEnd
        flag = 1;
        break;
    end
    visited(parentInd) = 1;
    parentWeight = mapMatrix(parentInd, 2);
    parentTotalCost = mapMatrix(parentInd, 3);
    adjList = findAdj(map, parentInd);
    if isempty(adjList) == 1
        break
    end

    for i = 1 : size(adjList, 1)
        curChildInd = adjList(i, 1);
        cost = adjList(i, 2);
        curChildWeight = mapMatrix(curChildInd, 2);
        if visited(curChildInd) == 0 && parentWeight + cost <= curChildWeight
            mapMatrix(curChildInd, 2) = parentWeight + cost;
            mapMatrix(curChildInd, 3) = mapMatrix(curChildInd, 2) + Hfunc(curChildInd, pEnd, false);
            parent(curChildInd) = parentInd;
        end
    end
    count = count + 1;
end


%%
% mark the map
ind = pEnd;
if flag == 1
    while ind ~= pStart
        map(ind) = 6;
        ind = parent(ind);
    end
end
map(pEnd) = 5;


%%
im = image(1.5,1.5,map);
grid on;
set(gca,'gridline','-','gridcolor','k','linewidth',2,'GridAlpha',0.5);
set(gca,'xtick',1:cols+1,'ytick',1:rows+1);
axis image;



