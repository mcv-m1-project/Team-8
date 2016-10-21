addpath(genpath('.'))

[hc, hl, cl] = ExtractHistograms('/home/ihcv08/dataset/trial3/puretrain');
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);

save color_model.mat color_model;

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


