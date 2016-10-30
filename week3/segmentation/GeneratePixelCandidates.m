function GeneratePixelCandidates(input_dir, output_dir, model, ...
                                 backproj_thr, saturation_thr)

    % Flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);
    
    mkdir(output_dir);
    files = ListFiles(input_dir);
    
    for ii=1:size(files,1),

        fprintf('%s\n', files(ii).name);
        
        % Read file
        im = imread(strcat(input_dir,'/',files(ii).name));

        % Convert to HSL color space
        im = colorspace('RGB->HSL', double(im) / 255);
        
        % BackProjection and saturation threshold
        pixelCandidates = BackProjection(im, model) >= backproj_thr;
        pixelCandidates = pixelCandidates & (im(:,:,2) >= saturation_thr);
        
        % Morphology
        pixelCandidates = imfill(pixelCandidates,'holes');
        pixelCandidates = imopen(pixelCandidates, strel('disk', 7));
        pixelCandidates = imdilate(pixelCandidates, strel('disk',4));
        
        % Save result
        out_file1 = sprintf ('%s/pixelCandidates_%06d.png',  output_dir, ii);
	    
        imwrite (pixelCandidates, out_file1);
    end
end
