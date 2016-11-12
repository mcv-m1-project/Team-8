function [newbboxarray] = HoughFilter(im, bboxarray)
% HoughFilter
% The function filter out the bounding boxes in bboxarray
% with a Heuristics.Each window is evaluated first applying Standard Hough
% Transform and later Circular Hough Transform.
% The parameters to be tuned are the following:
%CIRCLES
%rad_range : min and max radius of the circles expressed [min max]
rad_range = [7 44];
%grd_thres : gradient magintude threshold
grd_thres = 5;
%cir_tol : cirle tolerance picking likely values [max tolerance = 0.1,
%min tolerance = 1]
cir_tol = 20;
%min_circle_acc : minimum circle accumulation of peak in Circle Hough
%Transform to considere existing circle object
min_circle_acc = 1000;
%
%RECTANGLES
%min_line_length: minimume length to consider line
min_line_length = 20;
%Gap filing in pixels
fill_gap = 5;
%rho resolution
rho_res = 0.5;
%theta resolution
theta_res = 0.5;
%minimum hough transform accumulation of [theta rho] to consider line.
min_accum = 28;
newbboxarray = [];

    for i=1:size(bboxarray, 1)
        b_find = false;
        box = bboxarray(i);
        crop = im(box.y:box.y+box.h-1, box.x:box.x+box.w-1,:);
        
        grayCrop  = rgb2gray(crop);
        eqCrop = histeq(grayCrop);
        %eqCrop = grayCrop;
        %RECTANGLES
        edgeCrop = edge(eqCrop,'canny');
        [H,T,R] = hough(edgeCrop,'RhoResolution',rho_res,'ThetaResolution',theta_res);
        P  = houghpeaks(H,2);
        %P
        if(~isempty(P(:,:) ))
            %peak1 = H(P(1,1),P(1,2));
            %peak2 = H(P(2,1),P(2,2));
            %Evaluate peak accumulation is over 40
            %if((peak1 >=40 && peak2 >= 40));
            if(H(P(1,1),P(1,2)) >= min_accum || H(P(2,1),P(2,2)) >= min_accum)
                %Min length line set at 40 and fillgap 5
                lines = houghlines(edgeCrop,T,R,P,'FillGap',fill_gap,'MinLength',min_line_length);
                %DrawLinesHough(crop,lines,0,0,0,'rect');
                if(~isempty(lines))
                    newbboxarray = [newbboxarray; bboxarray(i)];
                    b_find = true;
                end
           end
        end
        %CIRCLES
        if((size(crop,1) > 32 && size(crop,2) > 32) && b_find == false)
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