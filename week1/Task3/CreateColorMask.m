function [chroma_mask] = CreateColorMask(prob_chr, thr)
    % CreateColorMask
    % The function returns a color mask given the color model of each
    % signal class.
    %
    %   function [chroma_mask] = CreateColorMask(prob_chr, thr)
    %
    %    Parameter name      Value
    %    --------------      -----
    %    prob_chr            The hue-saturation probability values returned
    %                        by ComputeColorModels() for each signal class.
    %                        (Size 6x19x10)
    %    thr                 Probability threshold to be applied to create 
    %                        the mask.
    %
    % The mask is a logical matrix of size 19x10 created by thresholding 
    % the hue-saturation model of each signal class and after that by
    % performing binary addition between the thresholded matrices.
    %
    % Therefor, the mask gives the hue-saturation values for which
    % its probability is higher or equal to thr in some of the color
    % models given in 'prob_chr'.

    [n_classes, rows, cols] = size(prob_chr);
    chroma_mask = zeros(rows, cols);
    
    for i = 1:n_classes
        coords = find(prob_chr(i,:,:) >= thr);
        chroma_mask(coords) = 1;
    end
    
end

