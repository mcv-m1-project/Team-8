function [summary] = FitColorModelThreshold(valid_dir, thresholds)
% FitColorModelThreshold
% Given a folder with backprojected images, this function apply
% several thresholds to them and compare the results with the ground
% thruth. The final result will be a confusion matrix for each threshold
% applied.
%
%   function [summary] = FitColorModelThreshold(valid_dir, thresholds)
%
%    Parameter name      Value
%    --------------      -----
%    valid_dir           Directory with the backprojected images.
%    thresholds          Vector with N thresholds to be tested.
%
% The N confusion matrix are stacked into 'summary', with columns
% [TP, FP, FN, TN].

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

            [localPixelTP, localPixelFP, localPixelFN, localPixelTN] ...
                = PerformanceAccumulationPixel(candidates, real);

            pixelTP = pixelTP + localPixelTP;
            pixelFP = pixelFP + localPixelFP;
            pixelFN = pixelFN + localPixelFN;
            pixelTN = pixelTN + localPixelTN;

            fprintf('(%d, %d) %s\n', i, j, files(j).name);
        end

        summary(i,:) = [pixelTP, pixelFP, pixelFN, pixelTN];
    end

end
