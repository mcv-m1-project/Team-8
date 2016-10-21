addpath(genpath('.'))

if exist('color_model.mat', 'file')
    fprintf('color_model.mat found, loading...\n');
    load color_model.mat
else
    fprintf('color_model.mat not found, creating...\n');
    generate_colormodel;
end

TrafficSignDetection_test('/home/ihcv08/dataset/test', ...
    '/home/ihcv08/m1-results/week2/method2', color_model, 0.025);
