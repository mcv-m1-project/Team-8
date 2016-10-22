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

    % Quantization
    [hue_bins, sat_bins] = size(model);
    hue_bin_size = 360 / hue_bins;
    sat_bin_size = 1 / sat_bins;
    
    h = uint16(ceil(h / hue_bin_size));
    s = uint16(ceil(s / sat_bin_size));
    
    h(h >= hue_bins+1) = hue_bins;  % ensure range 1:num bins
    s(s >= sat_bins+1) = sat_bins;
    
    h(h == 0) = 1;  % ensure range 1:num bins
    s(s == 0) = 1;

    % Backprojection
    h = reshape(h, [size(im,1) * size(im,2), 1]);
    s = reshape(s, [size(im,1) * size(im,2), 1]);
    
    idx = (s - 1) * hue_bins + h;
    proj = reshape(model(idx), size(im, 1), size(im, 2));
end

