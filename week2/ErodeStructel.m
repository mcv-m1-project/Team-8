%function ErodeStructel: takes a structuring element an erodes it using
%itself
%
%Input
%   -structel: Matrix of numbers -> the structuring element to erode
%   -struCent: Array of Integer -> center of the structuring element
%   -Times: Integer -> times to be eroded
%
%Output
%   -NewStructel: the eroded structuring element
%   -NewStruCent: the center of the eroded structuring element
function [NewStructel,NewStruCent] = ErodeStructel(structel,struCent,times)

NewStructel = 255*ones(((times+1)*size(structel))-times);

NewStructel(((times*(struCent(1)-1))+1):(((times*(struCent(1)-1))+size(structel,1))),((times*(struCent(2)-1))+1):(((times*(struCent(2)-1))+size(structel,2)))) = structel;

NewStruCent = struCent;

for i=1:times
    NewStructel=M1_Team8_Erosion(NewStructel, structel, struCent);
    NewStruCent=NewStruCent+struCent-[1,1];
end

end

