function filteredMask = filterWindowMask(mask, bboxes)
%imwindow is the bounding box over the input image mask
    
    imwindow = zeros(size(mask));
    for i=1:size(bboxes,1)
        wx = bboxes(i).x;
        ww = bboxes(i).w;
        wy = bboxes(i).y;
        wh = bboxes(i).h;
        imwindow(wy:wy+wh-1, wx:wx+ww-1) = 1;
    end
    % Workarround to fix problems with bounding boxes exceeding image
    % dimensions.
    [h, w] = size(mask);
    filteredMask = mask .* imwindow(1:h, 1:w);
end
    