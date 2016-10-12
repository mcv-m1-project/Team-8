function AssignPhotoClasses(ImgDataset)

keySet=keys(ImgDataset);

for i=1:length(keySet)
    CrImg=ImgDataset(keySet{i});
    content = fileread(CrImg.PhotoGTFileAssociated);
    SigEnd=strfind(content,sprintf('\n'));
    CrImg.PhotoAmountOfSignals = length(SigEnd);
    if CrImg.PhotoAmountOfSignals==1        
        CrImg.PhotoRealClass = content(SigEnd(1)-1);
    elseif CrImg.PhotoAmountOfSignals==2
        CrImg.PhotoRealClass = strcat(content(SigEnd(1)-1),content(SigEnd(2)-1));
    elseif CrImg.PhotoAmountOfSignals==3
        CrImg.PhotoRealClass = strcat(strcat(content(SigEnd(1)-1),content(SigEnd(2)-1)),content(SigEnd(3)-1));
    end
    ImgDataset(keySet{i})=CrImg;
end

