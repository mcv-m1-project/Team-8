addpath('SlidingWindow');

BoundingBoxes=containers.Map;
step = 3;
fr_threshold = 0.1138;
directory='/home/ihcv08/m1-results/week3/output';

MaskFiles=ListFiles(directory);

%for i=1:length(MaskFiles)
for i=1:10
  Img=imread(strcat(strcat(directory,'/'),MaskFiles(i).name));
  BoundingBoxes(MaskFiles(i).name)=CandidateBoxesByWindow(Img,step,fr_threshold);
end