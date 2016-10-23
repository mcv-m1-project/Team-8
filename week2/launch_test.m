%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter to be tuned
backproj_thr = 0.022;
saturation_thr = 0.3;
train_dir = '/home/ihcv08/dataset/trial3/puretrain';
test_dir = '/home/ihcv08/dataset/test';
test_dir_output = '/home/ihcv08/m1-results/week2/output';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'))

% Create color model
[hc, hl, cl] = ExtractHistograms(train_dir);
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);

% Show color model
color_model_fig = ShowColorModel(color_model);
fprintf('Show color model. Press key to continue...\n');
pause;

% Launch test
TrafficSignDetection_test(test_dir, ...
                          test_dir_output, ...
                          color_model, ...
                          backproj_thr, ...
                          saturation_thr);
