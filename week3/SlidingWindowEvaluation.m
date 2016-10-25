addpath('SlidingWindow');

BoundingBoxes=containers.Map;

directory='/home/ihcv08/dataset/trial3/puretrain/mask';

MaskFiles=ListFiles(directory);

for i=1:length(MaskFiles)
  Img=imread(strcat(strcat(directory,'/'),MaskFiles(i).name));
  BoundingBoxes{MaskFiles(i).name}=CandidateBoxesByWindow(Img);
end