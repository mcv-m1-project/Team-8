function OutputImg = M1_Team8_Closing (InputImg, structel, struCent, Times)

if Times>1
    [structel,struCent]=ErodeStructel(structel, struCent, Times-1);
end

ProcessedImg = InputImg;

ProcessedImg = M1_Team8_Dilation(ProcessedImg,structel,struCent);

ProcessedImg = M1_Team8_Erosion(ProcessedImg,structel,struCent);

OutputImg=ProcessedImg;