function OutputImg = M1_Team8_Opening (InputImg, structel, struCent, Times)

ProcessedImg = InputImg;

for i=1:Times
  ProcessedImg = M1_Team8_Erosion(ProcessedImg,structel,struCent);
end

for i=1:Times
  ProcessedImg = M1_Team8_Dilation(ProcessedImg,structel,struCent);
end

OutputImg=ProcessedImg;