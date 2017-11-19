function [peaksEdges] = findPeakEdges(Spectro, IndexArray)
    %takes spectrogram and sorted (small to big) picks indexes array and
    %returnes an array whos each cell i contain a 2 value array with values
    %of 2 edges of corresponding peak i
    initStruct.leftEdge = 0;
    initStruct.rightEdge = 0;
    peaksEdges(length(IndexArray)) = initStruct;
    for i = 1:(length(IndexArray))
        %find left edge for current peak
        if(i == 1)  %for the left most peak we take 1 as the left edge
            peaksEdges(i).leftEdge = 1;
        else
            [unusedVals,currPeakLeftMinimas] = findpeaks((-1)*Spectro(IndexArray(i-1):IndexArray(i)));
            peaksEdges(i).leftEdge = IndexArray(i-1)-1 +currPeakLeftMinimas(ceil(length(currPeakLeftMinimas)/2)); %taking the mid minima found between curr peak and last one
        end
        
        %find right edge for current peak
        if(i == length(IndexArray))
            peaksEdges(i).rightEdge = length(Spectro);
        else
            [unusedVals,currPeakRightMinimas] = findpeaks((-1)*Spectro(IndexArray(i):IndexArray(i+1)));
            peaksEdges(i).rightEdge = IndexArray(i)-1 +currPeakRightMinimas(round(length(currPeakRightMinimas)/2)); %taking the mid minima found between curr peak and last one
        end
    end
end
