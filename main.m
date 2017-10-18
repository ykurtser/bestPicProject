close all;
clear all
clc;

%CONSTS
res = 256;
HueToWLRotationValue = 14;
numOfPicks=6;
%Configuration Variables
SpectroAmplitudeLuminConversion = false;

%Reading the image
Im = imread('sample2.jpg');
%Im = AllColorTests()
imshow(Im); %Show the given Image
Spectogram = zeros(1,res);
HsvIm = rgb2hsv(Im); %Image in HSV

%HsvIm = SingleColorTests();
[x,y,z] = size(HsvIm); %Saves HSV image matrix sizes 
MinSaturation = min(min(HsvIm(:,:,2))); %Get saturation Min Value
MaxSaturation = max(max(HsvIm(:,:,2))); %Get saturation Max Value
for i=1:x
    for j=1:y
        CurHue = ZeroOneHueToResCyclicRotated(HsvIm(i,j,1),res,HueToWLRotationValue); %cyclic rotation of extra red values on the right - Hue spectrum in HSV is different then WaveLength spectrum.
        Spectogram = Spectogram + PixelHSV2SpectroWLArrVal(CurHue,HsvIm(i,j,2),HsvIm(i,j,3),res)/(x*y); %% normalized by num of pixels
    end
end
%%
x_val = fliplr(1:res);
x_val = Hue2WaveLength(x_val,res);

figure;
plot(x_val,Spectogram);
title('spctogram 3');
xlabel('wavlength[nm]');
ylabel('weight[au]');
%%
[IndicesOfMaxValuesInSpectogram,MaxPicksValues] = GetPickLambdaFromSpectogram(numOfPicks,Spectogram);
WLOfGivenMaxIndices = x_val(IndicesOfMaxValuesInSpectogram);
TheroticalOctaveMat  = buildOctaves( WLOfGivenMaxIndices );
 [closestInterval, MinErr] = findClosestInterval(TheroticalOctaveMat,WLOfGivenMaxIndices );
%%
 ErrorInEachRow=sum(MinErr');
 [octMinErr,baseFreqIndex]=min(ErrorInEachRow)

%tempMat = circshift(closestInterval,[0 -baseFreqIndex])

for i=1:numOfPicks
   closestintervals(i)= TheroticalOctaveMat(baseFreqIndex,closestInterval(baseFreqIndex,i));
end
idealWavlengths=(closestintervals.^-1) * 100
WLOfGivenMaxIndices
IndicesOfMaxValuesInSpectogram
%%MaxIndArr = FilterMeaningfulPeaksOnly(MaxIndArr,Spectogram,10,SpectroAmplitudeLuminConversion,res);
closestintervals


%%plotting
roundIdealHue=WaveLength2Hue( idealWavlengths, res );
IdealWLPeaks=zeros(1,256);
IdealWLPeaks(res-roundIdealHue)=MaxPicksValues;
plotIdealOctave=zeros(1,256);
IdealOctaveInWL=fliplr(TheroticalOctaveMat(baseFreqIndex,:).^-1)*100;
IdealOctaveInHue=WaveLength2Hue(IdealOctaveInWL,res);
plotIdealOctave(res-IdealOctaveInHue)=min(MaxPicksValues);
figure;
plot(x_val,Spectogram);
hold on;
stem(x_val,plotIdealOctave,'red');
stem(x_val,IdealWLPeaks,'green');
title('spctogram 3');
xlabel('wavlength[nm]');
ylabel('weight[au]');

figure;
plot(1:numOfPicks,ErrorInEachRow);
title('sum of absolute error');
xlabel('base frequency[THz]');
ylabel('error');


