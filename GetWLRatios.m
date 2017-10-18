function [ RatioMat ] = GetWLRatios( MainWL )
% Calc ratios of main wavlengths -of current octave and 1 higher octave
%   build matrix 
%if i<j -> ratioMat[i][j]= MainWL[i]/MainWL[j] -1 octave
%if j<i -> ratioMat[i][j]= MainWL[i]/2*MainWL[j] - ratio to note in higher
%octav
RatioMat=zeros(length(MainWL)); 

for i=1:length(MainWL)
    
    for j=1:length(MainWL)
        if (i<=j)
            
                RatioMat(i,j)=MainWL(j)/MainWL(i);
         
        else
          
                RatioMat(i,j)=(2*MainWL(j))/MainWL(i);
        end
    end
end
end

