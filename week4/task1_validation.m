%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for the Task1 validation.
%
% This script use the validation dataset to test several
% threshold values in order to find the best one.
%
% The threshold to tune is the `cross correlation threshold`.
% When performing cross correlation to an image with the signal
% templates, if any window gets a result >= xcorr threshold, then
% is labeled as `signal`, otherwise as `background`.

% List of cross correlation thresholds to test. Values must be in
% the range [0, 169].
xcorr_thr_trials = 110:2:150;

% This set the number of pyramid levels and the scaling factor
% used in each one. It must be sorted from the biggest to the smallest.
pyr_scales = [1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1];

% Maximun overlapping allowed before applying non-maximun
% suppression to the candidate bounding boxes.
overlap_thr = 0.50;

% Directories
train_dir = '/home/ihcv08/dataset/trial3/puretrain';
valid_dir = '/home/ihcv08/dataset/trial3/validation';
result_subdir = '';  % Leave empty when not debugging

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

% Create templates
tri = imread('image_templates/13x13/template_triangle.png');
tri = im2bw(tri, 0);

inv = flipdim(tri, 1);

rec = imread('image_templates/13x13/template_rect.png');
rec = im2bw(rec, 0);

sqr = imread('image_templates/13x13/template_square.png');
sqr = im2bw(sqr, 0);

cir = imread('image_templates/13x13/template_circle.png');
cir = im2bw(cir, 0);

templates = {tri, inv, rec, sqr, cir};

% Test all threshold values with the validation dataset
TP = [];
FP = [];
FN = [];
for i = 1:length(xcorr_thr_trials) 
    [localTP, localFP, localFN] = TrafficSignDetectionXCorr(valid_dir, ...
                                                      templates, ...
                                                      pyr_scales, ...
                                                      xcorr_thr_trials(i), ...
                                                      overlap_thr, ...
                                                      result_subdir);
    TP = [TP; localTP];
    FP = [FP; localFP];
    FN = [FN; localFN];
end

F1score = 2 * TP ./ (2 * TP + FP + FN);

% Print F1-score for each threshold
fprintf('Summary of trials and their F1-score, TP, FP, FN:\n');
disp(horzcat(xcorr_thr_trials', F1score, TP, FP, FN));

% Find the best threshold based on F1-score
[best, idx] = max(F1score);
fprintf('The best combination is threshold %d, ', xcorr_thr_trials(idx));
fprintf('with a f1-score of %f.\n', best);

% Show PR-curve
labels = {};
for i = 1:length(xcorr_thr_trials)
    labels{end+1} = int2str(xcorr_thr_trials(i));
end
fig = ShowPrecisionRecallCurve(labels, TP, FP, FN);

