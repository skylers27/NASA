function [diff] = euclidian_distance(a,b)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
diff = 0;
for i = 1:length(a)
    temp = (a(i)-b(i)).^2;
    diff = diff + temp;
end
end

