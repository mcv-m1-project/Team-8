%function M1_Team8_Opening: Performs the morphological opening of an 
%image.
%
%Input
%   -InputImg: Matrix of numbers -> the image to operate
%   -structel: Matrix of numbers -> the structuring element to use
%   -struCent: Array of Integer -> center of the structuring element
%   -Times: Integer -> times to apply each lower-level operator
%
%Output
%   -OutputImg: The resulting image of the opening
function OutputImg = M1_Team8_Opening (InputImg, structel, struCent, Times)

if Times>1
    [structel,struCent]=ErodeStructel(structel, struCent, Times-1);
end

ProcessedImg = InputImg;

ProcessedImg = M1_Team8_Erosion(ProcessedImg,structel,struCent);

ProcessedImg = M1_Team8_Dilation(ProcessedImg,structel,struCent);

OutputImg=ProcessedImg;