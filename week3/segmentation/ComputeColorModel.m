function [prob_chr, prob_lum] = ComputeColorModel(histo_chr, histo_lum, class)
% ComputeColorModels
% Compute a color model for the traffic signals taking their
% histograms as input. The color model will be composed of two
% probability distributions for each of the following signal groups:
% - red-white-black signals (types A, B and C).
% - blue-white-black signals (types D and F).
% - red_blue signals (type E).
%
%   function [prob_chr, prob_lum, labels] = ComputeColorModels(histo_chr, histo_lum, class)
%
%    Parameter name      Value
%    --------------      -----
%    histo_chr           Hue-Saturation histograms stacked as a 3D array
%                        (Size [hue_bins, sat_bins, N])
%    histo_lum           Luminance histograms stacked as a 2D array
%                        (Size [N, lum_bins])
%    class               The column vector of size N, with the class
%                        label of each signal.
%
% NOTE: use ExtractHistograms() to obtain all these input parameters.
%
% The Hue-Saturation joint probability distributio is computed by adding all
% the Hue-Saturation histograms for a given group and then
% normalizing the result. The probability for each group is stacked
% into the 'prob_chr' output array with size [hue_bins, sat_bins, 3].
%
% Similarly for the Luminance probability distribution, its results
% are stacked into the 'prob_lum' output array with size [lum_bins, 3].

    filters = {'ABC', 'DF', 'E'};  % classes: 'red_white_black', 'blue_white_black', 'red_blue'
    prob_chr = zeros(size(histo_chr, 1), size(histo_chr, 2), 3);
    prob_lum = zeros(size(histo_lum, 2), 3);

    for i = 1:size(filters, 2)
        % create mask to filter by group
        mask = zeros(size(class));
        filter = filters{i};
        for j = 1:size(filter, 2)
            mask = mask | class == filter(j);
        end

        % compute color probability distribution
        n = sum(sum(histo_lum(mask, :), 1));
        prob_chr(:,:,i) = sum(histo_chr(:,:,mask), 3) / n;
        prob_lum(:,i) = sum(histo_lum(mask,:), 1) / n;
    end
end