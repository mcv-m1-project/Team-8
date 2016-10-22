function [] = BackprojectImages(input_dir, output_dir, model)
% BackprojectImages
% Take the images in input_dir and backproject them a color model.
% The resulting images are saved in output_dir as *.mat files.
%
% Each pixel in the resulting images is the corresponding
% probability according to the color model.
%
%   function [] = BackprojectImages(input_dir, output_dir, model)
%
%    Parameter name      Value
%    --------------      -----
%    input_dir           Directory with the images to be backprojected.
%    output_dir          Directory where store the backprojection
%                        results.
%    model               A NxMx3 array with the color model to apply.
%
% NOTE: Use ExtractHistograms() and then ComputeColorModel() to obtain a
% color model. The color model is the first parameter returned by
% ComputeColorModel().

    if exist(output_dir, 'dir') == 0
        mkdir(output_dir)
    end

    % flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);

    files = ListFiles(input_dir);

    for i = 1:size(files, 1)
        jpg = strcat(input_dir, '/', files(i).name);
        im = imread(jpg);

        result = BackProjection(im, model);

        outfile = sprintf('%s/%s.mat', output_dir, files(i).name(1:9));
        save(outfile, 'result');

        fprintf('(%04d) %s\n', i, files(i).name);
    end
end
