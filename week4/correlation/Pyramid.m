function [imlist] = Pyramid(im, scales)
% imlist: cell array of images (im_scale1, ..., im_scaleN)

    imlist = {};
    for i = 1:length(scales)
        imlist{i} = imresize(im, scales(i));
    end
end