function [combinations, F1score, confmat, fig] = EvaluateConnCompThresholds ...
        (valid_dir, ...
         form_factor_min, ...
         form_factor_max, ...
         filling_ratio_min, ...
         filling_ratio_max)
% EvaluateConnCompThresholds
% For each combination of the given thresholds this function
% compute its F1-score and plot the Precision-Recall curve with
% the results.
%
%   function [combinations, F1score, fig] = EvaluateConnCompThresholds(...)
%
%    Parameter name      Value
%    --------------      -----
%    valid_dir           The folder with the validation dataset. It
%                        must be contain a pixelCandidates/
%                        subfolder, with the images generated by
%                        the Block 2 detector (color segmentation +
%                        morphology)
%    form_factor_min     Vector with the values to test for the
%                        form_factor_min threshold.
%    form_factor_max     Idem
%    filling_ratio_min   Idem
%    filling_ratio_max   Idem
%
% The function resturns a matrix 'combinations' with size Nx4 with
% all the combinations for the given threshold values. It also
% returns their F1-scores in a Nx1 column vector and their
% values for TP, FP, FN in a Nx3 matrix. The last object returned
% is a figure with the Precision-Recall curve.

    max_i = size(form_factor_min, 2);
    max_j = size(form_factor_max, 2);
    max_k = size(filling_ratio_min, 2);
    max_l = size(filling_ratio_max, 2);

    combinations = [];
    TP = [];
    FP = [];
    FN = [];  
    for i=1:max_i
        for j=1:max_j
            for k=1:max_k
                for l=1:max_l
                    c = [form_factor_min(i), form_factor_max(j), ...
                         filling_ratio_min(k), filling_ratio_max(l)];
                    combinations = [combinations; c];
                    
                    fprintf('FitThresholds: (%d) %f, %f, %f, %f\n', ...
                            size(TP, 1), c(1), c(2), c(3), c(4));

                                  
                    [localTP, localFP, localFN] = ...
                        ConnectedComponentDetection(valid_dir, ...
                                                    form_factor_min(i), ...
                                                    form_factor_max(j), ...
                                                    filling_ratio_min(k), ...
                                                    filling_ratio_max(l));
                    
                    TP = [TP; localTP];
                    FP = [FP; localFP];
                    FN = [FN; localFN];
                end
            end
        end
    end
    
    F1score = 2 * TP ./ (2 * TP + FP + FN);
    confmat = horzcat(TP, FP, FN);
    
    labels = cellfun(@num2str,num2cell(1:size(TP,1)), ...
                     'uniformoutput', 0);
    fig = ShowPrecisionRecallCurve(labels, TP, FP, FN);
end