function [summary] = FitColorModelThreshold(valid_dir, thresholds)
%FITCOLORMODELTHRESHOLD Summary of this function goes here
%   Detailed explanation goes here

% require load path ../evaluation/
%
% summary: matrix Nx4 with columns [TP, FP, FN, TN]

    summary = zeros(size(thresholds, 2), 4);
    files = ListFiles(valid_dir);

    for i = 1:size(thresholds, 2)
        thr = thresholds(i);
        pixelTP = 0;
        pixelFP = 0;
        pixelFN = 0;
        pixelTN = 0;

        for j = 1:size(files, 1)
            name = files(j).name(1:9);
            backproj_i = sprintf('%s/backproj/%s.mat', valid_dir, name);
            load(backproj_i, 'result');  % -> load matrix 'result'

            candidates = result >= thr;
            real = imread(strcat(valid_dir, '/mask/mask.', name, '.png')) > 0;
            
            [localPixelTP, localPixelFP, localPixelFN, localPixelTN] = PerformanceAccumulationPixel(candidates, real);
            
            pixelTP = pixelTP + localPixelTP;
            pixelFP = pixelFP + localPixelFP;
            pixelFN = pixelFN + localPixelFN;
            pixelTN = pixelTN + localPixelTN;
            
            fprintf('(%d, %d) %s\n', i, j, files(j).name);
        end
        
        summary(i,:) = [pixelTP, pixelFP, pixelFN, pixelTN];
    end

end

