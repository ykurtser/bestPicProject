clc
clear all

%configuration
doCorrection = true;
showGraphs = true;
playPics = true;
saveCorrectedIm = true;
saveGraphs = true;

imFolder='./photos/';
imageNames = dir(join([imFolder,'*.jpg']));%looks for all the jpg photos names under ./photoDb/
photosMap = containers.Map; %key: photo Id, value: struct holding all the 
                            %info (given and calculated params)
fileID = fopen('photonet_dataset_orig.txt');
parsed = textscan(fileID,'%s %s %d %f %f %s %s %s %s %s %s %s'); 
fclose(fileID);

doCorrection = true;

%parsed columns are: 1:index, 2: ID, 3: num of votes, 4:median of votes(1-7) 5:
%deviation of rating, 6-12 Distribution (counts) of aesthetics ratings in
%1-7 scale, 6 being for 1, and 12 being for 7
for i = 1:size(parsed{1},1)
   currStruct.numOfVotes = parsed{3}(i); 
   currStruct.votesMedian = parsed{4}(i); 
   currStruct.votesDeviation = parsed{5}(i);
   currStruct.Classification = -1;
   photosMap(parsed{2}{i}) = currStruct;
end
for i = 1:size(imageNames)
    bracketLocation=strfind(imageNames(i).name,'-'); %all file names are Id-something.jpeg
    dotLocation=strfind(imageNames(i).name(2:end),'.')+1;
    currPhotoId = imageNames(i).name(1:bracketLocation-1);
    currPhotoExtension = imageNames(i).name(dotLocation:end);
    if( ~photosMap.isKey(currPhotoId) )
        msg = join(['the photo couldnt be found on dataset txt file',imageNames(i).name])
        continue;
    end
    
    [currClassification,currAvgErr,currVar,currGrade,currFreqDistance,currLadderCompatible,currOctaveErrInHue, currpeaksedges]  = process(imFolder,imageNames(i).name,false,true,true,true,false);  %if process finds current image to be uncompatible for analysis, we delete it.
    
    %right now, condition for compatibility is (num of peaks) > 2
    if(currLadderCompatible == -1) 
        continue;
    end
    
    correctedImName = join([imageNames(i).name(1:dotLocation-1),'-corrected',imageNames(i).name(dotLocation:end)]);
    
    [currCorClassification,currCorAvgErr,currCorVar,currCorGrade,currCorFreqDistance,currCorLadderCompatible,currCorOctaveErrInHue, currCorpeaksedges]  = process(imFolder,correctedImName,false,false,false,true,false);  %if process finds current image to be uncompatible for analysis, we delete it.
    
    currStruct = photosMap(currPhotoId);
    currStruct.Classification = currClassification;
    currStruct.AvgErr = currAvgErr;
    currStruct.Var = currVar;
    currStruct.Grade = currGrade;

    currStruct.CorClassification = currCorClassification;
    currStruct.CorAvgErr = currCorAvgErr;
    currStruct.CorVar = currCorVar;
    currStruct.CorGrade = currCorGrade;
    photosMap(currPhotoId) = currStruct;
    
end

%remove from map all elements which we're not processed
k = keys(photosMap) ;
for i = 1:length(photosMap)
    if(photosMap(k{i}).Classification == -1)
        remove(photosMap,k{i});
    else
        k{i}, photosMap(k{i})
    end
end
