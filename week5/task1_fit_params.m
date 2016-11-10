%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for Task1.
%
% This script evaluate several thresholds to classify
% connected components as signal candidates or background.
% 
% This helps us to find the best parameters for our 
% detector in the connected component approach.

% Thresholds sets. For each threshold, we try one or several values.
%form_factor_min_trials = [0.47, 0.48, 0.49, 0.50, 0.51];
%form_factor_max_trials = [1.30, 1.35, 1.40, 1.42, 1.44];
%filling_ratio_min_trials = [0.43, 0.44, 0.45, 0.47, 0.50, 0.55]
%filling_ratio_max_trials = [1];
%WEEK 5 MODIFICATIONS
form_factor_min_trials = [0.49];
form_factor_max_trials = [1.30];
filling_ratio_min_trials = [0.44]
filling_ratio_max_trials = [1];

train_dir = '/home/ihcv08/dataset/trial3/puretrain';
valid_dir = '/home/ihcv08/dataset/trial3/validation';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'));

% Generate folder with the pixel detection results. It will be
% the input folder to fit the parameters for this Task 1.
pixelcand_dir = [valid_dir, '/pixelCandidates/'];
if exist(pixelcand_dir) ~= 7
    backproj_thr = 0.022;
    saturation_thr = 0.3;

    % Create color model
    [hc, hl, cl] = ExtractHistograms(train_dir);
    [color_model, lum_model] = ComputeColorModel(hc, hl, cl);
    
    % Generate folder with the pixel detection output
    GeneratePixelCandidates(valid_dir, ...
                            pixelcand_dir, ...
                            color_model, ...
                            backproj_thr, ...
                            saturation_thr);
end

% Evaluate all the combinations for the threshold values 
[combs, F1score, confmat, fig] = EvaluateConnCompThresholds(valid_dir, ...
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
fprintf('- form_factor_min: %f\n', combs(idx, 1));
fprintf('- form_factor_max: %f\n', combs(idx, 2));
fprintf('- filling_ratio_min: %f\n', combs(idx, 3));
fprintf('- filling_ratio_max: %f\n', combs(idx, 4));
fprintf('With a F1-score of %f\n', best);