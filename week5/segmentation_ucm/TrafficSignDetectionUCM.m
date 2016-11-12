function [windowTP, windowFP, windowFN] = TrafficSignDetectionUCM(valid_dir, ...
                                                      ucm_thr, ...
                                                      ucm_scale, ...
                                                      area_min, ...
                                                      area_max, ...
                                                      form_factor_min, ...
                                                      form_factor_max, ...
                                                      filling_ratio_min, ...
                                                      filling_ratio_max, ...
                                                      result_subdir)
% 
% TrafficSignDetectionUCM
% Validation test for ucm segmentation + filters.
% 
%  function [windowTP, windowFP, windowFN] = TrafficSignDetectionUCM(valid_dir, ...
% 
%    Parameter name      Value
%    --------------      -----
%    valid_dir           The folder with the validation dataset.
%
%    result_subdir       Optional parameter. String with the folder name
%                        where to store the validation
%                        results. For each image several rects are
%                        drawn, with the TP, FP and FN results.
%                        The folder is created in valid_dir.

    im_files = ListFiles(valid_dir);
    
    if exist('result_subdir', 'var')
        mkdir([valid_dir, '/', result_subdir]);
    else
        result_subdir = '';
    end

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
        
        im = imread([valid_dir, '/', im_files(i).name]);
        
        stats = UCMSegmentation(im, ucm_thr, ucm_scale);
        
        bboxes = [];
        
        pixelCandidates = zeros(size(pixelAnnotation, 1), size(pixelAnnotation, 2));
        for j=1:size(stats, 1)
           % Filters
            a = AreaUCMFilter(stats(j), area_max, area_min);
            b = FillingRatioUCMFilter(stats(j), ...
                                      filling_ratio_max, ...
                                      filling_ratio_min);
            c = FormFactorUCMFilter(stats(j), ...
                                    form_factor_max, ...
                                    form_factor_min);
            
            % Select candidate when passing all filters
            if a && b && c
                % Object detection
                new.x = stats(j).bBox.Left;
                new.y = stats(j).bBox.Top;
                new.w = stats(j).bBox.Width;
                new.h = stats(j).bBox.Height;
                bboxes = [bboxes; new];
                
                % Pixel detection
                pixelCandidates(stats(j).bBox.Top:stats(j).bBox.Bott, ...
                                stats(j).bBox.Left:stats(j).bBox.Right) = pixelCandidates(stats(j).bBox.Top:stats(j).bBox.Bott, ...
                                  stats(j).bBox.Left:stats(j).bBox.Right) | stats(j).maskcrop(1:end-1,1:end-1);     
            end  
        end
        
        % Compute performance (object level)
        [localTP, localFN, localFP] = PerformanceAccumulationWindow(bboxes, ...
                                                          windowAnnotations);
        windowTP = windowTP + localTP;
        windowFP = windowFP + localFP;
        windowFN = windowFN + localFN;
        
        % Compute performance (pixel level)
        [localTP, localFP, localFN, localTN] = ...
            PerformanceAccumulationPixel(pixelCandidates, ...
                                         pixelAnnotation);
        pixelTP = pixelTP + localTP;
        pixelFP = pixelFP + localFP;
        pixelFN = pixelFN + localFN;
        pixelTN = pixelTN + localTN;
       
        if ~isempty(result_subdir)
            imresult = DrawBoundingBoxes(im, bboxes, windowAnnotations);
            imwrite(imresult, ...
                    [valid_dir, '/', result_subdir, '/', ...
                     im_files(i).name(1:end-3), 'png']);
        end
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