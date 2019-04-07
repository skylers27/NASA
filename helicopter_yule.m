%Skyler Szot
%yule walker method
%method - https://www.mathworks.com/help/signal/examples/linear-prediction-and-autoregressive-modeling.html
%paper- https://www.researchgate.net/publication/20492775_A_real-time_autoregressive_spectrum_analyzer_for_Doppler_ultrasound_signals
%rats - https://www.ncbi.nlm.nih.gov/pubmed/19964980
%nonlinear textbook - https://books.google.com/books?id=rt_buhgaJEgC&source=gbs_navlinks_s
%ning helicopter - https://ieeexplore.ieee.org/document/7015400
%

clear all;
close all;

filedata = xlsread('Flap_all.xls');
x = filedata(:,1); %read hover
fsamp = 500; %sample rate
Ts = 1/fsamp;

cutoffa = 10; %pass frequeciea
cutoff1 = cutoffa*2*Ts; %calculate percentage of nyquist frequency
cutoff2 = cutoff1 + .0001; %increase slightly for next point
freqs =[0 cutoff1 cutoff2 1]; 
amps=[1 1 0 0];
b=firpm(1000,freqs,amps); %specify the HP filter 
yhp=filter(b,1,x); %do the filtering 
x = yhp;

[d1,p1] = aryule(x,5);

[H1,w1] = freqz(sqrt(p1),d1);

periodogram(x)
hold on
hp = plot(w1/pi,20*log10(2*abs(H1)/(2*pi)),'r'); % Scale to make one-sided PSD
hp.LineWidth = 2;
xlabel('Normalized frequency (\times \pi rad/sample)')
ylabel('One-sided PSD (dB/rad/sample)')
legend('PSD estimate of x','PSD of model output')