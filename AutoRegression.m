%Skyler Szot
%second order AR modeling practice

clear all;
close all;

syms a1 a2 h

%helicopter
% table = readtable('HelicopterFlight.xlsx');
% fsamp = 500;
% for i = 1:1,
%     data = table{:,i};
% end
% t = data;
%define original data with noise and plot
freq = 1.23456;
fsamp = 10;
t = 0:1/fsamp:10;
data = sin(freq*2*pi*t);
noise = .5.*rand(length(t),1)';
data = data + noise;
plot(t,data);
hold on;

%x = x(k), y = x(k-1), z = x(k-2)
y = data(2:length(t)-1);
z = data(1:length(t)-2);
x = data(3:length(t));

%derived equations
f1 = -2.*x.*y+2.*a2.*y.*z+2.*a1.*y.^2;
f2 = -2.*x.*z+2.*a1.*y.*z+2.*a2.*z.^2;
%solve for AR coefficients
eqns = [sum(f1)==0, sum(f2)==0];
S = solve(eqns, [a1 a2]);
%convert to double
solved_a1 = double(vpa(S.a1, 10));
solved_a2 = double(vpa(S.a2, 10));

%z transform equation for poles (h = z)
eqn = 1-(solved_a1)*h.^-1-(solved_a2)*h.^-2 == 0;
%solve for poles
solution = solve(eqn, h);
%find phase and magnitude
theta_temp = double(vpa(angle(solution), 10));
mag_temp = double(vpa(abs(solution), 10));
theta = abs(theta_temp(1));
%convert theta to frequency and display
fprintf('Original frequency :\t%d\nCalculated frequency :\t%d\n',freq,theta*fsamp/(2*pi));
%reconstruct and plot
reconstruct = sin(t*fsamp*theta);
plot(t,reconstruct);