function playThreeOctaves(lowFreq,durationForEach)
amp=0.5;
fs=8190;  % sampling frequency
values=0:1/fs:durationForEach;
a=amp*sin(2*pi*lowFreq*values);
b = amp*sin(2*pi*lowFreq*2*values);
c = amp*sin(2*pi*lowFreq*4*values);
playArr = [a,b,c];
sound(playArr)