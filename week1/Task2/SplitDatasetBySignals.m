%Run to compute two datasets from a set of files on an specific location in
%the server. The resulting datasets are called ImgDatasetX and ImgDatasetY,
%which correspond to training and validation datasets.

clear all

%Load the path, the list of files and the image dataset

PathLocation = '/home/ihcv08/Ignasi/Datasets/train/';

gtFiles=ListTxtFilesWithPath(strcat(PathLocation,'gt/'));

ImgDataset = initDataset(gtFiles,PathLocation);

AssignPhotoClasses(ImgDataset);

%We count the amount of images by class that we have at the begining and
%the amount we want in the Train dataset at the end

byClass = countByClass(ImgDataset);
byClassWantedInTrain = 0.7.*byClass;
byClassWantedInTrain = round(byClassWantedInTrain);
byClassWantedInTrain(5) = byClassWantedInTrain(5)-1;                        %This is hard-coded beacuse rounding all the amounts it results in one more image, so we exctract it from Es (nearest class to half)

%Build the datasets by the amount of signals on the images

[SingleSignals, DoubleSignals, TripleSignals] = classifyByAmount(ImgDataset);

%Assign images with more than one signal to the new datasets

[ImgDatasetTrain,ImgDatasetValid]=SplitMultiSignals(ImgDataset);

%Compute how many signals we have in each by class and how many remain to
%our ideal number

byClassInTrainOnlyMulti = countByClass(ImgDatasetTrain);
byClassInValidOnlyMulti = countByClass(ImgDatasetValid);
byClassRemainingUntilWantedInTrain = byClassWantedInTrain - byClassInTrainOnlyMulti;

%Assign the images of one signal to the new datasets to obtain the amounts
%we wanted

TakeNfromMap(SingleSignals, ImgDatasetTrain, ImgDatasetValid, byClassRemainingUntilWantedInTrain);

%Compute the amounts we have in each dataset by class

byClassInTrainFinal = countByClass(ImgDatasetTrain);

byClassInValidFinal = countByClass(ImgDatasetValid);

%Store the results on two .txt files

printSplitResults(ImgDatasetTrain,ImgDatasetValid,'TrainingImagesList.txt','ValidationImagesList.txt');

%Build the file structure for the datasets into train and validation
%folders

BuildFileStructure(ImgDatasetTrain, ImgDatasetValid, strrep(PathLocation,'train/',''));

%Check if datasets are equilibrated in a feature sense

[FeatureTableTrain,SignalListTrain] = ExtractSignalFeatures(strrep(PathLocation,'train/','puretrain/'));
[FeatureTableValid,SignalListValid] = ExtractSignalFeatures(strrep(PathLocation,'train/','validation/'));

[summaryTrain, classes] = SummarizeSignalFeatures(FeatureTableTrain,SignalListTrain,'type');
[summaryValid, classes] = SummarizeSignalFeatures(FeatureTableValid,SignalListValid,'type');

PrintSummaries(summaryTrain, )

