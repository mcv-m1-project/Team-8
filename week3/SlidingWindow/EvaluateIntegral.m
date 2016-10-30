function [isbox, filling_ratio]=EvaluateIntegral(IntegralImg,TheBox,threshold)

filling_ratio = (IntegralImg(TheBox(1)-1,TheBox(3)-1) - IntegralImg(TheBox(2),TheBox(3)-1) - IntegralImg(TheBox(1)-1,TheBox(4)) + IntegralImg(TheBox(2),TheBox(4)))/((TheBox(2)-TheBox(1)+1)*(TheBox(4)-TheBox(3)+1));

if(filling_ratio > threshold)
  isbox = true;
else
  isbox = false;
end
