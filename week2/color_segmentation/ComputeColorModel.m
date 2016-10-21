function [prob_chr, prob_lum] = ComputeColorModel(histo_chr, histo_lum, class)
    % ComputeColorModels
    % The function compute 3 color models by grouping the signals according
    % to the following criteria:
    % - 'red_white_black': signal types A, B and C. 
    % - 'blue_white_black': signal types D and F.
    % - 'red_blue': signal type E.
    %
    % The color model of a signal is its color probability distribution,
    % splited into Hue-Saturation probability and Lightness probability.
    %
    %   function [prob_chr, prob_lum, labels] = ComputeColorModels(histo_chr, histo_lum, class)
    %
    %    Parameter name      Value
    %    --------------      -----
    %    histo_chr           The Hue-Saturation histogram matrix returned
    %                        by the ExtractHistograms() function. (Size
    %                        19x10xN)
    %    histo_lum           The Lightness histogram matrix returned by the
    %                        ExtractHistograms() function. (Size Nx10)
    %    class               The column vector of size N, with the class
    %                        label of each signal, returned by the
    %                        ExtractHistograms() function.
    %                        
    % The 'prob_chr' matrix has dimension 6x19x10. The first axis ranges
    % over the signal classes ('A', 'B', ..., 'F'). The second and third
    % axes range over the Hue and Saturation values. These values are
    % quantizing and shifted to the ranges [1:19] and [1:10] respectively.
    % For example, if prob_chr(1,2,4) == 0.03, then given a pixel from a
    % signal of type 'A', has a probability of 0.03 to have a (quantized)
    % hue == 2 and a (quantized) saturation == 4.
    %
    % The 'prob_lum' matrix has dimension 6x10 and represent the respective
    % probabilities for the (quantized) Lightness channel.
    %
    % The 6x1 column vector 'labels' contains the label of each class:
    % 'red_white_black', 'blue_white_black', 'red_blue'.
    
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

