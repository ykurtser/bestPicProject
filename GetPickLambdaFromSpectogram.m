function [ IndexArray , ValuesArray ] = GetPickLambdaFromSpectogram( AmmountOfReturnPeaksWanted,Spectro )
%Get the wavelengths of the num picks in the given spectogram
	[PeakValues, PeakIndices] = findpeaks(Spectro);
	for i = 1:length(PeakIndices)   %this loop goes over all the peaks found and finds the mid indice of a flat peak.
		j=0;
        while (Spectro(j+1) == Spectro(PeakIndices(i)))
            j=j+1;
        end
        if(j>1)
            PeakIndices(i) = PeakIndices(i) + round(j/2);
        end
	end
	
	if(length(PeakIndices) > AmmountOfReturnPeaksWanted) %if the wanted number of returned peaks is lower then the ammount found, return only the highest ones. 
		SortedPeakValues = sort(PeakValues); %smallest values 1st.
        SortedPeakValues = fliplr(SortedPeakValues); %biggest values 1st.
		for i = 1:AmmountOfReturnPeaksWanted
			MaxInd = PeakIndices(find(PeakValues==SortedPeakValues(i)));%MaxInd now holds the spectrogram's index of the top i'th biggest peak big
			IndexArray(i) = MaxInd;
            PeakValues(find(PeakValues==SortedPeakValues(i))) = -1; % giving a negative value to the peak taken for the case to different peaks have same value.
        end
    else
        IndexArray = PeakIndices;
    end
    
    IndexArray = sort(IndexArray);
    ValuesArray = Spectro(IndexArray);
end
    

