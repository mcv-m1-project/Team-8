%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for Task2.
%
% This script evaluate several thresholds to filter
% the partitions produced by ucm algorithm.
% 
% This helps us to find the best parameters for our 
% ucm segmentation approach.

% Thresholds sets. For each threshold, we try one or several
% values.
ucm_thr = 0.4;
ucm_scale = 1/2;
area_min = [800, 900, 1000, 1100];
area_max = [2000, 4000, 8000, 16000, 30000];
form_factor_min_trials = [0.45, 0.50, 0.55];
form_factor_max_trials = [1.20, 1.40, 1.50];
filling_ratio_min_trials = [0.40, 0.44, 0.48, 0.52, 0.60];
filling_ratio_max_trials = [1];

train_dir = '/home/ihcv08/dataset/trial3/puretrain';
valid_dir = '/home/ihcv08/dataset/trial3/validation';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./evaluation');
addpath('./segmentation_ucm');
addpath(genpath('./ucm'));

% Generate ucm results before fit parameters. 
% This save a lot of time!
%
% You can change ucm_thr variable to test with another
% contour threshold. The results for different contour thresholds
% will be saved in different folders.
ucm_dir = [valid_dir, '/ucm_thr_', num2str(ucm_thr)];

if exist(ucm_dir) ~= 7
    GenerateSegmentCandidates(valid_dir, ...
                              ucm_dir, ...
                              ucm_thr, ...
                              ucm_scale);
end

% Fit filter parameters
[combs, F1score, confmat, fig] = TestUCMFilters(valid_dir, ...
                                               ucm_dir, ...
                                               area_min, ...
                                               area_max, ...
                                               form_factor_min_trials, ...
                                               form_factor_max_trials, ...
                                               filling_ratio_min_trials, ...
                                               filling_ratio_max_trials);

% Print F1-score for each threshold combination
fprintf('Summary of trials and their F1-score, TP, FP, FN:\n');
disp(horzcat(combs, F1score, confmat));

% Find the best combination based on F1-score
[best, idx] = max(F1score);

fprintf('The best combination is:\n');
fprintf('- area_min: %f\n', combs(idx, 1));
fprintf('- area_max: %f\n', combs(idx, 2));
fprintf('- form_factor_min: %f\n', combs(idx, 3));
fprintf('- form_factor_max: %f\n', combs(idx, 4));
fprintf('- filling_ratio_min: %f\n', combs(idx, 5));
fprintf('- filling_ratio_max: %f\n', combs(idx, 6));
fprintf('With a F1-score of %f\n', best);