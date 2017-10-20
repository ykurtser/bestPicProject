clc
clear all
photosLocation='./photoDb/';
imageNames = dir(join([photosLocation,'*.jpg']));%looks for all the jpg photos names under ./photoDb/
photosMap = containers.Map; %key: photo Id, value: struct holding all the 
                            %info (given and calculated params)
fileID = fopen('photonet_dataset_orig.txt');
parsed = textscan(fileID,'%s %s %d %f %f %s %s %s %s %s %s %s'); 

%parsed columns are: 1:index, 2: ID, 3: num of votes, 4:median of votes(1-7) 5:
%deviation of rating, 6-12 Distribution (counts) of aesthetics ratings in
%1-7 scale, 6 being for 1, and 12 being for 7
fclose(fileID);
for i = 1:size(parsed{1},1)
   currStruct.numOfVotes = parsed{3}(i); 
   currStruct.votesMedian = parsed{4}(i); 
   currStruct.votesDeviation = parsed{5}(i);
   photosMap(parsed{2}{i}) = currStruct;
end
for i = 1:size(imageNames)
    [currFreqDistance,currLadderCompatible] = process(imageNames(i).name);
    if(currLadderCompatible == -1)
        delete(join([photosLocation,process(imageNames(i).name)]));
        continue;
    end
    bracketLocation=strfind(imageNames(i).name,'-'); %all file names are Id-something.jpeg
    currPhotoId = imageNames(i).name(1:bracketLocation-1);
    if(~photosMap.iskey(currPhotoId))
        msg = join(['the photo couldnt be found on dataset txt file',process(imageNames(i).name)]);
        continue;
    end
    currStruct = photosMap(currPhotoId);
%    currStruct.freqDistance = currFreqDistance;
%    currStruct.LatterCompatible = currLatterCompatible;
    photosMap(currPhotoId) = currStruct;
    
end
