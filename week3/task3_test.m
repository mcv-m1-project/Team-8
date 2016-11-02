%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Generates masks and bounding boxes from test directory for submission
%using a simple sliding window

addpath(genpath('.'))
%Directory to save the resulting masks (png) and bounding boxes (mat)
output_dir = '/home/ihcv08/m1-results/week3/test/integral_results';
% Directory train
train_dir = '/home/ihcv08/dataset/trial3/puretrain/';
%Directory with images to analyze
test_dir = '/home/ihcv08/dataset/test';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parameter to be tuned for color model generation
backproj_thr = 0.022;
saturation_thr = 0.3;

% Create color model for the pixel detection stage
[hc, hl, cl] = ExtractHistograms(train_dir);
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);


%Sliding window parameters:
%
%step_w: window step. Distance in pixels to avoid neighbour
%windows selecting the window performing maximum filling ratio
step_w = 8;
%
%fr_threshold: min filling ratio to consider a window contains object
fr_threshold = 0.3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Perform test
TrafficSignWindowIntegral_test(test_dir, ...
                     color_model, ...
                     backproj_thr, ...
                     saturation_thr,step_w,fr_threshold,output_dir);
                 %F1_score = 2*((windowPrecision * windowAccuracy)/(windowPrecision + windowAccuracy))
                