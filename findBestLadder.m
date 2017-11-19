function [bestLadder,signedErr,closestNotesIndexes] = findBestLadder(WLpeaks,idealOctave)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ladderSize=7;
major=[2,2,1,2,2,2,1];
minor=[2,1,2,2,1,2,2];
dori=[2,1,2,2,2,1,2];
frigi=[1,2,2,2,1,2,2];
lidi=[2,2,2,1,2,2,1];
micsolidi=[2,2,1,2,2,1,2];
locri=[1,2,2,1,2,2,2];
ladders={major,minor,dori,frigi,lidi,micsolidi,locri};
referenceLadder={8};
for i=1:ladderSize
    referenceLadder{i}=zeros(1,ladderSize);
    index=0;
    for j=1:ladderSize
            index=mod(index+ladders{i}(j),12);
        if index == 0
            index=12;
        end
        referenceLadder{i}(j)=idealOctave(index);
    
    end
    
     [ closestNotes(i,:),AbsMinErr(i,:),SignedMinErr(i,:) ] = CalcDistanceFromLadder( WLpeaks,referenceLadder{i} ) ;    
end
sum(AbsMinErr')
[~,bestLadderIndex]=min(sum(AbsMinErr'))
bestLadder=referenceLadder{bestLadderIndex};
signedErr=SignedMinErr(bestLadderIndex,:);
closestNotesIndexes=closestNotes(i,:)
idealOctave
MeasuredFrequencies=WLpeaks.^(-1)*100
bestLadderIndex
