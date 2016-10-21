function [mask] = ColorSegmentation(im, model)
    % ColorSegmentation
    % Apply color segmentation taking as positive pixels those with
    % hue-saturation values in chroma_model.
    %
    %  function [im_mask] = ColorSegmentation(im, chroma_model)
    %
    %    Parameter name      Value
    %    --------------      -----
    %    im                  The image in RGB colorspace to be segmented.
    %                        This function converts the image to HVL
    %                        colorspace.
    %    chroma_model        The hue-saturation values to become a positive
    %                        detection. Values must be quantized to [1:19] 
    %                        for hue channel and [1:10] for saturation channel.
    %                        
    % The function returns a binary mask with the same size as im,
    % and with pixel value 1 for each positive detection in the image.
    %
    % After compute the mask corresponding to chroma_model, the mask
    % is thresholding for an aditional saturation threshold, in order to
    % reduce false positives corresponding to low saturated colors
    % (chroma_model tends to include these as candidates.)
    
    % Convert to HSL color space
    im = colorspace('RGB->HSL', double(im) / 255);

    % Split channels
    h = im(:,:,1);
    s = im(:,:,2);
    l = im(:,:,3);

    % Quantization and shift
    h = floor(h / 20) + 1;        % range 1:19
    s = floor(s * 9) + 1;         % range 1:10

    % Chroma segmentation
    h = reshape(h, [size(im,1) * size(im,2), 1]);
    s = reshape(s, [size(im,1) * size(im,2), 1]);
    
    n_rows = 19;
    idx = (s - 1) * n_rows + h;
    mask = zeros(size(im,1), size(im,2));
    
    for i=1:size(model, 3)
        model_i = model(:,:,i);
        mask_i = reshape(model_i(idx), size(mask));
        mask = mask | mask_i;
    end

%     % Extra saturation threshold
%     sat_mask = im(:,:, 2) > 0.3;
% 
%     % Final segmentation
%     im_mask = chr_mask & sat_mask;
end

