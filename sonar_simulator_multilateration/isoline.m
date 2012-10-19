function [ yi] = isoline(x, y, v)
%ISOLINE Summary of this function goes here
%   Detailed explanation goes here

sigma = 1;

if length(x) ~= length(y) || length(x) ~= length(v) || length(y) ~= length(v)
    error('Vectors x y and v must have the same length');
end

X = [];
Y = [];

for i = 1:length(v)
    if v(i) < sigma && isnan(v(i)) ~= true
       X = [X x(i)];
       Y = [Y y(i)];
    end
end
figure;
scatter(X,Y);

yi = interp1(X,Y,x);

