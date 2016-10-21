addpath(genpath('.'))

if exist('color_model.mat', 'file')
    fprintf('color_model.mat found, loading...\n');
    load color_model.mat
else
    fprintf('color_model.mat not found, creating...\n');
    generate_colormodel;
end

TrafficSignDetection('/home/ihcv08/dataset/trial3/validation', color_model, 0.025);


