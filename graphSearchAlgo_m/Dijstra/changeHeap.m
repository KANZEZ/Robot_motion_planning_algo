function changeHeap(headInd)
%CHANGEHEAP 此处显示有关此函数的摘要
%   此处显示详细说明
    global minHeap pos;
    curInd = headInd;
    while curInd > 1
        far = floor(curInd/2);
        if minHeap(far, 2) >= minHeap(curInd, 2)
            %swap pos
            pos(minHeap(far, 1)) = curInd;
            pos(minHeap(curInd, 1)) = far;
            %swap heap
            temp = minHeap(far, :);
            minHeap(far, :) = minHeap(curInd, :);
            minHeap(curInd, :) = temp;
        end
        curInd = far;
    end
end

