function [ HueArr ] = WaveLength2Hue( WLArr, res )
%This function gets an array of hue values (0-res uint values) and returnes
%corresponding Array of wave lengths
    HueArr = zeros(1,length(WLArr));
    for i=1:length(HueArr)
        HueArr(i)=round((780-WLArr(i))*res/390);
    end
end
