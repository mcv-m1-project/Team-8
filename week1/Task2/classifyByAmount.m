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