n_hue_bins = 20;
n_sat_bins = 4;

a = 360 / n_hue_bins;
b = 1 / n_sat_bins;

palette_min = zeros(n_hue_bins, n_sat_bins, 3);
palette_max = zeros(n_hue_bins, n_sat_bins, 3);

for i=1:n_hue_bins
    for j=1:n_sat_bins
        palette_min(i,j,:) = colorspace('HSL->RGB', [(i-1)*a, (j-1)*b, 0.5]);
        palette_max(i,j,:) = colorspace('HSL->RGB', [i*a, j*b, 0.5]);
    end
end

figure;

ax1 = subplot(1,2,1);
imshow(palette_min, 'InitialMagnification', 2000);
title('Min bin color')
ax2 = subplot(1,2,2);
imshow(palette_max, 'InitialMagnification', 2000);
title('Max bin color')
