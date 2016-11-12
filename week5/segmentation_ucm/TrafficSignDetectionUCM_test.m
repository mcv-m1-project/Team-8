function [] = TrafficSignDetectionUCM_test(test_dir, ...
                                           test_output_dir, ...
                                           ucm_thr, ...
                                           ucm_scale, ...
                                           area_min, ...
                                           area_max, ...
                                           form_factor_min, ...
                                           form_factor_max, ...
                                           filling_ratio_min, ...
                                           filling_ratio_max)
% 
% TrafficSignDetectionUCM_Test
% 
% Function for test submission of Block 5 - Task 2

    im_files = ListFiles(test_dir);
    
    if exist(test_output_dir, 'dir') == 0
        mkdir(test_output_dir);
    end

    tic
    for i=1:size(im_files, 1)
        fprintf('%s\n', im_files(i).name);
        
        im = imread([test_dir, '/', im_files(i).name]);
        
        stats = UCMSegmentation(im, ucm_thr, ucm_scale);
        
        bboxes = [];
        pixelCandidates = zeros(size(im, 1), size(im, 2));
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
        
        % Save results
        pixel_file = sprintf('%s/%s.png', test_output_dir, im_files(i).name(1:end-4));
        imwrite(pixelCandidates, pixel_file);
        
        windowCandidates = bboxes;
        window_file = sprintf('%s/%s.mat', test_output_dir, im_files(i).name(1:end-4));
        save(window_file, 'windowCandidates');
    end
    toc

    fprintf('\n');
    fprintf('time/frame (ms): %f\n', toc/size(im_files, 1));
end