function [newim] = DrawBoundingBoxes(im, detections, annotations)
% DrawBoundingBoxes
%
% Function to draw the rectangles in detections and color them in
% green when they are TP, in red when are FP or in yellow when they are FN.
%
% Rectangles format is [ struct(x,y,w,h) ; struct(x,y,w,h) ; ... ] in both
% detections and annotations.
%
% An object is considered to be detected correctly if detection and annotation 
% windows overlap by more of 50%
%
%   function [TP,FN,FP] = DrawBoundingBoxes(im, detections, annotations)
%
%    Parameter name      Value
%    --------------      -----
%    'im'                The image where the rectangles will be drawn.
%    'detections'        List of windows marking the candidate detections
%    'annotations'       List of windows with the ground truth positions of the objects
%
% The function returns a copy of 'im' with the colored rectangles.

    detectionsUsed = zeros(1,size(detections,1));
    annotationsUsed = zeros(1,size(annotations,1));
    newim = cat(3, im, im, im) * 255;
    
    % Draw TP
    for i=1:size(detections,1)
        x1 = round(detections(i).x);
        y1 = round(detections(i).y);
        x2 = round(detections(i).x + detections(i).w - 1);
        y2 = round(detections(i).y + detections(i).h - 1);
        
        for j=1:size(annotations,1)
            if RoiOverlapping(annotations(j), detections(i)) > 0.5
                newim(y1:y2, x1, 2) = 255;
                newim(y1:y2, x2, 2) = 255;
                newim(y1, x1:x2, 2) = 255;
                newim(y2, x1:x2, 2) = 255;
                
                detectionsUsed(i) = 1;
                annotationsUsed(j) = 1;
                break
            end
        end
    end

    % Draw FP
    for i=1:size(detections, 1)
        x1 = round(detections(i).x);
        y1 = round(detections(i).y);
        x2 = round(detections(i).x + detections(i).w - 1);
        y2 = round(detections(i).y + detections(i).h - 1);

        if detectionsUsed(i) == 0
            newim(y1:y2, x1, 1) = 255;
            newim(y1:y2, x2, 1) = 255;
            newim(y1, x1:x2, 1) = 255;
            newim(y2, x1:x2, 1) = 255;
        end
    end
    
    % Draw FN
    for i=1:size(annotations, 1)
        x1 = round(annotations(i).x);
        y1 = round(annotations(i).y);
        x2 = round(annotations(i).x + annotations(i).w - 1);
        y2 = round(annotations(i).y + annotations(i).h - 1);

        if annotationsUsed(i) == 0
            newim(y1:y2, x1, 1) = 255;
            newim(y1:y2, x2, 1) = 255;
            newim(y1, x1:x2, 1) = 255;
            newim(y2, x1:x2, 1) = 255;
            newim(y1:y2, x1, 2) = 255;
            newim(y1:y2, x2, 2) = 255;
            newim(y1, x1:x2, 2) = 255;
            newim(y2, x1:x2, 2) = 255;
        end
    end    
end
