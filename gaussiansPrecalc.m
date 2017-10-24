%This script precalculates the gaussians of all possible RGB triplets and
%saves them into a 3d histogram

SpectSize = 256;
calcGroupSize = 4;  %keep as power of 2
preCalcGaussDimSize = floor(256/calcGroupSize)+1;
preCalcGauss = zeros(preCalcGaussDimSize,preCalcGaussDimSize,preCalcGaussDimSize,SpectSize);
HueToWLRotationValue = 14;
midArea = floor(calcGroupSize/2);
for R = 0:preCalcGaussDimSize-1
    for G = 0:preCalcGaussDimSize-1
        for B = 0:preCalcGaussDimSize-1
            currPixelHSV = rgb2hsv(((R*calcGroupSize) + midArea)/256,(G*calcGroupSize + midArea)/256,(B*calcGroupSize + midArea)/256);
            currPixelHSV(1) = ZeroOneHueToResCyclicRotated(currPixelHSV(1),SpectSize,HueToWLRotationValue); %fixing hue values cyclic rotation of extra red values on the right - Hue spectrum in HSV is different then WaveLength spectrum. input 0-1 vals output 0-255 vals
            preCalcGauss(R+1,G+1,B+1,1:SpectSize) = PixelHSV2SpectroWLArrVal(currPixelHSV(1),currPixelHSV(2),currPixelHSV(3),SpectSize); %% normalized by num of pixels
        end
    end
end

save('preCalcArgs','SpectSize','calcGroupSize','preCalcGaussDimSize','preCalcGauss');

