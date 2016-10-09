function [SingleTable,DoubleTable,TripleTable] = mountTables (ImgDataset)

SingleTable=[];
DoubleTable=[];
TripleTable=[];

keySet = keys(ImgDataset);

for i=1:length(keySet)
    CrImg = ImgDataset(keySet{i});
    if CrImg.PhotoAmountOfSignals == 1
        SingleTable=[SingleTable;CrImg.PhotoRealClass];
    elseif CrImg.PhotoAmountOfSignals == 2
        DoubleTable=[DoubleTable;CrImg.PhotoRealClass];
    elseif CrImg.PhotoAmountOfSignals == 3
        TripleTable=[TripleTable;CrImg.PhotoRealClass];
    end
end