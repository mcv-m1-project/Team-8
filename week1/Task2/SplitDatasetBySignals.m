%Run to compute two datasets from a set of files on an specific location in
%the server. The resulting datasets are called ImgDatasetX and ImgDatasetY,
%which correspond to training and validation datasets.

clear all

PathLocation = '/home/ihcv00/DataSet/train/';

gtFiles=ListTxtFilesWithPath(strcat(PathLocation,'gt/'));

ImgDataset = initDataset(gtFiles,PathLocation);

AssignPhotoClasses(ImgDataset);

[SingleSignals, DoubleSignals, TripleSignals] = classifyByAmount(ImgDataset);

byClass = countByClass(ImgDataset);
byClassWantedInTrain = 0.7.*byClass;
byClassWantedInTrain = round(byClassWantedInTrain);
byClassWantedInTrain(5) = byClassWantedInTrain(5)-1;

[ImgDatasetTrain,ImgDatasetValid]=SplitMultiSignals(ImgDataset);

byClassInTrainOnlyMulti = countByClass(ImgDatasetTrain);
byClassInValidOnlyMulti = countByClass(ImgDatasetValid);
byClassRemainingUntilWantedInTrain = byClassWantedInTrain - byClassInTrainOnlyMulti;

TakeNfromMap(SingleSignals, ImgDatasetTrain, ImgDatasetValid, byClassRemainingUntilWantedInTrain);

byClassInTrainFinal = countByClass(ImgDatasetTrain);

byClassInValidFinal = countByClass(ImgDatasetValid);
