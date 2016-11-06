function TrafficSignWindowEdge_test(directory, model, backproj_thr, saturation_thr,ol_step,fr_threshold,overlap_margin, dist_eval_method, dist_thresh, output_dir)
    % TrafficSignWindow_test
    % Perform first the color segmentation and apply then morphological operators.
    % Finally generate masks and mat file containing bounding boxes of
    % the test directory


    % Flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);
    
    files = ListFiles(directory);
    
    if exist(output_dir, 'dir') == 0
        mkdir(output_dir);
    end
 
    for i=1:size(files,1),
        %fprintf('%04d: %s\n', i, files(i).name);

        % Read file
        im = imread(strcat(directory,'/',files(i).name));
        
        % Candidate Generation (pixel) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        im = colorspace('RGB->HSL', double(im) / 255);
        
        pixelCandidates = BackProjection(im, model) >= backproj_thr;
        pixelCandidates = pixelCandidates & (im(:,:,2) >= ...
                                             saturation_thr);
        
        pixelCandidates = imfill(pixelCandidates,'holes');
        pixelCandidates = imopen(pixelCandidates, strel('disk', 7));     
        %pixelCandidates = imdilate(pixelCandidates, strel('disk', 4));
        
        %Edge Model Templates
        dir_edges = '/home/ihcv08/Jordi/Team8/week4/edge_templates';

        
        % Candidate Generation (window)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %windowCandidates = CandidateGenerationWindow_Example(im, pixelCandidates, window_method); %%'SegmentationCCL' or 'SlidingWindow'  (Needed after Week 3)
        boxCandidates=containers.Map;
        boxCandidates = CandidateBoxesByWindowEdges(pixelCandidates,ol_step,fr_threshold,overlap_margin);
        windowCandidates = [];
        for l=1:size(boxCandidates,1)
            windowCandidates = [windowCandidates;struct('x',boxCandidates(l,3),'y',boxCandidates(l,1),'w',(boxCandidates(l,4)-boxCandidates(l,3)+1),'h',(boxCandidates(l,2)-boxCandidates(l,1)+1))];
        end
        if length(windowCandidates) ~= 0;
            edgeCandidates = EvaluateDistance(pixelCandidates,windowCandidates,dir_edges, dist_eval_method, dist_thresh);
        end
        edgeCandidates
        filteredMask = filterWindowMask(pixelCandidates, edgeCandidates);
        window_file = sprintf('%s/%s.mat', output_dir, files(i).name(1:end-4));
        save(window_file, 'windowCandidates');
        pixel_file = sprintf('%s/%s.png', output_dir, files(i).name(1:end-4));
        imwrite(filteredMask, pixel_file);

    end


    

end
 
