function [windowPrecision, windowAccuracy] = TrafficSignWindow_test(directory, model, backproj_thr, saturation_thr,ol_step,fr_threshold,output_dir)
    % TrafficSignDetection
    % Perform detection of Traffic signs on images. Detection is performed first at the pixel level
    % using a color segmentation. Then, using the color segmentation as a basis, the most likely window 
    % candidates to contain a traffic sign are selected using basic features (form factor, filling factor). 
    % Finally, a decision is taken on these windows using geometric heuristics (Hough) or template matching.

    % Flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);
    

    windowTP=0; windowFN=0; windowFP=0;
    files = ListFiles(directory);
    
    tic
    
    if exist(output_dir, 'dir') == 0
        mkdir(output_dir);
    end
    disp(ol_step);
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
        pixel_file = sprintf('%s/%s.png', output_dir, files(i).name(1:end-4));
        imwrite(pixelCandidates, pixel_file);
        

        
        % Candidate Generation (window)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %windowCandidates = CandidateGenerationWindow_Example(im, pixelCandidates, window_method); %%'SegmentationCCL' or 'SlidingWindow'  (Needed after Week 3)
        boxCandidates=containers.Map;
        boxCandidates = CandidateBoxesByWindow(pixelCandidates,ol_step,fr_threshold);
        windowCandidates = [];
        for l=1:size(boxCandidates,1)
            windowCandidates = [windowCandidates;struct('x',boxCandidates(l,3),'y',boxCandidates(l,1),'w',(boxCandidates(l,4)-boxCandidates(l,3)),'h',(boxCandidates(l,2)-boxCandidates(l,1)))];
        end
        window_file = sprintf('%s/%s.mat', output_dir, files(i).name(1:end-4));
        save(window_file, 'windowCandidates');

    end


    

end
 

