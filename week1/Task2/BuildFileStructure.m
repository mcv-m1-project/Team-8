function BuildFileStructure(ImgDatasetTrain, ImgDatasetValid, ThePath)

pathTrain = strcat(ThePath,'train/');
pathPureTrain = strcat(ThePath,'puretrain/');
pathValidation = strcat(ThePath,'validation/');

if exist(pathPureTrain)>0
    print exist(PathPureTrain)
    rmdir(pathpureTrain);
end

if exist(pathValidation)>0
    print exist(PathValidation)
    rmdir(pathValidation);
end

mkdir(pathPureTrain);
mkdir(strcat(ThePath,'puretrain/gt/'));
mkdir(strcat(ThePath,'puretrain/mask/'));

mkdir(pathValidation);
mkdir(strcat(ThePath,'validation/gt/'));
mkdir(strcat(ThePath,'validation/mask/'));

keySetPureTrain =keys(ImgDatasetTrain);
keySetValid = keys(ImgDatasetValid);

keySet = keySetPureTrain;

for i=1:length(keySet)
    CrImg=ImgDatasetTrain(keySet{i});
    copyfile(strcat(pathTrain,CrImg.PhotoName),strcat(pathPureTrain,CrImg.PhotoName));
    maskFile = strrep(strcat('mask/mask.',CrImg.PhotoName),'.jpg','.png');
    copyfile(strcat(pathTrain,maskFile),strcat(pathPureTrain,maskFile));
    gtFile = strrep(CrImg.PhotoGTFileAssociated,pathTrain,'');
    copyfile(strcat(pathTrain,gtFile),strcat(pathPureTrain,gtFile));
end

keySet = keySetValid;

for i=1:length(keySet)
    CrImg=ImgDatasetValid(keySet{i});
    copyfile(strcat(pathTrain,CrImg.PhotoName),strcat(pathValidation,CrImg.PhotoName));
    maskFile = strrep(strcat('mask/mask.',CrImg.PhotoName),'.jpg','.png');
    copyfile(strcat(pathTrain,maskFile),strcat(pathValidation,maskFile));
    gtFile = strrep(CrImg.PhotoGTFileAssociated,pathTrain,'');
    copyfile(strcat(pathTrain,gtFile),strcat(pathValidation,gtFile));
end



