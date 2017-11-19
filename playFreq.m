function playFreq(freq,duration)
amp=0.5;
fs=8190;  % sampling frequency
values=0:1/fs:duration;
a=amp*sin(2*pi* freq*values);
soundsc(a)