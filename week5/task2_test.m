%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for Task2.
%
% This script create the submission for Block 5 - Task 2.
% 
% We use UCM segmentation and some subsequent filters to
% detect signals in the image.

% Thresholds values for this task
ucm_thr = 0.7;
ucm_scale = 1/2;
area_min = 1100;
area_max = 16000;
form_factor_min = 0.55;
form_factor_max = 1.20;
filling_ratio_min = 0.48;
filling_ratio_max = 1;

% Folders to use
test_dir = '/home/ihcv08/dataset/test/';
test_output_dir = '/home/ihcv08/dataset/test/ucm_results/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./evaluation');
addpath('./segmentation_ucm');
addpath(genpath('./ucm'));

% Fit filter parameters
TrafficSignDetectionUCM_test(test_dir, ...
                             test_output_dir, ...
                             ucm_thr, ...
                             ucm_scale, ...
                             area_min, ...
                             area_max, ...
                             form_factor_min, ...
                             form_factor_max, ...
                             filling_ratio_min, ...
                             filling_ratio_max);
