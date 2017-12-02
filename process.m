function [classification,avgErr,var,grade,FreqDistance,LadderCompatible,OctaveErrInHue, peaksedges] = process(imFolder,fileName,showGraphs,doCorrection,saveCorrectedIm,saveGraphs,playPics);


tic
classification=-1;
avgErr=-1;
var=-1;
grade=-1;
OctaveErrInHue = -1;
peaksedges = -1;
LadderCompatible = 0;
FreqDistance = 0;
%Loading precalc gaussians and predefined args
imLocation = join([imFolder,fileName]);
dotLocation=strfind(imLocation(2:end),'.')+1;
%CONSTS
HueToWLRotationValue = 14;
numOfPicks=6;
cornumOfPicks=7;
%Configuration Variables
SpectroAmplitudeLuminConversion = false;
graphCount=0;
args = load('preCalcArgs');
GaussiansMat = args.preCalcGauss;
resulution = args.SpectSize;
calcGroupSize = args.calcGroupSize;
%Reading the image
Im = imread(imLocation);
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
Spectogram(:) = sum(sum(sum(GaussiansMat,1),2),3);

[IndicesOfMaxValuesInSpectogram,maxPeaksValues, peakEdges] = GetPickLambdaFromSpectogram(numOfPicks,Spectogram);
numOfPicks = min(size(IndicesOfMaxValuesInSpectogram,2),7);
peaksedges = peakEdges;
if (numOfPicks < 2)
    FreqDistance = -1;
    LadderCompatible = -1;
    return;
end

%%
x_val = fliplr(1:resulution);
x_val = Hue2WaveLength(x_val,resulution);
if(showGraphs || saveGraphs)
    f0 = figure;
    plot(x_val,Spectogram);
    title('spctogram 3');
    xlabel('wavlength[nm]');
    ylabel('weight[au]');
    if(saveGraphs)
%        imLocation
           currGraphLocation = join([imLocation(1:dotLocation-1),'-Graph',num2str(graphCount),imLocation(dotLocation:end)]); 
           graphCount = graphCount+1;
           saveas(f0,currGraphLocation);
    end
    if(~showGraphs)
        close(f0)
    end
end
%%

WLOfGivenMaxIndices = x_val(IndicesOfMaxValuesInSpectogram);
TheroticalOctaveMat  = buildOctaves( WLOfGivenMaxIndices );
[closestInterval, MinErr] = findClosestInterval(TheroticalOctaveMat,WLOfGivenMaxIndices );
%%

 ErrorInEachRowMajor=sum(MinErr');
 [octMinErr,baseFreqIndex]=min(ErrorInEachRowMajor);

%tempMat = circshift(closestInterval,[0 -baseFreqIndex])
[distanceRatio,classsification,avgErr,var,grade] = classify(WLOfGivenMaxIndices,length(WLOfGivenMaxIndices)-1,MinErr(baseFreqIndex,:),25,TheroticalOctaveMat(baseFreqIndex,:),closestInterval(baseFreqIndex,:))
for i=1:numOfPicks
   closestintervals(i)= TheroticalOctaveMat(baseFreqIndex,closestInterval(baseFreqIndex,i));
end
idealWavlengths=(closestintervals.^-1) * 100
WLOfGivenMaxIndices;
IndicesOfMaxValuesInSpectogram;
%%MaxIndArr = FilterMeaningfulPeaksOnly(MaxIndArr,Spectogram,10,SpectroAmplitudeLuminConversion,res);
closestintervals;
OctaveErrInHue=WaveLength2Hue(WLOfGivenMaxIndices,resulution)-WaveLength2Hue(idealWavlengths,resulution)
%%plotting
roundIdealHue=WaveLength2Hue( idealWavlengths, resulution );
IdealWLPeaks=zeros(1,256);
IdealWLPeaks(resulution-roundIdealHue)=maxPeaksValues;
plotIdealOctave=zeros(1,256);
IdealOctaveInWL=fliplr(TheroticalOctaveMat(baseFreqIndex,:).^-1)*100;
IdealOctaveInHue=WaveLength2Hue(IdealOctaveInWL,resulution);
plotIdealOctave(resulution-IdealOctaveInHue+1)=min(maxPeaksValues);
if(showGraphs || saveGraphs)
    f1 = figure;
    plot(x_val,Spectogram);
    hold on;
    stem(x_val,plotIdealOctave,'red');
    stem(x_val,IdealWLPeaks,'green');
    title('spctogram 3');
    xlabel('wavlength[nm]');
    ylabel('weight[au]');
    
    f2 = figure;
    plot(1:numOfPicks,ErrorInEachRowMajor);
    title('sum of absolute error');
    xlabel('base frequency[THz]');
    ylabel('error');
    if(saveGraphs)
        currGraphLocation = join([imLocation(1:dotLocation-1),'-Graph',num2str(graphCount),imLocation(dotLocation:end)]); 
        graphCount = graphCount+1;
        saveas(f1,currGraphLocation);
        currGraphLocation = join([imLocation(1:dotLocation-1),'-Graph',num2str(graphCount),imLocation(dotLocation:end)]); 
        graphCount = graphCount+1;
        saveas(f2,currGraphLocation);
    end
    if(~showGraphs)
        close(f1)
        close(f2)
    end
end
toc
%% match to ladders
% in a ladder, 1 is half a tone and 2 is a tone

referenceOctave=TheroticalOctaveMat(baseFreqIndex,:);
[bestLadder,signedErr,closestNotesIndexes] = findBestLadder(WLOfGivenMaxIndices,referenceOctave)

[distanceRatioLadder,classification,avgErr,var,grade] = classify(WLOfGivenMaxIndices,length(WLOfGivenMaxIndices)-1,signedErr,25,bestLadder,closestNotesIndexes) 
plotBestLadderWL=zeros(256,1);
IdealLadderInHue=WaveLength2Hue((fliplr((bestLadder/100).^-1)),resulution);
plotBestLadderWL(resulution-IdealLadderInHue)=min(maxPeaksValues);
%LadderErrInHue=WaveLength2Hue((fliplr((ErrorInEachRowMajor(StartNoteMajor,:)/100).^-1)),resulution);
if(showGraphs || saveGraphs)
    f3 = figure;
    plot(x_val,Spectogram);
    hold on;

    stem(x_val,plotIdealOctave,'green');
    stem(x_val,plotBestLadderWL,'red');
    title('Best Ladder');
    xlabel('wavlength[nm]');
    if(saveGraphs)
        currGraphLocation = join([imLocation(1:dotLocation-1),'-Graph',num2str(graphCount),imLocation(dotLocation:end)]); 
%        graphCount = graphCount+1;
        saveas(f3,currGraphLocation);
    end
    if(~showGraphs)
        close(f3)
    end
end

if(doCorrection)
    im2Correct = imread(imLocation);
    if (max(max(max(im2Correct))) > 1)   %if in uint 8 convert to 0-1 double
       im2Correct = double(im2Correct) / 255; 
    end
%    OctaveErrInHue
%    WLOfGivenMaxIndices-idealWavlengths
    CorrectedIm = correctImHue(im2Correct,peaksedges,(OctaveErrInHue));
    if(showGraphs)
        figure;
        imshow(im2Correct)
        title('original image');
        figure;
    
        class(CorrectedIm)
        max(max(CorrectedIm))
        imshow(CorrectedIm)
        title('Corrected image');
    end
    if(saveCorrectedIm)
        correctedImLocation = join([imLocation(1:dotLocation-1),'-corrected',imLocation(dotLocation:end)]);
        imwrite(CorrectedIm,correctedImLocation)
    end
end


if(playPics)
    playPicture(Im,IndicesOfMaxValuesInSpectogram,zeros(size(IndicesOfMaxValuesInSpectogram)));
    if(doCorrection)
        playPicture(CorrectedIm,IndicesOfMaxValuesInSpectogram,-1*(OctaveErrInHue));
    end
end

