function [imlist] = Pyramid(im, scales)
% Pyramid
%
% Build a pyramid of images given the original image and a list of
% scaling factors.
%
%  function [imlist] = Pyramid(im, scales)
%
%    Parameter name      Value
%    --------------      -----
%    im                  The original image
%    scales              Vector of N scaling factors.
%
% Return a cell array of images {im_scale1, ..., im_scaleN}.

    imlist = {};
    for i = 1:length(scales)
        imlist{i} = imresize(im, scales(i));
    end
end