%function M1_Team8_TopHat: Performs the morphological top hat of an 
%image.
%
%Input
%   -InputImg: Matrix of numbers -> the image to operate
%   -structel: Matrix of numbers -> the structuring element to use
%   -struCent: Array of Integer -> center of the structuring element
%   -Times: Integer -> times to apply each lower-level operator
%
%Output
%   -OutputImg: The resulting image of the top hat
function OutputImg = M1_Team8_TopHat (InputImg, structel, struCent, Times)

OpenedImg = M1_Team8_Opening(InputImg,structel,struCent,Times);

OutputImg = double(InputImg) - OpenedImg;