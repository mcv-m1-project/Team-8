%initDataset: from a given list of ground-truth files about image files and
%the path to them, it builds a dataset of those images.
%
%Input:
%   -gtfiles: Array of Strings -> Files containing the info to label images
%   -thePath: String -> Path to the previous ground-truth files
%Output:
%   -ImgDataset: Map of PhotoInDataset -> dataset of the images, as a
%   dictionary referenced by the file names without any extension

function ImgDataSet = initDataset(gtFiles,thePath)

ImgDataSet = containers.Map;

for i=1:length(gtFiles)
    CleanName=strrep(strrep(gtFiles(i).name,'.txt',''),'gt/gt.','');
    CleanName=CleanName((length(thePath)+1):end);
    CrPhoto = PhotoInDataset;
    CrPhoto.PhotoName = strcat(CleanName,'.jpg');
    CrPhoto.PhotoGTFileAssociated = gtFiles(i).name;
    ImgDataSet(CleanName)=CrPhoto;
end

end