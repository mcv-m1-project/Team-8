function TakeNfromMap (ImgDataset,ImgDatasetX, ImgDatasetY, byClassRemaining)

[ADataset,BDataset,CDataset,DDataset,EDataset,FDataset]=GroupImgsOnDatasetByClass(ImgDataset);

%%%%                 A                  %%%%

keySet = keys(ADataset);

sortVec=randperm(length(keySet));

for i=1:byClassRemaining(1)
    ImgDatasetX(keySet{i})=ImgDataset(keySet{sortVec(i)});
end
for i=(byClassRemaining(1)+1):length(sortVec)
    ImgDatasetY(keySet{i})=ImgDataset(keySet{sortVec(i)});
end

clear keySet;
clear sortVec;

%%%%                 B                  %%%%

keySet = keys(BDataset);

sortVec=randperm(length(keySet));

for i=1:byClassRemaining(2)
    ImgDatasetX(keySet{i})=ImgDataset(keySet{sortVec(i)});
end
for i=(byClassRemaining(2)+1):length(sortVec)
    ImgDatasetY(keySet{i})=ImgDataset(keySet{sortVec(i)});
end

clear keySet;
clear sortVec;

%%%%                 C                  %%%%

keySet = keys(CDataset);

sortVec=randperm(length(keySet));

for i=1:byClassRemaining(3)
    ImgDatasetX(keySet{i})=ImgDataset(keySet{sortVec(i)});
end
for i=(byClassRemaining(3)+1):length(sortVec)
    ImgDatasetY(keySet{i})=ImgDataset(keySet{sortVec(i)});
end

clear keySet;
clear sortVec;

%%%%                 D                  %%%%

keySet = keys(DDataset);

sortVec=randperm(length(keySet));

for i=1:byClassRemaining(4)
    ImgDatasetX(keySet{i})=ImgDataset(keySet{sortVec(i)});
end
for i=(byClassRemaining(4)+1):length(sortVec)
    ImgDatasetY(keySet{i})=ImgDataset(keySet{sortVec(i)});
end

clear keySet;
clear sortVec;

%%%%                 E                  %%%%

keySet = keys(EDataset);

sortVec=randperm(length(keySet));

for i=1:byClassRemaining(5)
    ImgDatasetX(keySet{i})=ImgDataset(keySet{sortVec(i)});
end
for i=(byClassRemaining(5)+1):length(sortVec)
    ImgDatasetY(keySet{i})=ImgDataset(keySet{sortVec(i)});
end

clear keySet;
clear sortVec;

%%%%                 F                  %%%%

keySet = keys(FDataset);

sortVec=randperm(length(keySet));

for i=1:byClassRemaining(6)
    ImgDatasetX(keySet{i})=ImgDataset(keySet{sortVec(i)});
end
for i=(byClassRemaining(6)+1):length(sortVec)
    ImgDatasetY(keySet{i})=ImgDataset(keySet{sortVec(i)});
end

clear keySet;
clear sortVec;

