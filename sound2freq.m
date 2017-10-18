function [ output_args ] = Untitled7( input_args )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
Fs=48000
samples = [1,2*Fs];
clear y Fs
[y,Fs] = audioread('allegro.wav',samples);

sound(y,Fs);
Y=fft(y);
L=length(Y);
P2 = abs(Y/L);
P1 = 2*P2(1:L/2+1);

f = Fs*(0:(L/2))/L;
figure;
plot(f,P1)
xlabel('f (Hz)')
ylabel('|P1(f)|')
Fs
% Poc1 = 2*P2(16:32);
% oc1 = Fs*(16:32)/L;
% figure;
% plot(oc1,Poc1)
% xlabel('f (Hz)')
% ylabel('|OCTAVE1(f)|')
% 
% Poc2 = 2*P2(32:64);
% oc2 = Fs*(32:64)/L;
% figure;
% plot(oc2,Poc2)
% xlabel('f (Hz)')
% ylabel('|OCTAVE2(f)|')
% 
% 
% Poc3 = 2*P2(64:128);
% oc3 = Fs*(64:128)/L;
% figure;
% plot(oc3,Poc3)
% xlabel('f (Hz)')
% ylabel('|OCTAVE3(f)|')
% 
% Poc4 = 2*P2(128:256);
% oc4 = Fs*(128:256)/L;
% figure;
% plot(oc4,Poc4)
% xlabel('f (Hz)')
% ylabel('|OCTAVE4(f)|')
% 
% Poc5 = 2*P2(256:512);
% oc5 = Fs*(256:512)/L;
% figure;
% plot(oc5,Poc5)
% xlabel('f (Hz)')
% ylabel('|OCTAVE5(f)|')
% 
% Poc6 = 2*P2(512:1024);
% oc6 = Fs*(512:1024)/L;
% figure;
% plot(oc6,Poc6)
% xlabel('f (Hz)')
% ylabel('|OCTAVE6(f)|')
end

