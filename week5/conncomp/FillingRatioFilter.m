function [newbboxarray] = FillingRatioFilter(im, bboxarray, min, max)
% FillingRatioFilter
% The function filter out the bounding boxes in bboxarray
% with a filling ratio not in the [min, max] interval.
% Filling ratio = object pixels / bounding box pixels.

    newbboxarray = [];
    for i=1:size(bboxarray, 1)
        box = bboxarray(i);
        crop = im(box.y:box.y+box.h-1, box.x:box.x+box.w-1);
        filrat = sum(sum(crop)) / (box.w * box.h);
        if (filrat >= min) & (filrat <= max)
            newbboxarray = [newbboxarray; bboxarray(i)];
        end
    end
end