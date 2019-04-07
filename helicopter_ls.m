%Skyler Szot
%least squares method
%

clear all;
close all;

syms h

%HELICOPTER INPUT
filedata = xlsread('Flap_all.xls');
x = filedata(:,1); %read hover
fsamp = 500; %sample rate
Ts = 1/fsamp;

% %LINEAR INPUT
% Ts = 1/100;
% t = Ts:Ts:10;
% noise = .01.*randn(1,length(t));
% filedata = cos(2*pi*3.2346*t)+noise;
% x = filedata;

cutoffa = 1; %pass frequecies
cutoffb = 10;
cutoff1 = cutoffa*2*Ts; %calculate percentage of nyquist frequency
cutoff2 = cutoff1 + .0001; %increase slightly for next point
cutoff3 = cutoffb*2*Ts;
cutoff4 = cutoff3 + .0001;
freqs =[0 cutoff1 cutoff2 cutoff3 cutoff4 1]; 
amps=[0 0 1 1 0 0];
b=firpm(1000,freqs,amps); %specify the HP filter 
yhp=filter(b,1,x); %do the filtering 
x = yhp;

m = ar(x,4,'ls','Ts',Ts)
a = polydata(m);

eqn = a(1) + a(2)*h.^-1 + a(3)*h.^-2 + a(4)*h.^-3 + a(5)*h.^-4 == 0;
%solve for poles
solution = solve(eqn, h);
%find phase and magnitude
theta_temp = double(vpa(angle(solution), 10))*((1/Ts)/(2*pi))
mag_temp = double(vpa(abs(solution), 10));
theta = abs(theta_temp(length(theta_temp)));
%convert theta to frequency and display
fprintf('Calculated frequency :\t%d\n',theta);