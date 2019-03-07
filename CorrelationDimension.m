%Correlation Dimension
%Skyler Szot

clear all;
close all;

[x,y,z] = lorenz(28, 10, 8/3); %generate lorenz chaotic time series
%plot3(x,y,z); %plot
x = downsample(x,10); %downsample x for speed
C = [];

for i = 1:250   %for diffrent r thresholds
    C = [C, get_correlation_integral(x,i,30)]; %get correlation coefficient
end

i = [1:250]; %x axis

%log scale
X = log10(i);
Y = log10(C);

plot(X,Y) %plot

coefs = polyfit(X(50:100), Y(50:100), 1)