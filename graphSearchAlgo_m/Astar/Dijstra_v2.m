%%

%%% dijstra implement using priority queue(min heap) 

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

% create parent matrix, map matrix[linear index, distance] and pos matrix
% for record heap changes: pos[mapIndex or (minHeap(heapIndex,1))] = heapIndex
global minHeap pos heapSize;  
heapSize = rows*cols;
minHeap = zeros(rows*cols, 1);
pos = zeros(rows*cols, 1);
parent = zeros(rows*cols, 1);
for i = 1:rows*cols
    parent(i) = i;
    minHeap(i,1) = i;
    minHeap(i,2) = inf;
    pos(i) = minHeap(i,1);
end


% initialize
minHeap(pStart, 2) = 0;
changeHeap(pStart); % maintain min heap


%%
while heapSize ~= 0
    curNode = dequeue();
    curNodeInd = curNode(1);
    if curNodeInd == pEnd
        break;
    end
    curNodeWeight = curNode(2); % parent info
    
    adjList = findAdj(map, curNodeInd, rows, cols);  % childs list of parent

    for i = 1 : size(adjList, 1)
        curChildInd = adjList(i, 1);
        cost = adjList(i, 2);
        heapInd = pos(curChildInd);
        curChildWeight = minHeap(heapInd, 2);
        if heapInd <= heapSize && curNodeWeight + cost <= curChildWeight
            minHeap(heapInd, 2) = curNodeWeight + cost;
            changeHeap(heapInd);
            parent(curChildInd) = curNodeInd;
        end
    end
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
 


