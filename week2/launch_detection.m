addpath(genpath('.'))

if exist('color_model.mat', 'file')
    load color_model.mat
else
    [hc, hl, cl] = ExtractHistograms('/home/ihcv08/dataset/trial3/puretrain');
    [color_model, prob_lum, classes] = ComputeColorModels(hc, hl, cl);
    save color_model.mat color_model
end

figure

ax1 = subplot(3,1,1);
imagesc(color_model(:,:,1))
colormap(ax1, summer)
colorbar
title('Red-White-Black Signals')

ax2 = subplot(3,1,2);
imagesc(color_model(:,:,2))
colormap(ax2, summer)
colorbar
title('Blue-White-Black Signals')

ax3 = subplot(3,1,3);
imagesc(color_model(:,:,3))
colormap(ax3, summer)
colorbar
title('Red-Blue Signals')

TrafficSignDetection('/home/ihcv08/dataset/trial3/validation', color_model, 0.05);


