function [windowPrecision, windowSensitivity] = TrafficSignWindowEdge_valid(directory, model, backproj_thr, saturation_thr,ol_step,fr_threshold,overlap_margin,method,dist_thresh)
    % TrafficSignWindowEdge
    % Perform detection of Traffic signs on images. Detection is performed first at the pixel level
    % using a color segmentation. Then, using the color segmentation as a basis, the most likely window 
    % candidates to contain a traffic sign are selected using basic features (form factor, filling factor). 
    % Finally, a decision is taken on these windows using template matching.

    % Flatten the model by getting the maximum probability of each layer
    model = max(model, [], 3);
    windowTP=0; windowFN=0; windowFP=0;
    files = ListFiles(directory);
    
    %Edge Model Templates
    dir_edges = '/home/ihcv08/Jordi/Team8/week4/edge_templates';
    tic
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
        
        
        
        % Candidate Generation (window)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %windowCandidates = CandidateGenerationWindow_Example(im, pixelCandidates, window_method); %%'SegmentationCCL' or 'SlidingWindow'  (Needed after Week 3)
        boxCandidates=containers.Map;
        boxCandidates = CandidateBoxesByWindowEdges(pixelCandidates,ol_step,fr_threshold,overlap_margin);
      
        windowCandidates = [];
        for l=1:size(boxCandidates,1)
            windowCandidates = [windowCandidates;struct('x',boxCandidates(l,3),'y',boxCandidates(l,1),'w',(boxCandidates(l,4)-boxCandidates(l,3)),'h',(boxCandidates(l,2)-boxCandidates(l,1)))];
        end
        %Evaluate distance transform correlation between the candidate
        %windows and the edge templates
        if length(windowCandidates) ~= 0;
            edgeCandidates = EvaluateDistance(pixelCandidates,windowCandidates,dir_edges, method, dist_thersh);
        end
        %edgeCandidates
        
        % Accumulate object performance of the current image %
        windowAnnotations = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt'));
        [localWindowTP, localWindowFN, localWindowFP] = PerformanceAccumulationWindow(edgeCandidates, windowAnnotations);
        windowTP = windowTP + localWindowTP;
        windowFN = windowFN + localWindowFN;
        windowFP = windowFP + localWindowFP;
    end

    % Plot performance evaluation
    [windowPrecision, windowSensitivity] = PerformanceEvaluationWindow(windowTP, windowFN, windowFP); 
    [windowPrecision, windowSensitivity]
    

end
 

%function [windowCandidates] = CandidateGenerationWindow_Example(im, pixelCandidates, window_method)
%    windowCandidates = [ struct('x',double(12),'y',double(17),'w',double(32),'h',double(32)) ];
%end 




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