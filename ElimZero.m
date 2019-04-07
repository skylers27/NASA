function DistanceNoZero=ElimZero(Distance, Tolerance)
%
% Replaces all points with distance less than Tolerance with le20.
% This is necessary in the bin-filling algorithm.
%
% IN:
% Distance: Is a matrix {n,MaxDim} that contains the distances from
% 'point' to all other points in 'data' (for dimensions 1 to MaxDim).
% Tolerance: Is a scalar that determines the minimum distance to be considered.
%
% OUT:
% DistanceNoZero: Is a matrix {n,MaxDim} equal to Distance, but with all
% elements smaller than Tolerance replaced with le20
SigDist=Distance-Tolerance;
SigDist=((sign(sign(SigDist.*-1)-0.5))+1)*1e20;
DistanceNoZero=Distance+SigDist;