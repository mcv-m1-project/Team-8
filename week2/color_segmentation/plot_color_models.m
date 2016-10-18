[hc, hl, cl] = ExtractHistograms('/home/ihcv08/dataset/trial3/puretrain');
[prob_chr, prob_lum, classes] = ComputeColorModels(hc, hl, cl);

figure

ax1 = subplot(3,1,1);
imagesc(prob_chr(:,:,1))
colormap(ax1, summer)
colorbar
title('Red-White-Black Signals', 'FontSize', 18, 'FontWeight', 'bold')

ax2 = subplot(3,1,2);
imagesc(prob_chr(:,:,2))
colormap(ax2, summer)
colorbar
title('Blue-White-Black Signals')

ax3 = subplot(3,1,3);
imagesc(prob_chr(:,:,3))
colormap(ax3, summer)
colorbar
title('Red-Blue Signals')
