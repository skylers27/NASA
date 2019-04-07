%Skyler Szot
%http://media.wiley.com/product_data/excerpt/25/07803601/0780360125.pdf

% File: VanDerPolSolv.m
%
% Numerical integration of Duffing-Van Der Pol Oscillator.
% Ordinary differential equation solver using in-built
% Matlab function (ode45).
%
% Uses: VanDerPol.m
% Set initial conditions for the three differential equations

clear all;
close all;

x0 = [1;0;0];
% Set integration time
timePoints = 5000:0.3:7500;
% Solve equations
options = odeset('RelTol',1e-10,'AbsTol',1e-12);
[t,x] = ode45('VanDerPol',timePoints,x0);

