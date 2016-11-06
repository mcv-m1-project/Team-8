function TrafficSignDetectionXCorr_test(input_dir, ...
                                        output_dir, ...
                                        model, ...
                                        templates, ...
                                        pyr_scales, ...
                                        xcorr_thr, ...
                                        overlap_thr)
% TrafficSignDetectionXCorr_test
%
% Perform detection of Traffic signs on images. Detection is
% performed first at the pixel level using a color
% segmentation. Then, using the color segmentation as a basis, 
% the most likely window candidates to contain a traffic sign
% are selected using template matching with cross correlation.
%
% Use this function to create the week submission for Block 4 - Task 1.
%
%    Parameter name      Value
%    --------------      -----
%    'input_dir'         Directory where the test images to analize (.jpg) reside.
%    'output_dir'        Directory where the results will be stored.
%    'model'             Array with the chroma model to use in
%                        color segmentation.
%    'templates'         Templates to use in signal detection. 
%                        Given as a cell array of binary images.
%    'pyr_scales'        Factors to apply in each pyramid
%                        level. Vector sorted from biggest to smallest.
%    'xcorr_thr'         Threshold to consider a matching as a
%                        positive detection.
%    'overlap_thr'       Max % of overlapping allowed before
%                        applying non-maximum suppression.

    if exist(output_dir, 'dir') == 0
        mkdir(output_dir);
    end
    
    % Flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);
    
    % Thresholds for the pixel detection stage
    backproj_thr = 0.022;
    saturation_thr = 0.3;
    
    files = ListFiles(input_dir);
    
    tic
    for i=1:size(files,1),

        fprintf('%s\n', files(i).name);
        
        % Read file
        im = imread(strcat(input_dir,'/',files(i).name));
        
        % Candidate generation (pixel)
        im = colorspace('RGB->HSL', double(im) / 255);
        
        pixelCandidates = BackProjection(im, model) >= backproj_thr;
        pixelCandidates = pixelCandidates & (im(:,:,2) >= saturation_thr);
        
        pixelCandidates = imfill(pixelCandidates,'holes');
        pixelCandidates = imopen(pixelCandidates, strel('disk', 7));
        pixelCandidates = imdilate(pixelCandidates, strel('disk',4));
        
        % Candidate generation (window)
        downsample = imresize(pixelCandidates, 1/3);  % Time optimization
        pyr = Pyramid(downsample, pyr_scales);
        [bboxarr, score] = XCorrTemplateMatching(pyr, ...
                                                 templates, ...
                                                 xcorr_thr);
        bboxarr = NonMaximumSuppression(bboxarr, score, overlap_thr);
        
        % Restore original size and coords
        bboxarr = round(bboxarr * 3);  
        
        % Adjust bbox to the image dimensions
        [h, w] = size(im);
        for j = 1:size(bboxarr, 1)            
            bboxarr(j, 1) = max(1, bboxarr(j, 1));
            bboxarr(j, 2) = max(1, bboxarr(j, 2));
            x2 = bboxarr(j, 1) + bboxarr(j, 3);
            y2 = bboxarr(j, 2) + bboxarr(j, 4);
            if w < x2
                bboxarr(j, 3) = bboxarr(j, 3) - (x2 - w);
            end
            if h < y2
                bboxarr(j, 4) = bboxarr(j, 4) - (y2 - h);
            end
        end

        % Convert bounding boxes to proper format (array of structs)
        windowCandidates = BoundingBoxesToStruct(bboxarr);

        % Filter pixel mask with detected windows
        pixelCandidates = filterWindowMask(pixelCandidates, windowCandidates);
        
        % Save results
        pixel_file = sprintf('%s/%s.png', output_dir, files(i).name(1:end-4));
        imwrite(pixelCandidates, pixel_file);
        
        window_file = sprintf('%s/%s.mat', output_dir, files(i).name(1:end-4));
        save(window_file, 'windowCandidates');
    end
    
    toc
    fprintf('\n');
    fprintf('time/frame (ms): %f\n', toc/size(files, 1));
end
