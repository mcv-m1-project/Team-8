function ImgDataSet = initDataset(gtFiles,thePath)

ImgDataSet = containers.Map;

for i=1:length(gtFiles)
    CleanName=strrep(strrep(gtFiles(i).name,'.txt',''),'gt/gt.','');
    CleanName=CleanName((length(thePath)+1):end);
    CrPhoto = PhotoInDataset;
    CrPhoto.PhotoName = strcat(CleanName,'.jpg');
    ImgDataSet(CleanName)=CrPhoto;
end

end