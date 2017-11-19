function playSuperpos(freqArr,duration)
amp=0.5;
fs=8190;  % sampling frequency
values=0:1/fs:duration;
playSection = {};
currSin = zeros(1,length(sin(2*pi*freqArr(1)*values)));
for i = 1:length(freqArr)
    currSin = currSin + (amp/i)*sin(2*pi*freqArr(i)*values);
end
soundsc(currSin)
