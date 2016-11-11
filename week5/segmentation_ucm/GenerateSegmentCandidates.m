function GenerateSegmentCandidates(input_dir, ...
                                   output_dir, ...
                                   ucm_thr, ...
                                   ucm_scale)
% GenerateSegmentCandidates
%
% Compute UCM segmentation for each image and save some
% info for each segment found. For this purpose a mat file
% is stored for each image processed. The mat file has
% the same name as the image but with the ".mat" extension.
% Each mat file contains a "stats" variable with the information.
%
% For compute UCM segmentation and info, this function uses
% UCMSegmentation().
%
%  function GenerateSegmentCandidates(...)
%
%    Parameter name      Value
%    --------------      -----
%    input_dir           The folder with the input images
%
%    output_dir          Directory where the mat files will be
%                        created.
%
%    ucm_thr             The contour threshold to use in UCM
%                        segmentation.
%    
%    ucm_scale           Scale factor to use before applying UCM
%                        segmentation.

    mkdir(output_dir);
    files = ListFiles(input_dir);
    
    for i=1:size(files,1),
        
        fprintf('%s\n', files(i).name);
        
        % Read file
        im = imread(strcat(input_dir,'/',files(i).name));
        
        % UCM segmentation
        stats = UCMSegmentation(im, ucm_thr, ucm_scale);
        
        % Save ucm result into mat file
        outfile = sprintf('%s/%s.mat', output_dir, ...
                          files(i).name(1:end-4));
	    
        save('stats', outfile);
    end
end