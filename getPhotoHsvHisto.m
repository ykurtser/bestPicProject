clc
clear all
    saturationHisto = zeros(1,257);
    hueHisto = zeros(1,257);
    volumeHisto = zeros(1,257);
    totalSaturation = 0;
    currIm = imread('00113-md.jpg');
    currIm = rgb2hsv(currIm);
    currIm = round((currIm*256)+1);
    imshow('00113-md.jpg')
    
    for j = 1:size(currIm,1)
        for k = 1:size(currIm,2)
            saturationHisto(currIm(j,k,2)) = saturationHisto(currIm(j,k,2))+1;
            volumeHisto(currIm(j,k,3)) = volumeHisto(currIm(j,k,3))+1;
            hueHisto(currIm(j,k,1)) = hueHisto(currIm(j,k,1))+1;
        end
    end
    
    x_val = 1:257;
  figure;
  stem(x_val,saturationHisto,'green');
  title('saturationHisto');
  hold on;

  figure;
  stem(x_val,volumeHisto,'green');
  title('volumeHisto');
  hold on;
  
  figure;
  stem(x_val,hueHisto,'green');
  title('hueHisto');
  hold on;    
        