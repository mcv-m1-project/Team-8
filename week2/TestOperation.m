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
end