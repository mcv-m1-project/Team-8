addpath(genpath('.'))

[hc, hl, cl] = ExtractHistograms('/home/ihcv08/dataset/trial3/puretrain');
[model, prob_lum] = ComputeColorModel(hc, hl, cl);

figure

ax1 = subplot(3,1,1);
imagesc(model(:,:,1))
colormap(ax1, summer)
colorbar
title('Red-White-Black Signals')

ax2 = subplot(3,1,2);
imagesc(model(:,:,2))
colormap(ax2, summer)
colorbar
title('Blue-White-Black Signals')

ax3 = subplot(3,1,3);
imagesc(model(:,:,3))
colormap(ax3, summer)
colorbar
title('Red-Blue Signals')


