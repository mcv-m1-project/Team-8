%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for the Task1 submission.
%
% Perform object detection using template matching.
% It follows the "global approach" and uses cross correlation
% to match the templates with the images.

% Threshold to consider a detection as positive. Value in [0, 169].
xcorr_thr = 138;

% This set the number of pyramid levels and the scaling factor
% used in each one. It must be sorted from the biggest to the smallest.
pyr_scales = [1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1];

% Maximun overlapping allowed before applying non-maximun
% suppression to the candidate bounding boxes.
overlap_thr = 0.50;

% Directories
train_dir = '/home/ihcv08/dataset/trial3/puretrain/';
test_dir = '/home/ihcv08/dataset/test/';
test_output_dir = '/home/ihcv08/dataset/test/xcorr_results/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'));

% Create color model for the pixel detection stage
[hc, hl, cl] = ExtractHistograms(train_dir);
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);
fprintf('-------------\n');

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

% Apply pixel detection + object detection (cross correlation matching)
TrafficSignDetectionXCorr_test(test_dir, ...
                               test_output_dir, ...
                               color_model, ...
                               templates, ...
                               pyr_scales, ...
                               xcorr_thr, ...
                               overlap_thr);