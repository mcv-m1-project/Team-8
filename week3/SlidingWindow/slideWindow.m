function Candidates= slideWindow(Imag,WinSize)

ImgSize=size(Imag);

step=[3,3];

Candidates=[];

for i=1:step(1):(ImgSize(1)-WinSize(1)+1)
  for j=1:step(2):(ImgSize(2)-WinSize(2)+1)
    crop=Imag(i:(i+WinSize(1)-1),j:(j+WinSize(2)-1));
    if EvaluateWind(crop)
      Candidates=[Candidates;i,(i+WinSize(1)-1),j,(j+WinSize(2)-1)];
    end
  end
end