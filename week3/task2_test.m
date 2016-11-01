%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generates masks and bounding boxes from test directory for submission
%using a simple sliding window
%Parameter to be tuned for color model generation
backproj_thr = 0.022;
saturation_thr = 0.3;
%Directory with images to analyze
test_dir = '/home/ihcv08/dataset/test';
%Directory to save the resulting masks (png) and bounding boxes (mat)
output_dir = '/home/ihcv08/m1-results/week3/test/sliding_results';

%Sliding window parameters:
%
%step_w: window step. Distance in pixels to avoid neighbour
%windows selecting the window performing maximum filling ratio
step_w = 8;
%
%fr_threshold: min filling ratio to consider a window contains object
fr_threshold = 0.3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'))

% Perform test
TrafficSignWindow_test(test_dir, ...
                     color_model, ...
                     backproj_thr, ...
                     saturation_thr,step_w,fr_threshold,output_dir);
                 %F1_score = 2*((windowPrecision * windowAccuracy)/(windowPrecision + windowAccuracy))
                