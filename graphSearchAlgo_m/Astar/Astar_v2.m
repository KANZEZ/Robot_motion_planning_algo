%%

%%% A* implement using priority queue(min heap) 

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

% create parent matrix, map matrix[linear index, distance] and pos matrix
% for record heap changes: pos[mapIndex or (minHeap(heapIndex,1))] = heapIndex
global minHeap pos heapSize;  
heapSize = rows*cols;
minHeap = zeros(rows*cols, 3);
pos = zeros(rows*cols, 1);
parent = zeros(rows*cols, 1);
for i = 1:rows*cols
    parent(i) = i;
    minHeap(i,1) = i;
    minHeap(i,2) = inf;
    minHeap(i,3) = inf;
    pos(i) = minHeap(i,1);
end


% initialize
minHeap(pStart, 2) = 0;
minHeap(pStart, 3) = minHeap(pStart, 2) + Hfunc(pStart, pEnd, false);
count = 1;
changeHeap(pStart); % maintain min heap


%%
flag = 0;
while heapSize ~= 0
    curNode = dequeue();
    count = count + 1;
    curNodeInd = curNode(1);
    if curNodeInd == pEnd
        flag = 1;
        break;
    end
    curNodeWeight = curNode(2); 
    curNodeTotalCost = curNode(3); % parent info
    
    adjList = findAdj(map, curNodeInd);  % childs list of parent
    if isempty(adjList)
        break
    end

    for i = 1 : size(adjList, 1)
        curChildInd = adjList(i, 1);
        cost = adjList(i, 2);
        heapInd = pos(curChildInd);
        curChildWeight = minHeap(heapInd, 2);
        if heapInd <= heapSize && curNodeWeight + cost <= curChildWeight
            minHeap(heapInd, 2) = curNodeWeight + cost;
            minHeap(heapInd, 3) = minHeap(heapInd, 2) + Hfunc(curChildInd, pEnd, false);
            changeHeap(heapInd);
            parent(curChildInd) = curNodeInd;
        end
    end
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
 


