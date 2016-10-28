function [bboxarray] = ConnectedComponents(im)
% ConnectedComponents
% Extract the connected components from the binary image im
% and return their bounding boxes.
%
% bboxarray is an array of structs containing the bounding
% boxes. Their properties are: x, y, w, h.

    imlabl = bwlabel(im);
    stats = regionprops(imlabl, 'BoundingBox');

    bboxarray = [];
    for i=1:size(stats, 1)
        bbox = floor(stats(i).BoundingBox);
        % Add +1 to x/y components because first row/column always
        % are empty (?). Object starts at second row/column.
        bboxarray = [bboxarray; struct('x', bbox(1) + 1, 'y', bbox(2) + 1, ...
                                       'w', bbox(3), 'h', bbox(4))];
    end
end