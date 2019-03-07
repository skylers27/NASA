clear all;
close all;

t = 0:.01:1;
y = sin(2*pi*t);
noise = .01.*rand(101,1)';
y = y + noise;
figure;
plot(y);
y = iddata(y);
mb = ar(y,2,'burg');
mfb = ar(y,2);
figure;
bode(mb,mfb)