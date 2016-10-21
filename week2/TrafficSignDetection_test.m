function TrafficSignDetection_test(input_dir, output_dir, model, threshold)
    % TrafficSignDetection
    % Perform detection of Traffic signs on images. Detection is performed first at the pixel level
    % using a color segmentation. Then, using the color segmentation as a basis, the most likely window 
    % candidates to contain a traffic sign are selected using basic features (form factor, filling factor). 
    % Finally, a decision is taken on these windows using geometric heuristics (Hough) or template matching.
    %
    %    Parameter name      Value
    %    --------------      -----
    %    'input_dir'         Directory where the test images to analize  (.jpg) reside
    %    'output_dir'        Directory where the results are stored
    %    'model_file'        Mat file containing the chroma mask to use in
    %                        color segmentation. It must contain a matrix
    %                        with name 'chroma_mask' with the result of
    %                        the CreateColorMask() function.

    % Flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);
    
    mkdir(output_dir);
    files = ListFiles(input_dir);
    
    for ii=1:size(files,1),

        fprintf('%s\n', files(ii).name);
        
        % Read file
        im = imread(strcat(input_dir,'/',files(ii).name));
        
        % Candidate Generation (pixel) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        im = colorspace('RGB->HSL', double(im) / 255);
        
        pixelCandidates = BackProjection(im, model) >= threshold;
        pixelCandidates = pixelCandidates & (im(:,:,2) > 0.3);
        
        pixelCandidates = imfill(pixelCandidates,'holes');
        pixelCandidates = imopen(pixelCandidates, strel('disk', 24));
        pixelCandidates = imdilate(pixelCandidates, strel('disk',4));
        
        out_file1 = sprintf ('%s/pixelCandidates_%06d.png',  output_dir, ii);
	    
	    imwrite (pixelCandidates, out_file1);
    end
end
