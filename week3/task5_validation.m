%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Script for evaluation in task 5 - Sliding Window
%Perform Precision and Recall from the validation dataset using convolution
%applied to sliding window
%Parameter to be tuned for color segmentation model
backproj_thr = 0.022;
saturation_thr = 0.3;
%Directory for model generation
train_dir = '/home/ihcv08/dataset/trial3/puretrain';
%Directory for validation
valid_dir = '/home/ihcv08/dataset/trial3/validation';
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

% Create color model
[hc, hl, cl] = ExtractHistograms(train_dir);
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);

% Perform Evaluation
[windowPrecision, windowSensitivity] = TrafficSignWindowConv_valid(valid_dir, ...
                     color_model, ...
                     backproj_thr, ...
                     saturation_thr,step_w,fr_threshold);
F1_score = 2*((windowPrecision * windowSensitivity)/(windowPrecision + windowSensitivity))
   
