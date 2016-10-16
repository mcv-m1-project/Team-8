
function colorSegment(directory, pixel_method) 
    
    model = generateModel(directory);
    files = ListFiles(directory);
    for i=1:size(files),
        im = imread(strcat(directory,'/',files(i).name));
        selectedPixels = CandidatePixel_Color(im, pixel_method,model);
        imwrite(selectedPixels,strcat('/Users/jordipuyolescalafell/Desktop/MCV/Week1/masks/mask_',files(i).name));
    end
end

    
function [selectedPixels] = CandidatePixel_Color(im, space,model)

    switch space
        case 'normrgb'
            selectedPixels = ((im(:,:,1)>150 & im(:,:,2)<50 & im(:,:,3)<50) | (im(:,:,1)<50 & im(:,:,2)<50 & im(:,:,3)>150));
        case 'normlab'
            cform = makecform('srgb2lab');
            im = applycform(im,cform);        
            disp('entra');
            %selectedPixels = (((im(:,:,1)>150) & (im(:,:,2)>150) & (im(:,:,3)<50)) | ((im(:,:,2)>100) & (im(:,:,1)<50) & (im(:,:,3)<50)) | ((im(:,:,3)>100) & (im(:,:,1)<50) & (im(:,:,2)<50)));
            i = 1;
            while(i<numel(model))
                selectedPixels = ((im(:,:,2)<=model(i)+10) & (im(:,:,2)>model(i)-10)) & ((im(:,:,3)<=model(i+1)+10) & (im(:,:,3)>model(i+1)-10));
                i = i+2;
            end

        otherwise
            error('Incorrect color space defined');
            return
    end  
end

    