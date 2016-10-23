%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter to be tuned
hue_bins = 19;
sat_bins = 10;
lum_bins = 5;  % useless but required in some function
thresholds = (10:5:100) / 1000;
train_dir = '/home/ihcv08/dataset/trial3/puretrain';
valid_dir = '/home/ihcv08/dataset/trial3/validation';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'))

% Show quantization to use in color model
quantization_fig = PlotQuantization(hue_bins, sat_bins);
fprintf(['Show quantization to use in color model. '...
         'Press any key to continue...\n']);
pause;

% Create color model
[hc, hl, cl] = ExtractHistograms(train_dir, hue_bins, sat_bins, lum_bins);
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);
color_model_fig = ShowColorModel(color_model);
fprintf('Show color model. Press key to continue...\n');
pause;

% Project probabilities onto each pixel in validation dataset
BackprojectImages(valid_dir, color_model);

% Compute confusion matrix for each threshold
confusion = EvaluateColorModelThresholds(valid_dir, thresholds);

TP = confusion(:,1);
FP = confusion(:,2);
FN = confusion(:,3);
TN = confusion(:,4);

% ROC and Precision-Recall curves
roc_fig = ShowROC(thresholds, TP, FP, FN, TN);
prc_fig = ShowPrecisionRecallCurve(thresholds, TP, FP, FN, TN);
fprintf(['Show ROC and Precision-Recall curves. ' ...
         'Press any key to continue...\n']);
pause;

% Summary
fprintf(['Confusion matrix [TP, ' ...
         'FP, FN, TN]:\n']);
disp(confusion);

precision = TP ./ (TP + FP);
accuracy = (TP + TN) ./ (TP + FP + FN + TN);
recall = TP ./ (TP + FN);
f1score = 2 * (precision .* recall) ./ (precision + recall);
f2score = 5 * (precision .* recall) ./ (4 * precision + recall);


fprintf(['Threshold, Precision, ' ...
         'Accuracy, Recall, F1-Score, F2-Score: \n']);
summary = [thresholds.', precision, ...
           accuracy, recall, f1score, f2score];
disp(summary)