close all;
clear all
clc;
tic
%Loading precalc gaussians and predefined args
args = load('preCalcArgs');
GaussiansMat = args.preCalcGauss;
resulution = args.SpectSize;
calcGroupSize = args.calcGroupSize;

%CONSTS
HueToWLRotationValue = 14;
numOfPicks=6;
%Configuration Variables
SpectroAmplitudeLuminConversion = false;

%Reading the image
Im = imread('sample2.jpg');
normalizedIm = floor(Im/calcGroupSize)+1;
%Im = AllColorTests()
%imshow(Im); %Show the given Image
Spectogram = zeros(1,resulution);
%HsvIm = rgb2hsv(Im); %Image in HSV

%HsvIm = SingleColorTests();
[x,y,z] = size(normalizedIm); %Saves HSV image matrix sizes 
%MinSaturation = min(min(HsvIm(:,:,2))); %Get saturation Min Value
%MaxSaturation = max(max(HsvIm(:,:,2))); %Get saturation Max Value
histo = zeros((256/calcGroupSize)+1,(256/calcGroupSize)+1,(256/calcGroupSize)+1);
for i=1:x
    for j=1:y
%        Spectogram = Spectogram + GaussiansMat(normalizedIm(i,j,1),normalizedIm(i,j,2),normalizedIm(i,j,3),:);
        histo(normalizedIm(i,j,1),normalizedIm(i,j,2),normalizedIm(i,j,3)) = histo(normalizedIm(i,j,1),normalizedIm(i,j,2),normalizedIm(i,j,3))+1;
    end
end
histo = repmat(histo,1,1,1,256);
GaussiansMat = histo.*GaussiansMat;
Spectogram(:) = sum(sum(sum(GaussiansMat,1),2),3)

%%
x_val = fliplr(1:resulution);
x_val = Hue2WaveLength(x_val,resulution);

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
roundIdealHue=WaveLength2Hue( idealWavlengths, resulution );
IdealWLPeaks=zeros(1,256);
IdealWLPeaks(resulution-roundIdealHue)=MaxPicksValues;
plotIdealOctave=zeros(1,256);
IdealOctaveInWL=fliplr(TheroticalOctaveMat(baseFreqIndex,:).^-1)*100;
IdealOctaveInHue=WaveLength2Hue(IdealOctaveInWL,resulution);
plotIdealOctave(resulution-IdealOctaveInHue)=min(MaxPicksValues);
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
toc

