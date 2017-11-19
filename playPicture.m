function playPicture(im,Arr,correction)
%input: im - uint8 HSV image matrix
%       peakArr - peak array, each peak with vals ranged [1,256]
%                 which represent dominant hue vals in the image

%consts
COLOR_RESOLUTION = 3;

hueArr = 255-Arr;
for i = 1:length(hueArr)
   hueArr(i) = mod(hueArr(i)-11+correction(i),255); 
end
hueArr
correction
markedImageArr = {length(hueArr)};

im2play = rgb2hsv(im);

if (max(max(max(im2play))) <= 1)   %if in uint 8 convert to 0-1 double
    im2play = im2play * 255;
else
    max(max(max(im2play)))
end


%preparing images, when each image will have only corresponding hue from
%hueArr not black
for hueInd = 1:length(hueArr)
    markedImageArr{hueInd} = zeros(size(im2play,1),size(im2play,2),3);
end
for hueInd = 1:length(hueArr)
    for i = 1:size(im2play,1)
       for j = 1:size(im2play,2)
           if (mod(j,200) == 0)
           % im2play(i,j,1)
           end
           if(im2play(i,j,1) >= hueArr(hueInd) - COLOR_RESOLUTION && im2play(i,j,1) <= hueArr(hueInd)+ COLOR_RESOLUTION)
               markedImageArr{hueInd}(i,j,1) = im2play(i,j,1);
               markedImageArr{hueInd}(i,j,2) = im2play(i,j,2);
               markedImageArr{hueInd}(i,j,3) = im2play(i,j,3);
           end
       end
    end
end
mixedImageArr = {};
for i = 1:length(hueArr)
   mixedImageArr{i} = zeros(size(im2play,1),size(im2play,2),3);
   for j = 1:i
       mixedImageArr{i} = mixedImageArr{i}+markedImageArr{j};
   end
end

freqArr = Hue2Freq(hueArr)/(2^42);
for i = 1:length(hueArr)
    imshow(hsv2rgb(mixedImageArr{i}/255));
    playSuperpos(freqArr(1:i)*2,1);
    pause(1.5)
end
for i = 1:length(hueArr)
   imshow(hsv2rgb(markedImageArr{i}/255));
   playFreq(freqArr(i),1);
   pause(1)
end
for i = 1:length(hueArr)
   imshow(hsv2rgb(markedImageArr{i}/255));
   playFreq(freqArr(i)*2,1);
   pause(1)
end
for i = 1:length(hueArr)
   imshow(hsv2rgb(markedImageArr{i}/255));
   playFreq(freqArr(i)*4,1);
   pause(1)
end






