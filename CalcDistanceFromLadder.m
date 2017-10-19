function [ StartNote,clostestNotes,avgErrorInEachRow,BestLadderWL,SignedMinErr ] = CalcDistanceFromLadder( WLpeaks,idealOctave,Ladder )
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

%% build reference ladder
% this creates a matrix of ladders starting at each possible note (row
% number is starting note)
idealOctave
ReferenceLadder=zeros(12,length(Ladder));

for i=1:12
    index=1;
    
    for j=1:length(Ladder)
        ReferenceLadder(i,j)=idealOctave(index);
        index=mod(index+Ladder(j),12);
        if index == 0
            index=12;
        end
    end
    idealOctave= circshift(idealOctave,-1,2);
end

%% calc distance from notes in refernce ladder

[ clostestNotes, AbsMinErr,SignedMinErr ] = findClosestInterval(ReferenceLadder,WLpeaks );
AbsMinErr
 avgErrorInEachRow=sum(AbsMinErr')/length(WLpeaks);
 [~,StartNote]=min(avgErrorInEachRow) 
BestLadderWL=ReferenceLadder(StartNote,:);

end

