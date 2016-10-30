function rocaccumulation = TrafficSignFiltering(directory, color_model, ...
                                                color_thr, saturation_thr, test_rad_values)
    % TrafficSignDetection
    % Perform detection of Traffic signs on images. Detection is performed first at the pixel level
    % using a color segmentation. Then, using the color segmentation as a basis, the most likely window 
    % candidates to contain a traffic sign are selected using basic features (form factor, filling factor). 
    % Finally, a decision is taken on these windows using geometric heuristics (Hough) or template matching.
    %
    %    Parameter name      Value
    %    --------------      -----
    %    'directory'         directory where the test images to analize  (.jpg) reside
    %    'model_file'        Mat file containing the chroma mask to use in
    %                        color segmentation. It must contain a matrix
    %                        with name 'chroma_mask' with the result of
    %                        the CreateColorMask() function.

<<<<<<< HEAD
    % Flatten the model by getting the maximum probability of each layer
    color_model = max(color_model, [], 3);
    
    % Iterations represents de variable size of the structuring element to perform
    % the ROC curve 
    iterations = 30;
    files = ListFiles(directory);
    rocaccumulation = zeros(iterations,2);
    
    whos test_rad_values;
    pause;
    
    
    for k=1:size(test_rad_values, 2),
    
        pixelTP=0; pixelFN=0; pixelFP=0; pixelTN=0;
        for i=1:size(files,1),  
            fprintf('%s\n', files(i).name);

            % Read file
            im = imread(strcat(directory,'/',files(i).name));
            
            % Color segmentation
            im = colorspace('RGB->HSL', double(im) / 255);
            
            pixelCandidates = BackProjection(im, color_model) >= color_thr;
            pixelCandidates = pixelCandidates & (im(:,:,2) >= ...
                                                 saturation_thr);
            pixelCandidates_1 = pixelCandidates;
            
            
            % Morphological operations

            tridiskmin = strel('disk', test_rad_values(k));
            
            pixelCandidates_1 = imfill(pixelCandidates_1,'holes');

            pixelCandidates_tri = imopen(pixelCandidates_1,tridiskmin);
            
            pixelCandidates = imdilate(pixelCandidates_tri,strel('disk',4));
            
            %pixelCandidates = pixelCandidates_tri;
            %pixelCandidates = imopen(pixelCandidates_1,sedisk);
            % Candidate Generation (window)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % windowCandidates = CandidateGenerationWindow_Example(im, pixelCandidates, window_method); %%'SegmentationCCL' or 'SlidingWindow'  (Needed after Week 3)        
            % Accumulate pixel performance of the current image %%%%%%%%%%%%%%%%%
            pixelAnnotation = imread(strcat(directory, '/mask/mask.', ...
                                            files(i).name(1:end-3), ...
                                            'png')) > 0;
            [localPixelTP, localPixelFP, localPixelFN, localPixelTN] = ...
                PerformanceAccumulationPixel(pixelCandidates, pixelAnnotation);
            pixelTP = pixelTP + localPixelTP;
            pixelFP = pixelFP + localPixelFP;
            pixelFN = pixelFN + localPixelFN;
            pixelTN = pixelTN + localPixelTN;
            
            % Accumulate object performance of the current image %%%%%%%%%%%%%%%%  (Needed after Week 3)
            % windowAnnotations = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt'));
            % [localWindowTP, localWindowFN, localWindowFP] = PerformanceAccumulationWindow(windowCandidates, windowAnnotations);
            % windowTP = windowTP + localWindowTP;
            % windowFN = windowFN + localWindowFN;
            % windowFP = windowFP + localWindowFP;
        end

        % Plot performance evaluation
        [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity] = PerformanceEvaluationPixel(pixelTP, pixelFP, pixelFN, pixelTN);
        % [windowPrecision, windowAccuracy] = PerformanceEvaluationWindow(windowTP, windowFN, windowFP); % (Needed after Week 3)
        
        [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity]
        rocaccumulation(k,1) = pixelPrecision;
        rocaccumulation(k,2) = pixelSensitivity;
        
        % [windowPrecision, windowSensitivity]
    end


    rocaccumulation
=======
    global CANONICAL_W;        CANONICAL_W = 64;
    global CANONICAL_H;        CANONICAL_H = 64;
    global SW_STRIDEX;         SW_STRIDEX = 8;
    global SW_STRIDEY;         SW_STRIDEY = 8;
    global SW_CANONICALW;      SW_CANONICALW = 32;
    global SW_ASPECTRATIO;     SW_ASPECTRATIO = 1;
    global SW_MINS;            SW_MINS = 1;
    global SW_MAXS;            SW_MAXS = 2.5;
    global SW_STRIDES;         SW_STRIDES = 1.2;

    % Extract chroma model from given mask
    %load(model_file, 'chroma_mask');
    %[chroma_model_a, chroma_model_b] = find(chroma_mask);
    %chroma_model = [chroma_model_a.'; chroma_model_b.'].';

    % Load models
    %global circleTemplate;
    %global givewayTemplate;   
    %global stopTemplate;      
    %global rectangleTemplate; 
    %global triangleTemplate;  
    %
    %if strcmp(decision_method, 'TemplateMatching')
    %   circleTemplate    = load('TemplateCircles.mat');
    %   givewayTemplate   = load('TemplateGiveways.mat');
    %   stopTemplate      = load('TemplateStops.mat');
    %   rectangleTemplate = load('TemplateRectangles.mat');
    %   triangleTemplate  = load('TemplateTriangles.mat');
    %end

    windowTP=0; windowFN=0; windowFP=0; % (Needed after Week 3)
    
    %Iterations represents de variable size of the structuring element to perfrom
    %the ROC curve 
    %iterations = 20;
    files = ListFiles(directory);
    rocaccumulation = zeros(2);
    mask_files = ListFiles(mask_directory);
    
%for k=1:iterations,
    pixelTP=0; pixelFN=0; pixelFP=0; pixelTN=0;
    %for i=1:size(files,1),
     for i=1:10,   
        %fprintf('%s\n', files(i).name);
       
        % Read file
        im = imread(strcat(mask_directory,'/',mask_files(i).name));
        pixelCandidates = imread(strcat(directory,'/',files(i).name));
     
        % Candidate Generation (pixel) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %pixelCandidates_1 = imclose(pixelCandidates_1,strel('disk',1));
        

        
        pixelCandidates = imfill(pixelCandidates,'holes');
        pixelCandidates = imopen(pixelCandidates,strel('disk',7));
  
        pixelCandidates = imdilate(pixelCandidates,strel('disk',4));
        imshow(pixelCandidates);
        %x1 = round(window(j).x);
        %y1 = round(window(j).y);
        %x2 = round(window(j).x + window(j).w);
        %y2 = round(window(j).y + window(j).h);
        %mask = pixelCandidates(y1:y2, x1:x2);
        disp(size(pixelCandidates));
        pixelCandidates = pixelCandidates(113:192,1397:1488);
        
        %filling_ratio = sum(mask(:)) / numel(mask);
        filling_ratio = sum(pixelCandidates(:)) / numel(pixelCandidates);
        %form_factor = window(j).w / window(j).h;
        
        disp(filling_ratio);
        
        %if(filling_ratio > 0.1138)
            
        
        figure;
        imshow(pixelCandidates);
        window_method = 'SlidingWindow';
        % Candidate Generation (window)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         windowCandidates = CandidateGenerationWindow_Example(im, pixelCandidates, window_method); %%'SegmentationCCL' or 'SlidingWindow'  (Needed after Week 3)        
        % Accumulate pixel performance of the current image %%%%%%%%%%%%%%%%%
        %pixelAnnotation = imread(strcat(mask_directory, '/mask/mask.', mask_files(i).name(1:size(mask_files(i).name,2)-3), 'png'))>0;
        %[localPixelTP, localPixelFP, localPixelFN, localPixelTN] = PerformanceAccumulationPixel(pixelCandidates, pixelAnnotation);
        %pixelTP = pixelTP + localPixelTP;
        %pixelFP = pixelFP + localPixelFP;
        %pixelFN = pixelFN + localPixelFN;
        %pixelTN = pixelTN + localPixelTN;
        
        % Accumulate object performance of the current image %%%%%%%%%%%%%%%%  (Needed after Week 3)
         windowAnnotations = LoadAnnotations(strcat(mask_directory, '/gt/gt.', mask_files(i).name(1:size(mask_files(i).name,2)-3), 'txt'));
         [localWindowTP, localWindowFN, localWindowFP] = PerformanceAccumulationWindow(windowCandidates, windowAnnotations);
         windowTP = windowTP + localWindowTP;
         windowFN = windowFN + localWindowFN;
         windowFP = windowFP + localWindowFP;
    end

    % Plot performance evaluation
    %[pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity] = PerformanceEvaluationPixel(pixelTP, pixelFP, pixelFN, pixelTN);
    [windowPrecision, windowAccuracy] = PerformanceEvaluationWindow(windowTP, windowFN, windowFP); % (Needed after Week 3)
    
    [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity]
    rocaccumulation(1) = pixelPrecision;
    rocaccumulation(2) = pixelSensitivity;
    
    % [windowPrecision, windowSensitivity
>>>>>>> block3-task2-intra
    %profile report
    %profile off
    %toc
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CandidateGeneration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [pixelCandidates] = CandidateGenerationPixel_Color(im, space)

    im=double(im);

    switch space
        case 'normrgb'
            pixelCandidates = im(:,:,1)>100;
            
        otherwise
            error('Incorrect color space defined');
            return
    end
end    
    

function [windowCandidates] = CandidateGenerationWindow_Example(im, pixelCandidates, window_method)
    windowCandidates = [ struct('x',double(12),'y',double(17),'w',double(32),'h',double(32)) ];
end  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performance Evaluation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PerformanceEvaluationROC(scores, labels, thresholdRange)
    % PerformanceEvaluationROC
    %  ROC Curve with precision and accuracy
    
    roc = [];
	for t=thresholdRange,
        TP=0;
        FP=0;
        for i=1:size(scores,1),
            if scores(i) > t    % scored positive
                if labels(i)==1 % labeled positive
                    TP=TP+1;
                else            % labeled negative
                    FP=FP+1;
                end
            else                % scored negative
                if labels(i)==1 % labeled positive
                    FN = FN+1;
                else            % labeled negative
                    TN = TN+1;
                end
            end
        end
        
        precision = TP / (TP+FP+FN+TN);
        accuracy = TP / (TP+FN+FP);
        
        roc = [roc ; precision accuracy];
    end

    plot(roc);
end
