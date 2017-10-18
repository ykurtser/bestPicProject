function [ BestFittingDegreeInScale, MinErr ] = findClosestInterval(TheoreticalOctaveMatInFreq,MeasuredWLArr )
%OctaveMat rows contain octaves with main frequency componant as basic  
%findClosestInterval  
%
%input: ThoreticalOctaveMat - Matrix in which each row holds the
%theoretical freqs according to the first freq of every row.
%MeasuredWL - measured WL array
%note: ThoreticalOctaveMat(i,1) == FreqOf( MeasuredWL(i) )
%
%output: MinErr - MinErr(i,j) holds The smallest "distance" found between FreqOf( MeasuredWL(j) ) and all theoretical
%       freqs calculated by BaseFreq == FreqOf( MeasuredWL(i) )
%       BestFittingDegreeInScale(i,j) - The degree (1-12) that is the closest to
%       FreqOf( MeasuredWL(j) ) according to theoretical freqs calculated by BaseFreq == FreqOf( MeasuredWL(i) )
%       
%       Clarification: if BestFittingDegreeInScale(i,j) = 2 it means that
%       from all the notes based on BaseFreq == FreqOf(MeasuredWL(i)), the
%       best fitting one for FreqOf(MeasuredWL(j)) is half tone higher then
%       FreqOf(MeasuredWL(i))
%
%       Sanity Check: BestFittingDegreeInScale(1,j) should be == 1
%                     MinErr(1,j) shpuld be == 0

MeasuredFrequencies=MeasuredWLArr.^(-1)*100;
numOfMeasuredPicks=length(MeasuredFrequencies);
MinErr=zeros(size( TheoreticalOctaveMatInFreq,1),numOfMeasuredPicks);
size(MinErr)
BestFittingDegreeInScale=zeros(numOfMeasuredPicks);
for i=1:size( TheoreticalOctaveMatInFreq,1)
    for j=1:numOfMeasuredPicks 
        
         err = abs(MeasuredFrequencies(j)-TheoreticalOctaveMatInFreq(i,:));            
         [MinErr(i,j),BestFittingDegreeInScale(i,j)] = min(err); %index of closest value

    end
end

end

