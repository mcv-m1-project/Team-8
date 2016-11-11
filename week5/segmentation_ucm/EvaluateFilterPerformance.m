function [windowTP, windowFP, windowFN] = EvaluateFilterPerformance(valid_dir, ...
                                                  ucm_dir, ...
                                                  area_min, ...
                                                  area_max, ...
                                                  form_factor_min, ...
                                                  form_factor_max, ...
                                                  filling_ratio_min, ...
                                                  filling_ratio_max)
% EvaluateFilterPerformance
% 
% Validation test for ucm segmentation + filters. 
% The ucm segmentation must be performed before calling this 
% function, and the resulted folder passed in parameter ucm_dir.
% 
%  function [windowTP, windowFP, windowFN] = EvaluateFilterPerformance(...)
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
% Returns TP, FP, FN for the object-based evaluation.

    im_files = ListFiles(valid_dir);
    mat_files = ListFiles(ucm_dir);
    
    pixelTP = 0;
    pixelFP = 0;
    pixelFN = 0;
    pixelTN = 0;
    windowTP = 0;
    windowFP = 0;
    windowFN = 0;
    tic
    for i=1:size(im_files, 1)
        fprintf('.');
        
        gt_file = ['gt.', im_files(i).name(1:end-3), 'txt'];
        windowAnnotations = LoadAnnotations([valid_dir, '/gt/', gt_file]);
        
        mask_file = ['mask.', im_files(i).name(1:end-3), 'png'];
        pixelAnnotation = imread([valid_dir, '/mask/', mask_file]);
        
        load([ucm_dir, '/', im_files(i).name(1:end-3), 'mat'], ...
             'stats');

        bboxes = [];
        pixelCandidates = zeros(size(pixelAnnotation));
        for j=1:size(stats, 2)
            % Filters
            a = AreaFilter(stats(j), area_min, area_max);
            b = FillingRatioFilter(stats(j), ...
                                   filling_ratio_min, ...
                                   filling_ratio_max);
            c = FormFactorFilter(stats(j), ...
                                 form_factor_min, ...
                                 form_factor_max);
            
            % Select candidate when passing all filters
            if a && b && c
                % Object detection
                b.x = stats(j).Left;
                b.y = stats(j).Top;
                b.width = stats(j).Width;
                b.height = stats(j).Height;
                bboxes = [bboxes; b];
                
                % Pixel detection
                pixelCandidates(stats(j).Top:stats(j).Bott, ...
                                stats(j).Left:stats(j).Right) = stats(j).maskcrop;                    
            end
        end

        % Compute performance (pixel level)
        [localTP, localFP, localFN, localTN] = ...
            PerformanceAccumulationPixel(pixelCandidates, ...
                                         pixelAnnotation);
        pixelTP = pixelTP + localTP;
        pixelFP = pixelFP + localFP;
        pixelFN = pixelFN + localFN;
        pixelTN = pixelTN + localTN;        
        
        % Compute performance (object level)
        [localTP, localFN, localFP] = PerformanceAccumulationWindow(bboxes, ...
                                                          windowAnnotations);
        windowTP = windowTP + localTP;
        windowFP = windowFP + localFP;
        windowFN = windowFN + localFN;
    end
    toc

    fprintf('\n');
    fprintf('time/frame (ms): %f\n', toc/size(im_files, 1));

    fprintf('pixel results:\n');
    fprintf('- TP, FP, FN, TN: %d, %d, %d, %d \n', ...
            pixelTP, pixelFP, pixelFN, pixelTN);
   
     [prec, acc, specf, rec] = PerformanceEvaluationPixel(pixelTP, ...
                                                       pixelFP, ...
                                                       pixelFN, pixelTN);
     fprintf('- prec, acc, specf, rec: %f, %f, %f, %f \n\n', ...
             prec, acc, specf, rec);
end