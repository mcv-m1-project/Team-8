%GroupImgsOnDatasetByClass: Takes the image dataset and copies its images 
%into another of six datasets depending on its class.
%
%Input: 
%   -ImgDataset: Map of PhotoInDataset -> the image dataset to classify
%
%Output:
%   -ADataset: Map of PhotoInDataset -> dataset of images of one signal 'A'
%   -BDataset: Map of PhotoInDataset -> dataset of images of one signal 'B'
%   -CDataset: Map of PhotoInDataset -> dataset of images of one signal 'C'
%   -DDataset: Map of PhotoInDataset -> dataset of images of one signal 'D'
%   -EDataset: Map of PhotoInDataset -> dataset of images of one signal 'E'
%   -FDataset: Map of PhotoInDataset -> dataset of images of one signal 'F'

function [ADataset,BDataset,CDataset,DDataset,EDataset,FDataset] = GroupImgsOnDatasetByClass (ImgDataset)


keySet=keys(ImgDataset);

ADataset = containers.Map;
BDataset = containers.Map;
CDataset = containers.Map;
DDataset = containers.Map;
EDataset = containers.Map;
FDataset = containers.Map;


for i=1:length(keySet)
    CrImg = ImgDataset(keySet{i});
    if CrImg.PhotoRealClass == 'A'
        ADataset(keySet{i})= CrImg;
    elseif CrImg.PhotoRealClass == 'B'
        BDataset(keySet{i})= CrImg;
    elseif CrImg.PhotoRealClass == 'C'
        CDataset(keySet{i})= CrImg;
    elseif CrImg.PhotoRealClass == 'D'
        DDataset(keySet{i})= CrImg;
    elseif CrImg.PhotoRealClass == 'E'
        EDataset(keySet{i})= CrImg;
    elseif CrImg.PhotoRealClass == 'F'
        FDataset(keySet{i})= CrImg;
    end
end


end
        
    