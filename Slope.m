function [Slope, SlopeError]=Slope(RadiusV, BinCountV, center, high)
%
% This function gives the slope and error for a line (in a logarithmic scale)
% given by the points RadiusV, BinCountV. The only relevant points are the ones
% that are contained in the band center-high/2, center+high/2.
%
% The values for center define the position of the center of the band and can
% range from 0 to 1 with 1 at the top.
%
% IN:
% RadiusV: Vector with the radii limits of a specific Dimension.
% BinCountV: Vector containing the counts of pairs of elements with distance
% smaller than radius.
% Center: Center position where the slope is to be evaluated.
% High: Band size around center.
%
% OUT:
% Slope: Slope evaluated in the region center-high/2, center+high/2.
% SlopeError: Error of the evaluated fitted line to the original data.
lnRadiusV=log(RadiusV);
lnBinCountV=log(BinCountV);
Max=0;
Min=lnBinCountV(1);
IntervalHigh=(Max-Min)*high;
Top=-((Max-Min)*(1-center))+(IntervalHigh/2);
Base=-((Max-Min)*(1-center))-(IntervalHigh/2);
k=1;
for i=1:32
    if ((lnBinCountV(i)>=Base && lnBinCountV(i)<=Top))
        RelDataX(k)=lnRadiusV(i);
        RelDataY(k)=lnBinCountV(i);
        k=k+1;
    end
end
[P,S]=polyfit(RelDataX,RelDataY,1);
Slope=P(1);
SlopeError=S.normr;