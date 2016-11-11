function [combinations, F1score, confmat, fig] = TestUCMFilters
    (valid_dir, ucm_dir, area_min, area_max, valid_dir, form_factor_min, ...
     form_factor_max, filling_ratio_min, filling_ratio_max)
% TestUCMFilters
% 
% For each combination of the given thresholds this function
% compute its F1-score and plot the Precision-Recall curve with
% the results.
%
% The aim of this function is to find the best filter thresholds
% to be applied after UCM segmentation. The signal candidates
% should be the segments which pass the filters.
%
% In order to save time, this function expects a folder with the
% precomputed UCM segmentations. See ucm_dir param.
%
%   function [combinations, F1score, fig] = TestUCMFilters(...)
%
%    Parameter name      Value
%    --------------      -----
%    valid_dir           The folder with the validation dataset.
%
%    ucm_dir             Directory with the precomputed results for
%                        the UCM segmentation. This is built with
%                        the function GenerateSegmentCandidates().
%
%    ...                 The rest of parameters are the thresholds
%                        to discard the candidates when out of the
%                        of ranges.
%
% The function returns a matrix 'combinations' with size Nx4 with
% all the combinations for the given threshold values. It also
% returns their F1-scores in a Nx1 column vector and their
% values for TP, FP, FN in a Nx3 matrix. The last object returned
% is a figure with the Precision-Recall curve.

    max_i = size(area_min, 2);  
    max_j = size(area_max, 2);  
    max_k = size(form_factor_min, 2);  
    max_l = size(form_factor_max, 2);  
    max_m = size(filling_ratio_min, 2);
    max_n = size(filling_ratio_max, 2);

    combinations = [];
    TP = [];
    FP = [];
    FN = [];
    
    for i=1:max_i
        for j=1:max_j
            for k=1:max_k
                for l=1:max_l
                    for m=1:max_m
                        for n=1:max_n
                            c = [area_min(i), area_max(j), ...
                                 form_factor_min(k), form_factor_max(l), ...
                                 filling_ratio_min(m), filling_ratio_max(n)];
                            combinations = [combinations; c];
                            
                            fprintf('FitThresholds: (%d) %f, %f, %f, %f, %f, %f\n', ...
                                    size(TP, 1), c(1), c(2), c(3), ...
                                    c(4), c(5), c(6));
                                  
                            [localTP, localFP, localFN] = ...
                                EvaluateFilterPerformance(valid_dir, ...
                                                          ucm_dir, ...
                                                          area_min(i), ...
                                                          area_max(j), ...
                                                          form_factor_min(k), ...
                                                          form_factor_max(l), ...
                                                          filling_ratio_min(m), ...
                                                          filling_ratio_max(n));
                    
                            TP = [TP; localTP];
                            FP = [FP; localFP];
                            FN = [FN; localFN];
                        end
                    end
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