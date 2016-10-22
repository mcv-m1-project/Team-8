%function TestOperation: gives the computation time of an operation
%implemented by Matlab and by ourselves
%
%Input
%   -operation: Char -> operation to test
%   -testImg: Matrix of numbers -> image to use to test the operators
%   -structel: Matrix of numbers -> the structuring element to use
%   -struCent: Array of Integer -> center of the structuring element
%
%Output
%   -timeMatlab: Double -> time that takes matlab operator to run
%   -timeCustom: Double -> time that takes our operator to run
function [timeMatlab, timeCustom] = TestOperation(operation,testImg,structel,struCent)

if operation == 'D'
  matStrel = strel ('square',size(structel,1));
  tic
  imdilate(testImg,matStrel);
  timeMatlab = toc;
  tic
  M1_Team8_Dilation(testImg,structel,struCent);
  timeCustom = toc;
elseif operation == 'E'
  matStrel = strel ('square',size(structel,1));
  tic
  imerode(testImg,matStrel);
  timeMatlab = toc;
  tic
  M1_Team8_Erosion(testImg,structel,struCent);
  timeCustom = toc;
elseif operation == 'O'
  matStrel = strel ('square',size(structel,1));
  tic
  imopen(testImg,matStrel);
  timeMatlab = toc;
  tic
  M1_Team8_Opening(testImg,structel,struCent,1);
  timeCustom = toc;
elseif operation == 'C'
  matStrel = strel ('square',size(structel,1));
  tic
  imclose(testImg,matStrel);
  timeMatlab = toc;
  tic
  M1_Team8_Closing(testImg,structel,struCent,1);
  timeCustom = toc;
elseif operation == 'T'
  matStrel = strel ('square',size(structel,1));
  tic
  imtophat(testImg,matStrel);
  timeMatlab = toc;
  tic
  M1_Team8_TopHat(testImg,structel,struCent,1);
  timeCustom = toc;
elseif operation == 'U'
  matStrel = strel ('square',size(structel,1));
  tic
  imbothat(testImg,matStrel);
  timeMatlab = toc;
  tic
  M1_Team8_DualTopHat(testImg,structel,struCent,1);
  timeCustom = toc;
end