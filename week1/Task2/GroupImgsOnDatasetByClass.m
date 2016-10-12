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
        
    