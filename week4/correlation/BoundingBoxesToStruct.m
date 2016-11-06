function [output] = BoundingBoxesToStruct(bboxarr)
% BoundingBoxesToStruct
% Convert a matrix of bounding boxes into an array with the proper
% format to work with in the evaluation tests.
% 
%  function [output] = BoundingBoxesToStruct(bboxarr)
%   
%    Parameter name      Value
%    --------------      -----
%    bboxarr             Mx4 matrix with the bounding boxes
%                        Columns: x, y, width, height.
%
% The output is an array of structs with properties: x, y, w, h.
    
    output = [];
    for i = 1:size(bboxarr, 1)
        b.x = bboxarr(i, 1);
        b.y = bboxarr(i, 2);
        b.w = bboxarr(i, 3);
        b.h = bboxarr(i, 4);
        output = [output; b];
    end
end