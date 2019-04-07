function [CountVect]=CountPoints(Distances,Threshold)
%
% IN:
% Distance: Is amatrix {n,MaxDim} that contains the distances from 'point'
% to all other points in 'data' for dimensions 1 to MaxDim.
% Threshold: Is the upper bound on Distance.
%
% OUT:
% CountVect: Is a vector {l,MaxDim] with the count of distances smaller
% than Threshold
VectLength=length(Threshold);
NumOfPoints=size(Distances)*[1;0];
CountVect=zeros(1,VectLength);
ThresholdMatr=ones(NumOfPoints,1)*Threshold;
CountVect=sum((Distances<ThresholdMatr),1);