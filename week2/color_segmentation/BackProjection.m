function [proj] = BackProjection(im, model)
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
    proj = reshape(model(idx), size(im, 1), size(im, 2));
end

