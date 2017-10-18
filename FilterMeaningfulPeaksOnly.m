function [ MeaningfulPeaks ] = FilterMeaningfulPeaksOnly(PeakArr,Spectro,FilterRatio,LuminConsiduration,res)
%Returnes an array with indices of only the peaks which are bigger then
%(FilterRatio) * BiggestPeak 

if(LuminConsiduration)
    Spectro = SpectroToLum(Spectro,res);
end
MaxVal = max(Spectro);
j=1;
%TODO - multiply spectrogram by luminosity function
for i = PeakArr
    if (Spectro(i) >= MaxVal*(FilterRatio))
        MeaningfulPeaks(j) = i;
        j = j+1;
    end
end

end