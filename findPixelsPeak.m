function peak = findPixelsPeak(peakIntervals,hue)
%input: peakIntervals - vectors which elements are strcuts with .leftEdge
%.rightEdge - meaning left right edges of a peak [1 256]
%hue vals [0 1]
%this converts hue to corresponding spectogram's mean gaussian value, and
%find in which Interval is it
HueToWLRotationValue = 14;
rotatedHue = ZeroOneHueToResCyclicRotated(hue,256,HueToWLRotationValue); %fixing hue values cyclic rotation of extra red values on the right - Hue spectrum in HSV is different then WaveLength spectrum. input 0-1 vals output 0-255 vals
mean = 256-rotatedHue;
for i = 1:length(peakIntervals)
    if  (mean > peakIntervals(i).leftEdge) && (mean < peakIntervals(i).rightEdge)
       peak = i;
       return;
    end
end
peak = 0;
end
