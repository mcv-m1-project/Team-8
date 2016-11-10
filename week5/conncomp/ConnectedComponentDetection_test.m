function ConnectedComponentDetection_test(input_dir, ...
                                          output_dir, ...
                                          model, ...
                                          form_factor_min, ...
                                          form_factor_max, ...
                                          filling_ratio_min, ...
                                          filling_ratio_max)
    % ConnectedComponentDetection_test
    % Perform detection of Traffic signs on images. Detection is
    % performed first at the pixel level using a color
    % segmentation. Then, using the color segmentation as a basis, 
    % the most likely window candidates to contain a traffic sign
    % are selected using basic features (form factor, filling
    % factor).
    %
    %    Parameter name      Value
    %    --------------      -----
    %    'input_dir'         Directory where the test images to analize (.jpg) reside
    %    'output_dir'        Directory where the results will be stored
    %    'model'             Array with the chroma model to use in color segmentation.
    %    'filling_ratio_*'   Thresholds to use in detection at
    %    'form_factor_*'     object level
    %         

    if exist(output_dir, 'dir') == 0
        mkdir(output_dir);
    end
    
    % Flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);
    
    % Thresholds for the pixel detection stage
    backproj_thr = 0.022;
    saturation_thr = 0.3;
    
    files = ListFiles(input_dir);
    
    tic
    for i=1:size(files,1),

        fprintf('%s\n', files(i).name);
        
        % Read file
        im = imread(strcat(input_dir,'/',files(i).name));
        
        % Candidate generation (pixel)
        im = colorspace('RGB->HSL', double(im) / 255);
        
        pixelCandidates = BackProjection(im, model) >= backproj_thr;
        pixelCandidates = pixelCandidates & (im(:,:,2) >= saturation_thr);
        
        pixelCandidates = imfill(pixelCandidates,'holes');
        pixelCandidates = imopen(pixelCandidates, strel('disk', 7));
        pixelCandidates = imdilate(pixelCandidates, strel('disk',4));
        
        % Candidate generation (window)
        windowCandidates = ConnectedComponents(pixelCandidates);
        windowCandidates = FormFactorFilter(windowCandidates, ...
                                            form_factor_min, ...
                                            form_factor_max);
        windowCandidates = FillingRatioFilter(pixelCandidates, ...
                                              windowCandidates, ...
                                              filling_ratio_min, ...
                                              filling_ratio_max);

        % Filter pixel mask with detected windows
        pixelCandidates = filterWindowMask(pixelCandidates, windowCandidates);
        
        % Save results
        pixel_file = sprintf('%s/%s.png', output_dir, files(i).name(1:end-4));
        imwrite(pixelCandidates, pixel_file);
        
        window_file = sprintf('%s/%s.mat', output_dir, files(i).name(1:end-4));
        save(window_file, 'windowCandidates');
    end
    
    toc
    fprintf('\n');
    fprintf('time/frame (ms): %f\n', toc/size(files, 1));
end
