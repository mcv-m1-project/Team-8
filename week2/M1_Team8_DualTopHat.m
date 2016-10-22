%function M1_Team8_DualTopHat: Performs the morphological dual top hat of an 
%image.
%
%Input
%   -InputImg: Matrix of numbers -> the image to operate
%   -structel: Matrix of numbers -> the structuring element to use
%   -struCent: Array of Integer -> center of the structuring element
%   -Times: Integer -> times to apply each lower-level operator
%
%Output
%   -OutputImg: The resulting image of the dual top hat
function OutputImg = M1_Team8_DualTopHat (InputImg, structel, struCent, Times)

ClosedImg = M1_Team8_Closing(InputImg,structel,struCent,Times);

OutputImg = 255*ones(size(InputImg)) - (ClosedImg - double(InputImg));