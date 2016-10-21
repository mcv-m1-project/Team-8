function [] = BackprojectImages(input_dir, output_dir, model)
% model: 19x10x3 matrix, returned by ComputeColorModels()

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

