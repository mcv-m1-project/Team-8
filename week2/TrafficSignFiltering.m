function rocaccumulation = TrafficSignFiltering(directory, color_model, ...
                                                color_thr, saturation_thr)
    % TrafficSignFiltering
    % Perform detection of Traffic signs on images applying morphology.
    %
    %    Parameter name      Value
    %    --------------      -----
    %    'directory'         directory where the test images to analize  (.jpg) reside
    %    'color_model'       Mat file containing the chroma mask to use in
    %                        color segmentation. It must contain a matrix
    %                        with name 'chroma_mask' with the result of
    %                        the CreateColorMask() function.

    % Flatten the model by getting the maximum probability of each layer
    color_model = max(color_model, [], 3);
    
    % Iterations represents de variable size of the structuring element to perform
    % the ROC curve 
    tic
    files = ListFiles(directory);  
    
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

        tridiskmin = strel('disk',7);

        pixelCandidates_1 = imfill(pixelCandidates_1,'holes');

        pixelCandidates_tri = imopen(pixelCandidates_1,tridiskmin);

        pixelCandidates = imdilate(pixelCandidates_tri,strel('disk',4));

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

    end

    % Plot performance evaluation
    [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity] = PerformanceEvaluationPixel(pixelTP, pixelFP, pixelFN, pixelTN);
    
    [pixelPrecision, pixelAccuracy, pixelSpecificity, pixelSensitivity]
    rocaccumulation = [pixelPrecision, pixelSensitivity];
   

    %profile report
    %profile off
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
