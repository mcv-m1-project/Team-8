function [bboxarr, score] = XCorrTemplateMatching(pyramid, patterns, ...
                                                  threshold)
% XCorrTemplateMatching
%
% Perform the detection of traffic signs over a pyramid of images.
% For that purpose a cross correlation template matching is used.
%
%  function [bboxarr, score] = XCorrTemplateMatching(...)
%
%    Parameter name      Value
%    --------------      -----
%    pyramid             Cell array of the same image at different
%                        scales. The first image must be the
%                        biggest one. All images must be binary.
%    patterns            Cell array with the pattern images. All
%                        of them must be binary images.
%    threshold           Minimum value for a cross correlation
%                        result to consider a positive matching
%                        between an image and a pattern.
%
% Two values are returned: `bboxarr` is a Nx4 matrix with the
% properties of the detected bounding boxes (x, y, width, height).
% `score` is a Nx1 column vector with the cross correlation score
% for each detected bounding box.

    bboxarr = [];
    score = [];

    % Optimization: if there is no pixel candidates, exit early
    if sum(sum(pyramid{1})) == 0
        return
    end

    % Convert pixel values from 0/1 into -1/1
    fn = @(im) 2 * im - 1;
    pyramid = cellfun(fn, pyramid, 'UniformOutput', 0);
    patterns = cellfun(fn, patterns, 'UniformOutput', 0);
    
    for i = 1:length(patterns)
        for j = 1:length(pyramid)
            % Find positive detections (coords and scores)
            corr = xcorr2(pyramid{j}, patterns{i});
            idx = find(corr >= threshold);
            s = corr(idx);
            [y, x] = ind2sub(size(corr), idx);
            
            % Shift to get upper-left corner coordinates
            [pt_h, pt_w] = size(patterns{i});
            x = x - pt_w + 1;
            y = y - pt_h + 1;
            
            % Normalize windows
            [im_h, im_w] = size(pyramid{j});
            y = y ./ im_h;
            x = x ./ im_w;
            h = repmat(pt_h / im_h, length(idx), 1);
            w = repmat(pt_w / im_w, length(idx), 1);
            
            % Stack results
            bboxarr = vertcat(bboxarr, [x, y, w, h]);
            score = vertcat(score, s);
        end
    end
    
    % Restore windows to original coordinate system
    [h, w] = size(pyramid{1});
    bboxarr(:, 1) = bboxarr(:, 1) * w;
    bboxarr(:, 2) = bboxarr(:, 2) * h;
    bboxarr(:, 3) = bboxarr(:, 3) * w;
    bboxarr(:, 4) = bboxarr(:, 4) * h;
end