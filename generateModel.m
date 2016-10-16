function mean_ab_sel = generateModel(directory)
    
    files = ListFiles(strcat(directory,'2'));
    filename = files(1).name(1:9);
    ab_sel_a = [];
    ab_sel_b = [];
    ab_sel_c = [];
    ab_sel_d = [];
    ab_sel_e = [];
    ab_sel_f = [];
    mean_ab_a = [];
    mean_ab_b = [];
    mean_ab_c = [];
    mean_ab_d = [];
    mean_ab_e = [];
    mean_ab_f = [];
    
    for i=1:size(files),
        
        filename = files(i).name(1:9);
        %get the cropped region on interest of the image
        [lab_im,cat] = im2roi(directory,filename);
        %figure;
        %imshow(lab_im(:,:,2), []);
        
        %1d array conversion to accumulate
        a_array = reshape(lab_im(:,:,2), 1, numel(lab_im(:,:,2)));
        b_array = reshape(lab_im(:,:,3), 1, numel(lab_im(:,:,3)));
        %generation of accumulative array to plot the 2d chrominance histogram
        chroma = accumarray([a_array(:) b_array(:)],1);
        %plot chrominance histogram
        surf(chroma);
        
        %determine maximum chroma value is not 128(range 0-255)
        is_c = 0;
        while (is_c == 0)
            [num,idx] = max(chroma(:));
            [a,b] = ind2sub(size(chroma),idx);
            if(a~=128 && b~=128)
                is_c = 1;
            else
                chroma(idx) = 0;
            end
        end
        %accumulate category maximum values
        disp(cat);
        if strcmp(cat, 'A')
                ab_sel_a = [ab_sel_a, [a b]];
        elseif strcmp(cat, 'B')
                ab_sel_b = [ab_sel_b, [a b]];
        elseif strcmp(cat, 'C')
                ab_sel_c = [ab_sel_c, [a b]];
        elseif strcmp(cat, 'D')
                ab_sel_d = [ab_sel_d, [a b]]; 
        elseif strcmp(cat, 'E')
                ab_sel_e = [ab_sel_e, [a b]];
        elseif strcmp(cat, 'F')
                ab_sel_f = [ab_sel_f, [a b]]; 
        end
    end
    %disp(ab_sel_a);
    %disp(ab_sel_b);
    %disp(ab_sel_c);
    %disp(ab_sel_d);
    %disp(ab_sel_e);
    %disp(ab_sel_f);
    
    mean_ab_a = mean_ab(ab_sel_a);
    mean_ab_b = mean_ab(ab_sel_b);
    mean_ab_c = mean_ab(ab_sel_c);
    mean_ab_d = mean_ab(ab_sel_d);
    mean_ab_e = mean_ab(ab_sel_e);
    mean_ab_f = mean_ab(ab_sel_f);
    
    mean_ab_sel = [mean_ab_a mean_ab_b mean_ab_c mean_ab_d mean_ab_e mean_ab_f];
    disp(mean_ab_sel);
    %imwrite(lab_he,strcat('/Users/jordipuyolescalafell/Desktop/MCV/Week1/masks/gt_',files(i).name));
end

function meanAB = mean_ab(ab_sel)
    
    k = 1;
    meanAB=[];
    ac_a = 0;
    ac_b = 0;
    length_ab = length(ab_sel)/2;
    disp(length_ab);
    while(k<=length(ab_sel))    
        ac_a = ac_a+ab_sel(k);

        ac_b = ac_b+ab_sel(k+1);
        disp(ac_a);
        disp(ac_b);
        k = k+2;
    end
    meanA = ac_a/length_ab;
    meanB = ac_b/length_ab;
    meanAB = [meanA meanB];
end

function [lab_im,cat] = im2roi(directory,filename)

        png = imread(strcat(directory, '/mask/mask.', filename, '.png'));
        img = imread(strcat(directory, '/', filename, '.jpg'));
        
        mask_three_chan = repmat(png, [1, 1, 3]);
        img(~mask_three_chan) = 0;
        %for l =1:3
        %    img(:,:,l) = img(:,:,l).*png;
        %end
        
        fid = fopen(strcat(directory, '/gt/gt.', filename, '.txt'));
        C = textscan(fid,'%f %f %f %f %s','Delimiter',' ');
        fclose(fid);
        [tlx,tly,brx,bry,cat] = deal(C{:});
        mask = imcrop(img,[tly tlx (bry-tly) (brx-tlx)]);
        cform = makecform('srgb2lab');
        lab_im = applycform(mask,cform); 
end
