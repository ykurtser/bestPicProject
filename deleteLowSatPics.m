%deletes all images on folder which average saturation levels are lower
%then Threshold

clc
clear all

saturationThreshold = 0.5;
volumeThreshold = 0.2;
imageNames = dir('./photos/*.jpg');
deleteCount = 0;
remainCount = 0;
for i = 1:size(imageNames)
    %printing stats
    if(mod(i,50) == 0)
        deleteCount
        remainCount
    end
    numOfPixels = 0;
    totalSaturation = 0;
    imageNames(i).name
    currIm = imread(['./photos/' imageNames(i).name]);
    if(size(currIm,3)<3)
        delete(['./photos/' imageNames(i).name]);
        deleteCount = deleteCount+1;
        continue;
    end
    currIm = rgb2hsv(currIm);
    for j = 1:size(currIm,1)
        for k = 1:size(currIm,2)
            if(currIm(j,k,3) > volumeThreshold) %checks that pixel is not very dark
                numOfPixels = numOfPixels + 1;
                totalSaturation = totalSaturation + currIm(j,k,2);
            end
        end
    end
    averageSaturation = totalSaturation/numOfPixels;
    if(averageSaturation < saturationThreshold)
        delete(['./photos/' imageNames(i).name]);
        deleteCount = deleteCount+1;
    else
        remainCount = remainCount+1;
    end
        
end