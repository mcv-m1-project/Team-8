function bboxes2 = NonMaximumSuppression(bboxes, ...
                                         scores, ...
                                         overlap_thr)
% NonMaximumSuppression
%
% Apply non maximum suppression to select the best bounding box
% among each set of overlapping boxes.
% 
%  function [bboxes2] = NonMaximumSuppression(...)
% 
%    Parameter name      Value
%    --------------      -----
%    bboxes              Nx4 array with the initial bounding boxes.
%                        Array columns: x, y, width, height.
%    scores              Nx1 array with the score obtained for each
%                        bounding box when comparing with the
%                        templates.
%    overlap_thr         When two bounding boxes are overlapped for
%                        a factor of `overlap_thr` or greater, the
%                        non-max suppression strategy is applied to
%                        select only one candidate.
%
% The result is another bounding box array of Mx4, where M <= N.

    % If there are no boxes, return an empty array
    if length(bboxes) == 0
        bboxes2 = [];
        return
    end
    
    % Initialize the list of picked indexes	
    pick = [];
    
    % Grab the coordinates of the bounding boxes
    x1 = bboxes(:, 1);
    y1 = bboxes(:, 2);
    x2 = bboxes(:, 1) + bboxes(:, 3) - 1;
    y2 = bboxes(:, 2) + bboxes(:, 4) - 1;
    
    % Compute the area of the bounding boxes and sort the bounding
    % boxes by their scores
    area = bboxes(:, 3) .* bboxes(:, 4);
    [unused, idxs] = sort(scores);
    
    % Keep looping while some indexes still remain in the indexes
    % list
    while numel(idxs) > 0
        % Grab the last index in the indexes list and add the
        % index value to the list of picked indexes
        i = idxs(end);
        pick = [pick; i];
        idxs_rem = idxs(1:end-1);

        % Find the largest (x, y) coordinates for the start of
        % the bounding box and the smallest (x, y) coordinates
        % for the end of the bounding box
        xx1 = max(x1(i), x1(idxs_rem));
        yy1 = max(y1(i), y1(idxs_rem));
        xx2 = min(x2(i), x2(idxs_rem));
        yy2 = min(y2(i), y2(idxs_rem));

        % Compute the width and height of the bounding box
        w = max(0, xx2 - xx1 + 1);
    	h = max(0, yy2 - yy1 + 1);

        % Compute the ratio of overlap
        overlap = (w .* h) ./ min(area(i), area(idxs_rem));

        % Delete all indexes from the index list that have
        % a ratio of overlap greater than the given threshold
        idxs_rem(find(overlap > overlap_thr)) = [];
        
        % Update idxs to contain only the remaining ones
        idxs = idxs_rem;
    end  
    
    % Return only the bounding boxes that were picked using the
    % integer data type
    bboxes2 = bboxes(pick, :);
end