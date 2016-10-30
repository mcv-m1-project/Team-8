%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter to be tuned
backproj_thr = 0.022;
saturation_thr = 0.3
test_dir = '/home/ihcv08/dataset/test';
output_dir = '/home/ihcv08/m1-results/week3/test/sliding_results';
%CWINDOW PARAMETERS
%step_w: window step. Distance in pixels to avoid neighbour
%windows selecting the window performing maximum filling ratio
%
%fr_threshold: min filling ratio to consider a window contains object
fr_threshold = 0.3;
step_w = 8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'))

tic
% Perform test
TrafficSignWindow_test(test_dir, ...
                     color_model, ...
                     backproj_thr, ...
                     saturation_thr,step_w,fr_threshold,output_dir);
                 %F1_score = 2*((windowPrecision * windowAccuracy)/(windowPrecision + windowAccuracy))
                