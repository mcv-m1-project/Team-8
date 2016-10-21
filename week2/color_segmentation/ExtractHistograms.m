function [histo_chr, histo_lum, class] = ExtractHistograms(dir)
    % ExtractHistograms
    % Compute the histogram in the HSL colorspace for each signal found 
    % in the directory.
    % 
    %   function [histo_chr, histo_lum, class] = ExtractHistograms(dir)
    %
    %    Parameter name      Value
    %    --------------      -----
    %    dir                 Directory with the jpg files and with
    %                        subdirs gt/ and mask/.
    % 
    % The function returns for each signal two histograms and a column
    % vector with its label ('A', 'B', ..., 'F').
    %
    % The 'histo_chr' matrix has dimension 19x10xN, where N is the total
    % number of signals. Rows and columns represent Hue and Saturation
    % values, after quantizing and shifting to the range [1:19] and
    % [1:10], respectively. Therefore, each histo_chr(:,:,i) is the 
    % Hue-Saturation histogram for each image.
    %
    % The 'histo_lum' matrix has dimension Nx10, where N is the total
    % number of signals. Columns represent Lightness values, after
    % quatizing and shifting to the range [1:10].
    
    histo_chr = [];
    histo_lum = [];
    class = '';
  
    files = ListFiles(dir);
    
    for i = 1:size(files, 1)
        disp(files(i).name);
        name = files(i).name(1:9);
        txt = strcat(dir, '/gt/gt.', name, '.txt');
        png = strcat(dir, '/mask/mask.', name, '.png');
        jpg = strcat(dir, '/', files(i).name);

        im = imread(jpg);
        gt = imread(png);
        [window, type] = LoadAnnotations(txt);
        
        for j = 1:size(window, 1)
            
            % Extract crop with the signal
            x1 = round(window(j).x);
            y1 = round(window(j).y);
            x2 = round(window(j).x + window(j).w);
            y2 = round(window(j).y + window(j).h);
            
            mask = gt(y1:y2, x1:x2);
            crop = im(y1:y2, x1:x2, :);
            
            % There are some empty mask!! All pixels == 0. Maybe bug?
            if sum(mask(:)) == 0
                disp(['mask in ', png, ' is empty!']);
                break;
            end
            
            % Convert color space to HSL
            crop = colorspace('RGB->HSL', double(crop) / 255);
            
            % Extract channels and filter out background pixels
            h = crop(:,:,1);
            h = h(find(mask));
            s = crop(:,:,2);
            s = s(find(mask));
            l = crop(:,:,3);
            l = l(find(mask));
            
            % Quantization and shift
            h = floor(h / 20) + 1;        % range 1:19
            s = floor(s * 9) + 1;         % range 1:10
            l = floor(l * 9) + 1;         % range 1:10
            
            chr = accumarray([h, s], 1, [19, 10]);
            lum = accumarray(l, 1, [10, 1]);
            
            histo_chr = cat(3, histo_chr, chr);
            histo_lum = [histo_lum; lum.'];
            class = [class; type{j}];
        end
    end
end