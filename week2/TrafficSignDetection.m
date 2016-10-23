function TrafficSignDetection(directory, model, backproj_thr, saturation_thr)
    % TrafficSignDetection
    % Perform detection of Traffic signs on images. Detection is performed first at the pixel level
    % using a color segmentation. Then, using the color segmentation as a basis, the most likely window 
    % candidates to contain a traffic sign are selected using basic features (form factor, filling factor). 
    % Finally, a decision is taken on these windows using geometric heuristics (Hough) or template matching.

    % Flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);
    
    pixelTP=0; pixelFN=0; pixelFP=0; pixelTN=0;
    files = ListFiles(directory);
    
    tic
    
    for i=1:size(files,1),
        
        fprintf('%04d: %s\n', i, files(i).name);

        % Read file
        im = imread(strcat(directory,'/',files(i).name));
        
        % Candidate Generation (pixel) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        im = colorspace('RGB->HSL', double(im) / 255);
        
        pixelCandidates = BackProjection(im, model) >= backproj_thr;
        pixelCandidates = pixelCandidates & (im(:,:,2) >= ...
                                             saturation_thr);
        
        pixelCandidates = imfill(pixelCandidates,'holes');
        pixelCandidates = imopen(pixelCandidates, strel('disk', 24));     
        pixelCandidates = imdilate(pixelCandidates, strel('disk', 4));
        
        % Accumulate pixel performance of the current image %%%%%%%%%%%%%%%%%
        pixelAnnotation = imread(strcat(directory, '/mask/mask.', files(i).name(1:size(files(i).name,2)-3), 'png'))>0;
        [localPixelTP, localPixelFP, localPixelFN, localPixelTN] = PerformanceAccumulationPixel(pixelCandidates, pixelAnnotation);
        pixelTP = pixelTP + localPixelTP;
        pixelFP = pixelFP + localPixelFP;
        pixelFN = pixelFN + localPixelFN;
        pixelTN = pixelTN + localPixelTN;        
    end

    % Plot performance evaluation
    [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity] = PerformanceEvaluationPixel(pixelTP, pixelFP, pixelFN, pixelTN);
    
    
    [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity]
    
    toc
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

