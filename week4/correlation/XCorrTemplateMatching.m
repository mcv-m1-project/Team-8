function [bboxarr, score] = XCorrTemplateMatching(pyramid, patterns, threshold)
% pyramid: cell array of binary images (pixel values: 0/1) (the
%          first one must be the original)
% patterns: cell array of images (pixel values: 0/1)
% ---
% bboxarr: Nx4 matrix (columns: x, y, width, height)

    % Convert pixel values from 0/1 into -1/1
    fn = @(im) 2 * im - 1;
    pyramid = cellfun(fn, pyramid, 'UniformOutput', 0);
    patterns = cellfun(fn, patterns, 'UniformOutput', 0);
    
    bboxarr = [];
    score = [];
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