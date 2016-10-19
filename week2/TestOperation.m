function [timeMatlab, timeCustom] = TestOperation(operation,testImg,structel,struCent)

if operation == 'Dilation'
  matStrel = strel ('square',size(structel,1));
  tic
  imdilate(testImg,structel);
  timeMatlab = toc;
  tic
  M1_Team8_Dilation(testImg,structel,struCent);
  timeCustom = toc;
end
elseif operation == 'Erosion'
  matStrel = strel ('square',size(structel,1));
  tic
  imerode(testImg,structel);
  timeMatlab = toc;
  tic
  M1_Team8_Erosion(testImg,structel,struCent);
  timeCustom = toc;
end