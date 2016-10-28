function [newbboxarray] = FormFactorFilter(bboxarray, min, max)
% FormFactorFilter
% The function filter out the bounding boxes in bboxarray
% with a form factor not in the [min, max] interval.
% Form factor = width / height.

    newbboxarray = [];
    for i=1:size(bboxarray, 2)
        formfact = bboxarray(i).w / bboxarray(i).h;
        if (formfact >= min) & (formfact <= max)
            newbboxarray = [newbboxarray; bboxarray(i)];
        end
    end
end