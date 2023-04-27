function minEle = dequeue()
%TEST 此处显示有关此函数的摘要
%   此处显示详细说明
    global minHeap pos heapSize;
    if heapSize == 0
        return;
    end

    minEle = minHeap(1,:);
    pos(minHeap(heapSize,1)) = 1;
    pos(minHeap(1,1)) = heapSize;
    minHeap(1,:) = minHeap(heapSize,:);
    heapSize = heapSize - 1;
    %obj.Heap = obj.Heap(1: obj.heapSize, :);
    ind = 1;
    while ind <= heapSize
        left = 2*ind;
        if left > heapSize
            break;
        end
        right = left + 1;
        if right <= heapSize && minHeap(right, 2) < minHeap(left, 2)
            left = right;
        end
        if minHeap(left, 2) >= minHeap(ind, 2)
            break
        end
        pos(minHeap(left, 1)) = ind;
        pos(minHeap(ind, 1)) = left;

        temp = minHeap(left, :);
        minHeap(left, :) = minHeap(ind, :);
        minHeap(ind, :) = temp;
        ind = left;
    end
end

