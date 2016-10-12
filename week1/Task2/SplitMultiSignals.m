%SplitMultiSignals: takes an image dataset and copies its images with more
%than one signal into one of two datsets, with 70% vs 30% of probability of
%one against the other.
%
%Input
%   -ImgDataset: Map of PhotoInDataset -> image dataset to be split
%
%Output
%   -ImgDatasetX: Map of PhotoInDataset -> image dataset where some of the 
%   image files of ImgDataset that have more than one signal fall with a
%   70% of probability.
%   -ImgDatasetY: Map of PhotoInDataset -> image dataset where some of the 
%   image files of ImgDataset that have more than one signal fall with a
%   30% of probability.

function [ImgDatasetX,ImgDatasetY]=SplitMultiSignals(ImgDataset)

ImgDatasetX=containers.Map;
ImgDatasetY=containers.Map;

keySet=keys(ImgDataset);

for i = 1:length(keySet)
    CrImg=ImgDataset(keySet{i});
    if CrImg.PhotoAmountOfSignals > 1
        %70% probability
        randSort=randperm(10);
        if randSort(1)==1 | randSort(1)==2 | randSort(1)==3 | randSort(1)==4 | randSort(1)==5 | randSort(1)==6 | randSort(1)==7
            ImgDatasetX(keySet{i})=CrImg;
        else
            ImgDatasetY(keySet{i})=CrImg;
        end
    end
end
