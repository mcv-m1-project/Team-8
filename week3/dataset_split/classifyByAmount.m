%classifyByAmount: Takes the image dataset and copies its images into
%another of three datasets depending on the amount of signals it contains.
%
%Input: 
%   -ImgDataset: Map of PhotoInDataset -> the image dataset to classify
%
%Output:
%   -SingleS: Map of PhotoInDataset -> dataset of images of one signal
%   -DoubleS: Map of PhotoInDataset -> dataset of images of two signals
%   -TripleS: Map of PhotoInDataset -> dataset of images of three signal

function [SingleS,DoubleS,TripleS]= classifyByAmount(ImgDataset)

SingleS=containers.Map;
DoubleS=containers.Map;
TripleS=containers.Map;

keySet=keys(ImgDataset);

for i=1:length(keySet)
    CrImg = ImgDataset(keySet{i});
    if CrImg.PhotoAmountOfSignals == 1
        SingleS(keySet{i})=CrImg;
    elseif CrImg.PhotoAmountOfSignals == 2
        DoubleS(keySet{i})=CrImg;
    elseif CrImg.PhotoAmountOfSignals == 3
        TripleS(keySet{i})=CrImg;
    end
end