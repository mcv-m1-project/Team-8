train_dir = '/home/ihcv08/dataset/trial3/puretrain/';
binranges = (20:10:150) / 100;

addpath(genpath('.'));

[features, signs] = ExtractSignalFeatures(train_dir);
bincounts = FormFactorHistograms(features(:, 3), signs, binranges);

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