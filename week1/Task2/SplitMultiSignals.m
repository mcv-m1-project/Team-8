function [ImgDatasetX,ImgDatasetY]=SplitMultiSignals(ImgDataset)

ImgDatasetX=containers.Map;
ImgDatasetY=containers.Map;

keySet=keys(ImgDataset);

for i = 1:length(keySet)
    CrImg=ImgDataset(keySet{i});
    if CrImg.PhotoAmountOfSignals > 1
        randSort=randperm(10);
        if randSort(1)==1 | randSort(1)==2 | randSort(1)==3 | randSort(1)==4 | randSort(1)==5 | randSort(1)==6 | randSort(1)==7
            ImgDatasetX(keySet{i})=CrImg;
        else
            ImgDatasetY(keySet{i})=CrImg;
        end
    end
end
