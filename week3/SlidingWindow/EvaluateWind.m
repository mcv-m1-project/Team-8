function [is_box, filling_ratio] = EvaluateWind(pixelCandidates,threshold)
    is_box = false;
    filling_ratio = sum(pixelCandidates(:)) / numel(pixelCandidates);
    if(filling_ratio > threshold)
        is_box = true;
    end

end
