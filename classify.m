function [classsification,avgErr,var,grade] = classify(measuredPeaks,numOfPeaksRestricted,signedErrVec,marginOfErr,reference,indexInReference)
%calculate physical threshold and classify according to err 
%   Detailed explanation goes here
matchedpeaks=zeros(1,length(measuredPeaks));
distanceRatio=zeros(1,length(measuredPeaks));
classsification=0;
avgErr=inf;
var=inf;
signedErrVec
refLength=length(reference);
for i=1:length(measuredPeaks)
    
   if signedErrVec(i)<0
        distanceRatio(i)=abs(signedErrVec(i))/abs(reference( indexInReference(i))-reference( mod(indexInReference(i),refLength)+1));
       if distanceRatio(i)<marginOfErr
           matchedpeaks(i)=1;
       end
   else
       distanceRatio(i)=abs(signedErrVec(i))/abs(reference( max(2,indexInReference(i)))-reference(max(1, indexInReference(i)-1)));
       if distanceRatio(i)<marginOfErr
           matchedpeaks(i)=1;
       end
   end 
end
sum(matchedpeaks)
if sum(matchedpeaks)>=numOfPeaksRestricted
    avgErr=sum(abs(signedErrVec.*matchedpeaks))/sum(matchedpeaks);
    var=sum(abs(abs(signedErrVec.*matchedpeaks))-avgErr)/sum(matchedpeaks);
    classsification=1;
end
avgDistanceRatio=sum(distanceRatio)/length(matchedpeaks);
grade=(1-avgDistanceRatio)*7;

