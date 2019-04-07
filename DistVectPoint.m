function [Distance]=DistVectPoint(data,point)
%
% This function calculates the distance from all elements of the matrix
% {n,MaxDim} to the point {l,MaxDim}, for all the dimensions.
%
% IN:
% data: Is a matrix {n,MaxDim} of n points to which 'point' is going to be compared.
% point: Is a vector {1,MaxDim} that represents the 'point' in MaxDim
% dimensions.
% OUT:
% Distance: Is a matrix {n,MaxDim} that contains the distances from
% 'point' to all other points in 'data' (for dimensions 1 to MaxDim).
%
% Example: data=[ 0
% 0
% 0
% 1
% 1
% point=[ 0
% Distance=[ 0
% 0
% 0
% 1.0000
% 1.0000
Diffe=zeros(size(data));
for i=1:size(data)*[0;1]
    Diffe(:,i) = data(:,i)-point(i);
end
% Calculate Euclidean distance
Diffe=Diffe.^2;
Distance=cumsum(Diffe,2);
Distance=sqrt(Distance);