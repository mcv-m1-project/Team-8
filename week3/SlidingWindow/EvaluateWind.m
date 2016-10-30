function [is_box, filling_ratio] = EvaluateWind(pixelCandidates, filling_ratio_max)
    is_box = false;
    filling_ratio = sum(pixelCandidates(:)) / numel(pixelCandidates);
    threshold = 0.1138;
    if(filling_ratio > threshold)
        %if(filling_ratio > filling_ratio_max)
            %if(filling_ratio > filling_ratio_max)
                %disp(filling_ratio);
                is_box = true;
                %keep bounding box - sliding window coordinates 
            %end
        %else
        %    filling_ratio_prev = threshold;
    end
   % end

    %form_factor = window(j).w / window(j).h;

    %disp(bounding_boxes);
end
