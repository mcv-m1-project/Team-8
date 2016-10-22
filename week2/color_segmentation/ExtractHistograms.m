function [histo_chr, histo_lum, class] = ExtractHistograms(dir, ...
                                                      hue_bins, sat_bins, lum_bins)
% ExtractHistograms
% Compute histograms in the HSL colorspace for each signal found
% in the directory. The histograms are uniformly quantized into
% bins, according to the input parameters.
%
%   function [histo_chr, histo_lum, class] =
%                ExtractHistograms(dir, hue_bins, sat_bins, lum_bins)
%
%    Parameter name      Value
%    --------------      -----
%    dir                 Directory with the jpg files and with
%                        subdirs gt/ and mask/.
%    hue_bins            Number of bins in the hue axis.
%    sat_bins            Number of bins in the saturation axis.
%    lum_bins            Number of bins in the luminance axis.
%
% For each signal the function returns a 2D joint histogram for hue
% (y-axis) and saturation (x-axis), and a 1D histogram for
% the luminance.
%
% The 2D histograms are stacked into the output variable
% 'histo_chr'. This array will have a size [hue_bins, sat_bins,
% N], where N is the number of signals found in 'dir'.
%
% Similarly, the 1D histograms are stacked into 'histo_lum',
% with size [N, lum_bins].
%
% The class label of each signal is stored in the 'class'
% column vector of size [N, 1].

    histo_chr = [];
    histo_lum = [];
    class = '';

    hue_bin_size = 360 / hue_bins;
    sat_bin_size = 1 / sat_bins;
    lum_bin_size = 1 / lum_bins;

    files = ListFiles(dir);

    for i = 1:size(files, 1)
        disp(files(i).name);
        name = files(i).name(1:9);
        txt = strcat(dir, '/gt/gt.', name, '.txt');
        png = strcat(dir, '/mask/mask.', name, '.png');
        jpg = strcat(dir, '/', files(i).name);

        im = imread(jpg);
        gt = imread(png);
        [window, type] = LoadAnnotations(txt);

        for j = 1:size(window, 1)

            % Extract crop with the signal
            x1 = round(window(j).x);
            y1 = round(window(j).y);
            x2 = round(window(j).x + window(j).w);
            y2 = round(window(j).y + window(j).h);

            mask = gt(y1:y2, x1:x2);
            crop = im(y1:y2, x1:x2, :);

            % There are some empty mask!! All pixels == 0. Maybe bug?
            if sum(mask(:)) == 0
                disp(['mask in ', png, ' is empty!']);
                break;
            end

            % Convert color space to HSL
            crop = colorspace('RGB->HSL', double(crop) / 255);

            % Extract channels and filter out background pixels
            h = crop(:,:,1);
            h = h(find(mask));
            s = crop(:,:,2);
            s = s(find(mask));
            l = crop(:,:,3);
            l = l(find(mask));

            % Quantization
            h = uint16(ceil(h / hue_bin_size));
            s = uint16(ceil(s / sat_bin_size));
            l = uint16(ceil(l / lum_bin_size));

            h(h >= hue_bins+1) = hue_bins;  % ensure range 1:num bins
            s(s >= sat_bins+1) = sat_bins;
            l(l >= lum_bins+1) = lum_bins;

            h(h == 0) = 1;  % ensure range 1:num bins
            s(s == 0) = 1;
            l(l == 0) = 1;

            % Build signal histograms
            chr = accumarray([h, s], 1, [hue_bins, sat_bins]);
            lum = accumarray(l, 1, [lum_bins, 1]);

            % Stack histograms and class label
            histo_chr = cat(3, histo_chr, chr);
            histo_lum = [histo_lum; lum.'];
            class = [class; type{j}];
        end
    end
end