function [BinCount]=BinFilling(Portrait,NoPoints,Radius)
%
% IN:
% Portrait: Is the matrix {Number of data points, MaxEmDim} in which the
% trajectories are contained.
% NoPoints : Is the vector {l,MaxEmDim} in which the number of points for each
% dimension is contained.
% Radius: Is the matrix {32,MaxEmDim} in which the difference between the
% maximum and minimum distances from one point to any other , is divided into
% 32 logarithmically equal intervals (for all dimensions)
%
% OUT:
% BinCount: Is a matrix {32 ,MaxEmDim} with the total count of pair of points
% with a distance smaller than that specified by Radius for the 32 intervals.
%
% Uses: DistVectPoint.m, CountPoints.m
MaxEmDim=size(Portrait)*[0;1];
BinCount=zeros(32,MaxEmDim);
NoPointsEnd=[NoPoints 1] ;
for EmDim=1:MaxEmDim
    for i=NoPointsEnd(EmDim):-1:NoPointsEnd(EmDim+1)+1
        Distances=zeros(i-1,EmDim);
        Distances=DistVectPoint(Portrait(1:i-1,1:EmDim),Portrait(i,1:EmDim));
        for j=1:32
            BinCount(j,1:EmDim)=BinCount(j,1:EmDim) + CountPoints(Distances,Radius(j,1:EmDim));
        end
    end
end
BinCount=BinCount./(((ones(32,1)*NoPoints).*(ones(32,1)*NoPoints-1))/2);
