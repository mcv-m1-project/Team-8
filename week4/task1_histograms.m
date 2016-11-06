%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract histograms for the Task1.
%
% Compute and show signal histograms for form factor and width
% using the training dataset. Histograms are grouped by signal
% shape.
%
% This information is used for guiding the design of the signal
% templates of Task 1.

% Path to the training dataset
train_dir = '/home/ihcv08/dataset/trial3/puretrain/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('.'));

[features, signs] = ExtractSignalFeatures(train_dir);

binranges = (20:10:150) / 100;
bincounts = FeatureHistograms(features(:, 3), signs, binranges);

figure('Color', [1,1,1]);

ax1 = subplot(2,2,1);
bar(binranges, bincounts(1,:), 'histc');
title('Triangular shape');
xlabel('Form Factor');

ax2 = subplot(2,2,2);
bar(binranges, bincounts(2,:), 'histc');
title('Inverted triangular shape');
xlabel('Form Factor');

ax3 = subplot(2,2,3);
bar(binranges, bincounts(3,:), 'histc');
title('Circular shape');
xlabel('Form Factor');

ax4 = subplot(2,2,4);
bar(binranges, bincounts(4,:), 'histc');
title('Rectangular shape');
xlabel('Form Factor');

binranges = (10:20:280);
bincounts = FeatureHistograms(features(:, 2), signs, binranges);

figure('Color', [1,1,1]);

ax1 = subplot(2,2,1);
bar(binranges, bincounts(1,:), 'histc');
title('Triangular shape');
xlabel('Width');

ax2 = subplot(2,2,2);
bar(binranges, bincounts(2,:), 'histc');
title('Inverted triangular shape');
xlabel('Width');

ax3 = subplot(2,2,3);
bar(binranges, bincounts(3,:), 'histc');
title('Circular shape');
xlabel('Width');

ax4 = subplot(2,2,4);
bar(binranges, bincounts(4,:), 'histc');
title('Rectangular shape');
xlabel('Width');