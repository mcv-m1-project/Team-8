function [newbboxarray] = HoughFilter(im, bboxarray)
% HoughFilter
% The function filter out the bounding boxes in bboxarray
% with a Heuristics.Each window is evaluated first applying Standard Hough
% Transform and later Circular Hough Transform.
% The parameters to be tuned are the following:
%rad_range : min and max radius of the circles expressed [min max]
rad_range = [10 60];
%grd_thres : gradient magrintude threshold
grd_thres = 5;
%cir_tol : cirle tolerance picking likely values [max tolerance = 0.1,
%min tolerance = 1]
cir_tol = 20;
%min_circle_acc : minimum circle accumulation of peak in Circle Hough
%Transform to considere existing circle object
min_circle_acc = 2000;
newbboxarray = [];

    for i=1:size(bboxarray, 1)
        box = bboxarray(i);
        crop = im(box.y:box.y+box.h-1, box.x:box.x+box.w-1,:);
        
        grayCrop  = rgb2gray(crop);
        eqCrop = histeq(grayCrop);
        %eqCrop = grayCrop;
        %RECTANGLES
        edgeCrop = edge(eqCrop,'canny');
        [H,T,R] = hough(edgeCrop,'RhoResolution',0.5,'ThetaResolution',0.5);
        P  = houghpeaks(H,2);
        %P
        if(~isempty(P(:,:) ))
            %peak1 = H(P(1,1),P(1,2));
            %peak2 = H(P(2,1),P(2,2));
            %Evaluate peak accumulation is over 40
            %if((peak1 >=40 && peak2 >= 40));
            if(H(P(1,1),P(1,2)) >= 40 || H(P(2,1),P(2,2)) >= 40)
                %Min length line set at 40 and fillgap 5
                lines = houghlines(edgeCrop,T,R,P,'FillGap',5,'MinLength',20);
                %DrawLinesHough(crop,lines,0,0,0,'rect');
                if(~isempty(lines))
                    newbboxarray = [newbboxarray; bboxarray(i)];
                end
           end
        end
        %CIRCLES
        if(size(crop,1) > 32 && size(crop,2) > 32)
            [accum, circen, cirrad] = CircularHough_Grd(eqCrop, rad_range, grd_thres, cir_tol);
            if(circen)
                if(max(max(accum)) > min_circle_acc)
                    newbboxarray = [newbboxarray; bboxarray(i)];
                    %DrawLinesHough(crop,0,accum,circen,cirrad,'circ');
                end
            end
        end
    end
end