function [ImgDatasetX,ImgDatasetY] = DoSplit(ImgDataset, AList,ASamples,BList,BSamples,CList,CSamples,DList,DSamples,EList,ESamples,FList,FSamples)

ImgDatasetX=containers.Map;
ImgDatasetY=containers.Map;

for i=1:length(AList)
    if length(strmatch(AList(i,:),ASamples))==0
        ImgDatasetY(AList(i,:))=ImgDataset(AList(i,:));
    else
        ImgDatasetX(AList(i,:))=ImgDataset(AList(i,:));
    end    
end
for i=1:length(BList)
    if length(strmatch(BList(i,:),BSamples))==0
        ImgDatasetY(BList(i,:))=ImgDataset(BList(i,:));
    else
        ImgDatasetX(BList(i,:))=ImgDataset(BList(i,:));
    end    
end
for i=1:length(CList)
    if length(strmatch(CList(i,:),CSamples))==0
        ImgDatasetY(CList(i,:))=ImgDataset(CList(i,:));
    else
        ImgDatasetX(CList(i,:))=ImgDataset(CList(i,:));
    end    
end
for i=1:length(DList)
    if length(strmatch(DList(i,:),DSamples))==0
        ImgDatasetY(DList(i,:))=ImgDataset(DList(i,:));
    else
        ImgDatasetX(DList(i,:))=ImgDataset(DList(i,:));
    end    
end
for i=1:length(EList)
    if length(strmatch(EList(i),ESamples))==0
        ImgDatasetY(EList(i,:))=ImgDataset(EList(i,:));
    else
        ImgDatasetX(EList(i,:))=ImgDataset(EList(i,:));
    end    
end
for i=1:length(FList)
    if length(strmatch(FList(i,:),FSamples))==0
        ImgDatasetY(FList(i,:))=ImgDataset(FList(i,:));
    else
        ImgDatasetX(FList(i,:))=ImgDataset(FList(i,:));
    end    
end