function [byClass,AList,BList,CList,DList,EList,FList] = countByClassToSplit(ImgDataset)

byClass=zeros(6,1);
AList=[];
BList=[];
CList=[];
DList=[];
EList=[];
FList=[];

keySet = keys(ImgDataset);

for i=1:length(keySet)
    CrImg=ImgDataset(keySet{i});
    if CrImg.PhotoFictionClass == 'A'
        byClass(1)=byClass(1)+1;
        AList=[AList;keySet{i}];
    elseif CrImg.PhotoFictionClass == 'B'
        byClass(2)=byClass(2)+1;
        BList=[BList;keySet{i}];
    elseif CrImg.PhotoFictionClass == 'C'
        byClass(3)=byClass(3)+1;
        CList=[CList;keySet{i}];
    elseif CrImg.PhotoFictionClass == 'D'
        byClass(4)=byClass(4)+1;
        DList=[DList;keySet{i}];
    elseif CrImg.PhotoFictionClass == 'E'
        byClass(5)=byClass(5)+1;
        EList=[EList;keySet{i}];
    elseif CrImg.PhotoFictionClass == 'F'
        byClass(6)=byClass(6)+1;
        FList=[FList;keySet{i}];
    end
end

end