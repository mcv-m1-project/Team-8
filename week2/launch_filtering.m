addpath(genpath('.'))

valid_dir = '/home/ihcv08/dataset/trial3/validation';
test_radius = 22:24;
%Back-projection parameters
backproj_thr = 0.022;
sat_thr = 0.3;

% Create color model
color_model = load(model.mat);

% Perform test
rocaccumulation = TrafficSignFiltering(valid_dir, color_model, backproj_thr, ...
                                       sat_thr);
rocaccumulation(1)
rocaccumulation(2)
F1 = 2*((rocaccumulation(1) * rocaccumulation(2))/(rocaccumulation(1) + rocaccumulation(2)));

