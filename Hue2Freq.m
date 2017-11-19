function [ LambdaArr ] = Hue2Freq(HueArr)
%This function gets an array of hue values (0-res uint values) and returnes
%corresponding Array of wave lengths
    LambdaArr = zeros(1,length(HueArr));
    for i=1:length(HueArr)
        LambdaArr(i)=((HueArr(i)/256)*(789-400) + 400) * (10^12);
    end
end