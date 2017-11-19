function [ closestNotes,AbsMinErr,SignedMinErr ] = CalcDistanceFromLadder( WLpeaks,referenceLadder )
%UNTITLED2 Summary of this function goes here
%   this function test how close are measured peaks to a known musical
%   ladder.
%   inputs:
%   WLpeaks - measured spectogram after filterMeaningFullPeaks 
%   idealOctave - ideal intervals multiplied by base frequency
%   ladder - vector with the values {1,2} - 1 means half a tone, 2 means a  tone
%  
%  function constructs: ReferenceLadder
%
%  ReferenceLadder(i>0)=idealOctave((BaseFreq+i-1)+ladder(i))
%  then calcultes and returns the sum of norm 1 distances from measured peaks to closest notes in refernce
%  Ladder
%  outputs:
%  StartNote = start note of ladder that minimizes error
%   DistanceFromLadder= minimal absolute error




%% calc distance from notes in refernce ladder
numOfMeasuredPicks=length(WLpeaks);
AbsMinErr=zeros(1,numOfMeasuredPicks);
SignedMinErr=zeros(1,numOfMeasuredPicks);
closestNotes=zeros(1,numOfMeasuredPicks);
MeasuredFrequencies=WLpeaks.^(-1)*100;
     for j=1:numOfMeasuredPicks    
        err = (MeasuredFrequencies(j)-referenceLadder);            
         [AbsMinErr(j),closestNotes(j)] = min(abs(err)); %index of closest value
         SignedMinErr(j) = sign(err(closestNotes(j)))*AbsMinErr(j);
     end


end

