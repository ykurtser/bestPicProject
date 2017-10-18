function [ LambdaArr ] = Hue2WaveLength( HueArr, res )
%This function gets an array of hue values (0-res uint values) and returnes
%corresponding Array of wave lengths
    LambdaArr = zeros(1,length(HueArr));
    for i=1:length(HueArr)
        LambdaArr(i)=round(780-(390*HueArr(i)/res));
    end
end