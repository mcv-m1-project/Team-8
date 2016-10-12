function BuildFileStructure(ImgDatasetTrain, ImgDatasetValid, ThePath)

pathTrain = strcat(ThePath,'train/');
pathValidation = strcat(ThePath,'validation/');

rmdir(pathValidation);

mkdir(pathValidation);
mkdir(strcat(ThePath,'validation/gt/'));
mkdir(strcat(ThePath,'validation/mask/'));

keySet = keys(ImgDatasetValid);

for i=1:length(keySet)
    CrImg=ImgDatasetValid(keySet{i});
    movefile(strcat(pathTrain,CrImg.PhotoName),strcat(pathValidation,CrImg.PhotoName));
    maskFile = strrep(strcat('mask/mask.',CrImg.PhotoName),'.jpg','.png');
    movefile(strcat(pathTrain,maskFile),strcat(pathValid,maskFile));
    gtFile = strrep(CrImg.PhotoGTFileAssociated,pathTrain,'');
    movefile(strcat(pathTrain,gtFile),strcat(pathValidation,gtFile));
end





