function [Radius] = Distance(Portrait, NoPoints)
%
% IN:
% Portrait: Is the matrix {Number of data points, MaxEmDim} in which
% the trajectories are contained.
% NoPoints: Is the vector {1,MaxEmDim} in which the number of valid
% points for each dimension is contained.
%
% OUT:
% Radius: Is the matrix {32,MaxEmDim} in which the difference between
% the maximum and minimum distances from one point to any other , is divided
% into 32 logarithmically equal intervals (for all dimensions).
%
% Uses: DistVectPoint.m, ElimZero.m
MaxEmDim=size(Portrait)*[0;1];
NoPointsEnd=[NoPoints 1] ;
MinDist=ones(1,MaxEmDim)*1e20;
MaxDist=zeros(1,MaxEmDim);
Radius=zeros(32,MaxEmDim);
for EmDim=1:MaxEmDim
    minval=zeros(1,EmDim);
    minloc=zeros(1,EmDim);
    maxval=zeros(1,EmDim);
    maxloc=zeros(1,EmDim);
    for i=NoPointsEnd(EmDim):-1:NoPointsEnd(EmDim+1)+1
        % Calculates the distances from point Portrait(i,1: EmDim) to all the
        % points in matrix Portrait (1:i-1,1:EmDim)
        Distances=DistVectPoint(Portrait(1:i-1,1:EmDim), Portrait(i,1:EmDim));
        % Eliminates all points with distance less than Tolerance=1e-10
        DistanceNoZero=ElimZero(Distances, 1e-10);
        [minval,minloc]=min(DistanceNoZero,[],1);
        [maxval,maxloc]=max(Distances,[],1);
        for j=1:EmDim
            if MinDist(j)>minval(j)
                MinDist(j)=minval(j);
            end
            if MaxDist(j)<maxval(j)
                MaxDist(j)=maxval(j);
            end
        end
    end
end
% Fill 32 bins (equally spaced logarithmically)
for k=1:32
    Radius(k,:)=exp(log(MinDist)+k*(log(MaxDist)-log(MinDist))/32);
end
