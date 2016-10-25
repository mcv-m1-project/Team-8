function ImgList = mountPyramid (Imag, factors)

for i=1:length(factors)
  ImgList{i}=imresize(Imag,factors(i));
end