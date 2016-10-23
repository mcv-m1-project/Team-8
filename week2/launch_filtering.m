addpath(genpath('.'))

valid_dir = '/home/ihcv08/dataset/trial3/validation';
test_radius = 22:24;
backproj_thr = 0.022;
sat_thr = 0.3;

% Create color model
[hc, hl, cl] = ExtractHistograms(train_dir, hue_bins, sat_bins, lum_bins);
[color_model, lum_model] = ComputeColorModel(hc, hl, cl);

% Perform test
rocaccumulation = TrafficSignFiltering(valid_dir, color_model, 0.022, ...
                                       0.3, test_radius);

% Plot results
figure;
% plot (rocaccumulation(:,1), rocaccumulation(:,2),'r');
% hold;
plot (rocaccumulation(:,1), rocaccumulation(:,2),'g');

%axis([0,1,0,1])
xlabel('Recall');
ylabel('Precision');
F1 = zeros(size(rocaccumulation));

for i=1:size(rocaccumulation(:,1))
    F1(i) = 2*((rocaccumulation(i,1) * rocaccumulation(i,2))/(rocaccumulation(i,1) + rocaccumulation(i,2)));
end
figure;
plot(F1,'r');
% hold;
plot(F1,'g');
xlabel('Opening Structural Element Size');
ylabel('F1 Score');