%Helicopter Flight Vibration Analysis, Hover
%Skyler Szot

clear all;
close all;

filedata = xlsread('Flap_all.xls');
hover = filedata(:,1); %read hover
Fs = 500; %sample rate

%plot raw data
figure;
plot(hover);
title('Hover');
xlabel('Sample');
ylabel('Amplitude');

window = ones(length(Fs)); %generate rectangular window
x = input('Enter 0 for rectangular, 1 for Hanning: '); %select window
if x==1,
    %Hanning window calculation
    T = 1; % period, 1 second
    n = T*Fs; %num samples
    t = linspace(1/Fs, T, n); %generate row vector of 500 evenly spaced points
    window = 0.5 - 0.5*cos(2*pi*linspace(0, 1, n)); %generate Hanning
    window = window'; %transpose, to match data
    figure; %plot windowing function
    plot(window);
    hold on;
    plot(hanning(500)); %compare to matlab built in
    title('Hanning');
end

seconds = 0;
total = 0;

for n = 1:Fs:length(hover)-Fs %increment each second
    temp = hover(n:n+Fs-1); %get data segment
    npts = length(temp); %get npts
    nfft = 2^ceil(log2(npts)); %nfft must be power of 2, use zero padding if necessary
    xfft = fft(temp.*window,nfft); %calculate fft, multiplying by windowing function
    freqRes = Fs/nfft; %frequency calculation
    freq = freqRes*(0:(nfft/2)-1);
%     figure;
%     plot(freq,20*log10(abs(xfft(1:nfft/2)))); %plot in log scale
%     title(sprintf('Time(sec): %d to %d',seconds, seconds+1));
%     xlabel('Frequency (Hz)');
%     ylabel('dB');
    total = total + xfft; %add to total
    seconds = seconds + 1; %track number of calculations done
end

average = total/seconds; %calculate average fft
figure;
plot(freq,20*log10(abs(average(1:nfft/2)))); %plot average in log scale
title('Average');
xlabel('Frequency (Hz)');
ylabel('dB');