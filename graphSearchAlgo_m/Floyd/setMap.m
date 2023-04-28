function [map] = setMap(obsRate,pStart,pEnd)
%SETMAP 此处显示有关此函数的摘要
%   此处显示详细说明
global rows cols;

cmap = [1 1 1; ...       % 1-白色-空地
    0 0 0; ...           % 2-黑色-静态障碍
    1 0 0; ...           % 3-红色-动态障碍
    1 1 0;...            % 4-黄色-起始点 
    1 0 1;...            % 5-品红-目标点
    0 1 0; ...           % 6-绿色-到目标点的规划路径   
    0 1 1];              % 7-青色-动态规划的路径

% 构建颜色MAP图
colormap(cmap);

map = ones(rows,cols);
obsNum = floor(obsRate * (rows * cols));
obsList = randi([1, rows * cols], obsNum, 1); % transfer to linear index
map(obsList) = 2; % matrix(linear index)
map(pStart) = 4;
map(pEnd) = 5;
end

