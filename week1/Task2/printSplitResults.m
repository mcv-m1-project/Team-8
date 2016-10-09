fileTrainingDataSet=fopen('PureTrainingImageList.txt','w+');
fileValidationDataSet=fopen('ValidationImageList.txt','w+');
for i=1:length(trainImages)
    fprintf(fileTrainingDataSet, trainImages(i).FileName);
end
for i=1:length(validationImages)
    fprintf(fileTrainingDataSet, validationImages(i).FileName);
end
