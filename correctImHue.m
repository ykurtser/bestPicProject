function [betterIm] = correctImHue(origIm,peakIntervals,correctionArray)
%this function takes origIm and corrects pixels that maps to each interval
%from peakIntervlas according to corresponding correction value in
%correctionArray.
%Hue values (i,j,1) are [0,1]
%correctionArray can get values of [-255,255] (but mostly will be more like
%[-11,11] )
if(length(peakIntervals) ~= length(correctionArray))
    MSG = join(['length(peakIntervals) (',length(peakIntervals),') != length(correntionArray)(',length(correntionArray),' cant correct image like that madafaka'])
end
HsvIm = rgb2hsv(origIm);
for i = 1:size(origIm,1)
   for j = 1:size(origIm,2)
      currPeak = findPixelsPeak(peakIntervals,HsvIm(i,j,1));
      currPeak
      if(currPeak ~= 0)
         HsvIm(i,j,1) = mod(((HsvIm(i,j,1)*255) + (-1) * correctionArray(currPeak)),255)/255;
      end
   end
end

betterIm = hsv2rgb(HsvIm);
end