%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for the Task1 submission.
%
% Perform object detection with a connected component approach.

% Thresholds to classify objects as signal candidates or background.
form_factor_min = 0.50;
form_factor_max = 1.30;
filling_ratio_min = 0.40;
filling_ratio_max = 1;

% Directories
train_dir = '/home/ihcv08/dataset/trial3/puretrain/';
test_dir = '/home/ihcv08/dataset/test/';
test_output_dir = '/home/ihcv08/dataset/test/conncomp_results/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'));

% Create color model for the pixel detection stage
[hc, hl, cl] = ExtractHistograms(train_dir);
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);
fprintf('-------------');

% Apply pixel detection + object detection (conncomp approach)
ConnectedComponentDetection_test(test_dir, ... 
                                 test_output_dir, ... 
                                 color_model, ...
                                 form_factor_min, ...
                                 form_factor_max, ...
                                 filling_ratio_min, ...
                                 filling_ratio_max)