%%
%%% dijstra implement using traditional method- prim algo logic
clc
clear
close all

%%
% map setting
rows = 100;
cols = 100;
pStart = 10000;
pEnd = 1;
obsRate = 0.4;
map = setMap(rows, cols, obsRate, pStart, pEnd);


%%
% create parent matrix, map matrix[linear index, distance] and if visited matrix
mapMatrix = zeros(rows*cols, 1);
parent = zeros(rows*cols, 1);
visited = zeros(rows*cols, 1);
for i = 1:rows*cols
    parent(i) = i;
    mapMatrix(i,1) = i;
    mapMatrix(i,2) = inf;
end

% initialize
mapMatrix(pStart, 2) = 0;
count = 1;

%%
while count <= rows * cols
    parentInd = findMin(mapMatrix, visited, rows, cols);
    if parentInd == pEnd
        break;
    end
    visited(parentInd) = 1;
    parentWeight = mapMatrix(parentInd, 2);
    adjList = findAdj(map, parentInd, rows, cols);

    for i = 1 : size(adjList, 1)
        curChildInd = adjList(i, 1);
        cost = adjList(i, 2);
        curChildWeight = mapMatrix(curChildInd, 2);
        if visited(curChildInd) == 0 && parentWeight + cost <= curChildWeight
            mapMatrix(curChildInd, 2) = parentWeight + cost;
            parent(curChildInd) = parentInd;
        end
    end
    count = count + 1;
end


%%
% mark the map
ind = pEnd;

while ind ~= pStart
    map(ind) = 6;
    ind = parent(ind);
end
map(pEnd) = 5;


%%
im = image(1.5,1.5,map);
grid on;
set(gca,'gridline','-','gridcolor','k','linewidth',2,'GridAlpha',0.5);
set(gca,'xtick',1:cols+1,'ytick',1:rows+1);
axis image;



