function [proj] = BackProjection(im, model, color_conversion)
% BackProjection
% Project onto a given image the pixel probabilities contained
% in a signal color model.
%
%   function [proj] = BackProjection(im, model, color_conversion)
%
%    Parameter name      Value
%    --------------      -----
%    im                  The image to be backprojected
%    model               The color model probabilities to backproject.
%    color_conversion    Optional parameter, default value 0. When
%                        not equal to 0, a RGB->HSL conversion will
%                        be performed.
% 
% NOTE: Use ExtractHistograms() and then ComputeColorModel() to obtain a
% color model. The color model is the first parameter returned by
% ComputeColorModel().
    
    % Convert to HSL color space when required
    if (nargin == 3) & color_conversion
        im = colorspace('RGB->HSL', double(im) / 255);
    end
    
    % Split channels
    h = im(:,:,1);
    s = im(:,:,2);
    l = im(:,:,3);

    % Quantization and shift
    h = floor(h / 20) + 1;        % range 1:19
    s = floor(s * 9) + 1;         % range 1:10

    % Backprojection
    h = reshape(h, [size(im,1) * size(im,2), 1]);
    s = reshape(s, [size(im,1) * size(im,2), 1]);
    
    n_rows = 19;
    idx = (s - 1) * n_rows + h;
    proj = reshape(model(idx), size(im, 1), size(im, 2));
end

