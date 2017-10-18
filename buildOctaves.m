
function [ OctaveMat ] = buildOctaves( MeasuredPicksInWL )
% this function multiply each main frequency by all (ideal) harmonic intervals
%  row[i] of output matrix is an octave with MainWL[i]^-1 as basic frequency
%since MainWL is sorted by wavelength, and MainFrequencies is sorted by
%frequency (increasingly), we will handle frequencies that are lower than
%basic as if if they are in a lower octave, hence divide by 2
%
%different explanation: 
%input: measured picks in WL
%output: Matrix in which: every row i holds frequencies such that
%OctaveMat(i,1) holds the corresponding frequncy fot WL in MeasuredPicks(i)- and is the Base frequency of the row.
%the rest of the frequencies in the row are calculated according to
%therotical intervals measured by the base freq.

%note: we want to look only at frequncies in the visible light spectrum, so
%freqs that by the theoretical calc go over that spectrum are lowered in 1
%octave (meaning the freq is divided by 2)
MIN_WL = 390;
MAX_FREQ=100/MIN_WL;
intervals=[1,1.05946,1.12246,1.18921,1.25992,1.33483,1.41421,1.49831,1.5874,1.68179,1.78180,1.88775]; 
OctaveMat=zeros(length(MeasuredPicksInWL),length(intervals)); 
MainFrequencies=(MeasuredPicksInWL.^(-1))*100; 
for i=1:length(MeasuredPicksInWL)
    for j=1:length(intervals)
        TempCalc = MainFrequencies(i)*intervals(j) ;
        if (TempCalc<=MAX_FREQ)
            
                OctaveMat(i,j)=MainFrequencies(i)*intervals(j) ;
         
        else
         
                OctaveMat(i,j)=MainFrequencies(i)*intervals(j)/2;
        end
    end
end
end

