function bBoxes = CandidateBoxesByWindow(Imag)

%Constant Values
MAX_H=220.53;
MAX_W=273.53;
MIN_H=30.36;
MIN_W=29.46;
MEAN_H=91.45;
MEAN_W=86.64;



WindowSize=[floor(MIN_H),ceil(MIN_W)];

ImagePyramid=mountPyramid(Imag,[1,(1/3),(1/9)]);

for i=1:length(ImagePyramid)
  bBoxes=slideWindow(ImagePyramid{i},WindowSize);
end