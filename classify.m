function [distanceRatio,classsification,avgErr,var,grade] = classify(measuredPeaks,numOfPeaksRestricted,signedErrVec,marginOfErr,reference,indexInReference)
%calculate physical threshold and classify according to err 
%   Detailed explanation goes here
matchedpeaks=zeros(1,length(measuredPeaks));
distanceRatio=zeros(1,length(measuredPeaks)); % will be calculated in cents (see definition in book)
classsification=0;
avgErr=inf;
var=inf;
MeasuredFrequencies=measuredPeaks.^(-1)*100;
for i=1:length(measuredPeaks)
    distanceRatio(i)=1200*log2(max(MeasuredFrequencies(i),reference( indexInReference(i)))/min(MeasuredFrequencies(i),reference( indexInReference(i))));     
       if distanceRatio(i)<marginOfErr
           matchedpeaks(i)=1;
       end
end
sum(matchedpeaks)
numOfPeaksRestricted
if sum(matchedpeaks)>=numOfPeaksRestricted
    avgErr=sum(abs(signedErrVec.*matchedpeaks))/sum(matchedpeaks);
    var=sum(signedErrVec.^2.*matchedpeaks/sum(matchedpeaks))-avgErr^2;
    classsification=1;
end
avgDistanceRatio=sum(distanceRatio)/length(matchedpeaks)
grade=(1-avgDistanceRatio/50)*7

