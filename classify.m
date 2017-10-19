function [classsification,avgErr,var] = classify(measuredPeaks,numOfPeaksRestricted,signedErrVec,marginOfErr,reference,indexInReference)
%calculate physical threshold and classify according to err 
%   Detailed explanation goes here
matchedpeaks=zeros(length(measuredPeaks));
classsification=0;
avgErr=inf;
var=inf;
for i=1:lenght(measuredPeaks)
   if signedErrVec(i)<0
       if abs(signedErrVec(i))/(reference( indexInReference)-reference( indexInReference+1))<marginOfErr
           matchedpeaks(i)=1;
       end
   else
       if abs(signedErrVec(i))/(reference( indexInReference)-reference( indexInReference-1))<marginOfErr
           matchedpeaks(i)=1;
       end
   end
end
if sum(matchedpeaks)>=numOfPeaksRestricted
    avgErr=sum(abs(signedErrVec(matchedpeaks)))/sum(matchedpeaks);
    var=sum(abs(signedErrVec(matchedpeaks))-avgErr)/sum(matchedpeaks)
    classsification=1;
end

