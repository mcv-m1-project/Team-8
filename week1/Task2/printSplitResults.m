%printSplitResults: takes two datasets and stores its image files into the
%specified names.
%
%Input:
%   -ImgDatasetX: Map of PhotoInDataset -> first dataset
%   -ImgDatasetY: Map of PhotoInDataset -> second dataset
%   -NameX: String -> name of the .txt file to store the first dataset
%   -NameY: String -> name of the .txt file to store the second dataset

function printSplitResults(ImgDatasetX,ImgDatasetY,NameX,NameY)

keySetX = keys(ImgDatasetX);
keySetY = keys(ImgDatasetY);

fx=fopen(NameX,'w');

for i=1:length(keySetX)
    CrImg = ImgDatasetX(keySetX{i});
    fprintf(fx,strcat(CrImg.PhotoName,'\n'));
end

fclose(fx);

fy=fopen(NameY,'w');

for i=1:length(keySetY)
    CrImg = ImgDatasetY(keySetY{i});
    fprintf(fy,strcat(CrImg.PhotoName,'\n'));
end

fclose(fy);
