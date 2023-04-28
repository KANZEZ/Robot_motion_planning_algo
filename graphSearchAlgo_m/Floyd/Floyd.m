%%
% O(V^3)
% 对Floyd的理解
% 对于graph中的每一对顶点u-v的最短路径只有一种情况，u，v之间至少存在一个顶点k（k也可能是u或v），
% 使得 u-k-v最短。基于如上两种情况，我们暴力遍历graph中的每一对顶点u-v，并找到所谓的k顶点使得距离最短
% 当遍历完成之后，图中所有顶点对u-v都有其对应的k顶点，使其u-v距离最短，因此对于start-end顶点，我们能找到一个
% 对应的k0顶点,使得start-end
% 这一段最短，对于追踪start-end的最短路径，当我们找到k0时，我们还能找到k0-end顶点对所对应的顶点k1，使得ko-end
% 这一段最短，依此类推，最终在end顶点停下，得到完整路径
%

clc
clear
%%
global rows cols distMap nextMap map;
rows = 8;
cols = 8;
distMap = inf(rows*cols, rows*cols);
nextMap = -1*ones(rows*cols, rows*cols);
pStart = 1;
pEnd =64;

map = setMap(0.5, pStart, pEnd);

% construct dist map
createDistMap();
numNode = rows*cols;

%%
for k = 1 : numNode
    for i = 1 : numNode
        for j = 1 : numNode
            if distMap(i,j) > distMap(i, k) + distMap(k, j)
                distMap(i,j) = distMap(i, k) + distMap(k, j);
                nextMap(i,j) = nextMap(i,k);
            end
        end
    end
end

%% read
p = pStart;
while(p ~= pEnd)
    p = nextMap(p, pEnd);
    if p == -1
        break;
    end
    map(p) = 6;
end
map(pEnd) = 5;
%%
im = image(1.5,1.5,map);
grid on;
set(gca,'gridline','-','gridcolor','k','linewidth',2,'GridAlpha',0.5);
set(gca,'xtick',1:cols+1,'ytick',1:rows+1);
axis image;


