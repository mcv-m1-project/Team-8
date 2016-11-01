function bBoxes = CandidateBoxesByWindow(Imag,step,fr_threshold)

%Constant Values
MAX_H=220.53;
MAX_W=273.53;
MIN_H=30.36;
MIN_W=29.46;
MEAN_H=91.45;
MEAN_W=86.64;



WindowSize=[floor(MIN_H),ceil(MIN_W)];

%ImagePyramid=mountPyramid(Imag,[1,(1/3),(1/9)]);

factors=[1,(1/3),(1/9)];

CurImg= imresize(Imag,factors(end));

factors=fliplr(factors);

bBoxes = [];

for i=1:length(factors)
  %figure;imshow(255*CurImg)
  %CurbBoxes=slideWindow(CurImg,WindowSize,step,fr_threshold);
  CurbBoxes=slideWindowByConv(CurImg,WindowSize,step,fr_threshold);
  %CurbBoxes=slideWindowWithIntegral(CurImg,WindowSize,step,fr_threshold);
  for k=1:size(CurbBoxes,1)
    CurImg(CurbBoxes(k,1):CurbBoxes(k,2),CurbBoxes(k,3):CurbBoxes(k,4))=0;
  end
  %CurbBoxes
  %figure;imshow(CurImg);
  %size(CurImg)
  %CurbBoxes
  if size(CurbBoxes,1)~=0
    CurbBoxes(:,1:2)=CurbBoxes(:,1:2)/size(CurImg,1);
    CurbBoxes(:,3:4)=CurbBoxes(:,3:4)/size(CurImg,2);
  end
  bBoxes=[bBoxes;CurbBoxes];
  if i<length(factors)
    %size(CurImg)
    CurImg=imresize(CurImg,(factors(i+1)/factors(i)));
  end
end
if size(bBoxes,1)~=0
    bBoxes(:,1:2) = round(bBoxes(:,1:2)*size(Imag,1));
    bBoxes(:,3:4) = round(bBoxes(:,3:4)*size(Imag,2));
end