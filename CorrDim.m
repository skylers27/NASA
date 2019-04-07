% File: CorrDim.m
%
% Implements the Grassberger-Procaccia algorithm to measure the correlation
% dimension (data assumed tobe stored in matrix 'x' f rom VanDerPolSolve . m) .
%
% Uses: Distance.m, BinFilling.m, Slope.m
% Transform x3 to sin(x3)
clear all;
close all;

%DIMENSION OF DATA
MaxEmDim=1;

%LORENZ INPUT
% [d1 d2 d3] = lorenz(28, 10, 8/3);   %generate lorenz chaotic time series
% x = zeros(length(d1),3);            %correlation dimension = ~2
% x(:,1) = d1;
% x(:,2) = d2;
% x(:,3) = d3;

% %HELICOPTER INPUT
% filedata = xlsread('Flap_all.xls');
% dataset = 5; %1 = hover, 2 = trans, 3 = adv17, 4 = adv27, 5 = adv32
% x = zeros(length(filedata(:,dataset)),3);
% x(:,1) = filedata(:,dataset);
% x(:,2) = filedata(:,dataset); 
% x(:,3) = filedata(:,dataset);

%LINEAR INPUT
dataset = 1;
Ts = 1/100;
t = Ts:Ts:10;
%noise = .0000001.*randn(1,length(t));
filedata = sqrt(t);
x(:,1) = filedata;
x(:,2) = filedata;
x(:,3) = filedata;

%implement autocorrelation function - page 15

xnew=x;
xnew(:,3)=sin(x(:,3));
% Number of valid points in xnew matrix.
NoPoints=[size(xnew)*[1;0] size(xnew)*[1;0] size(xnew)*[1;0]];
% Calculates 32 equi-spaced bins on a logarithmic scale
[Radius]=Distance(xnew, NoPoints);
% Fills bins with the number of pairs of points with separation given by Radius .
[BinCount]=BinFilling(xnew,NoPoints,Radius);
% Normalizes the matrix Radius, by its maximum value
% (for each dimension independently).
for i=1:MaxEmDim
    max=Radius(32,i);
    RadiusNormal(:,i)=Radius(:,i)/max;
end
% Plots the BinCount for specific Radius for all Embedding Dimensions,
figure(1);
for i=1:MaxEmDim
    if i==1
        hold off
    end
    loglog(RadiusNormal(:,i),BinCount(:,i),'+-');
    if i==1
        hold on
    end
end
% Plot correlation Integral
ok=1;
title(strcat('Correlation Integral'));
xlabel(strcat('% of Maximum Radius, MaxEmDim=',num2str(MaxEmDim) ,')'));
ylabel('% of Number of Points');
% Find the slope for all the dimensions,
for i=1:MaxEmDim
    [Slopes(i), SlopeErrors(i)]=Slope(Radius(:,i), BinCount(:,i), 0.6, 0.125);
end
% Plot Fractal Dimensions
figure(2)
Dim=1:MaxEmDim;
errorbar(Dim,Slopes,SlopeErrors, 'b*-' );
axis([0 MaxEmDim+1 0 MaxEmDim]);
grid on
zoom on;
title(strcat('Data Set: ','Duffing VanDerPol Oscillator'));
xlabel('Dimension');
ylabel('Fractal Dimension');

%additional display
if dataset == 1
    fprintf('Hover\n');
elseif dataset == 2
    fprintf('Trans\n');
elseif dataset == 3
    fprintf('Adv17\n');
elseif dataset == 4
    fprintf('Adv27\n');
elseif dataset == 5
    fprintf('Adv32\n');
end

fprintf(['Correlation Dimension: ',num2str(Slopes(MaxEmDim)), ' +/- ', num2str(SlopeErrors(MaxEmDim)),'\n']);