function [ HueArr ] = WaveLength2Hue( WLArr, res )
    HueArr = zeros(1,length(WLArr));
    for i=1:length(HueArr)
        HueArr(i)=round((780-WLArr(i))*res/390);
    end
end
