function parsedRegions = UCMSegmentation(imag, ucm_th, scale)
% Get region properties from image
% Usage: parsedRegions = UCMSegmentation(imag, ucm_th, scale)
%
% INPUT:
%    imag     : image to segment
%    ucm_th : threshold to apply to the UCM
%    scale  : factor to resize the image to be processed
% OUPUT
%    parsedRegions : regions with their properties (bounding box, original 
%    crop and mask crop)
   
   %Downscale the image

   smallImg = imresize(imag,scale);
   
   segmentedImg = segment_ucm(smallImg, ucm_th);
   
   num_regions = max(max(segmentedImg));
   
   parsedRegions = [];
   
   for i=1:num_regions
       
      %Get each region and compute properties
      
      BW=(segmentedImg==i);
      
      stats = regionprops(BW,'BoundingBox');
      
      bBox = stats.BoundingBox;
      
      left = ceil(bBox(1));                     %ceil so it takes entire pixels from the first
      right = floor(bBox(3)+bBox(1));           %floor so it takes entire pixels until the last
      top = ceil(bBox(2));
      bott = floor(bBox(4)+bBox(2));
 
      smallMaskCrop = BW(top:bott,left:right);
     
      resizedL = floor(left/scale);             %floor so it includes first pixel
      resizedR = ceil(right/scale);             %ceil so it includes first pixel
      resizedT = floor(top/scale);
      resizedB = ceil(bott/scale);
      
      curRegion.bBox.Left = resizedL;
      curRegion.bBox.Right = resizedR;
      curRegion.bBox.Top = resizedT;
      curRegion.bBox.Bott = resizedB;
      
      curRegion.bBox.Width = curRegion.bBox.Right - curRegion.bBox.Left +1;
      curRegion.bBox.Height = curRegion.bBox.Bott - curRegion.bBox.Top +1;
      
      finalMaskCrop = imresize(smallMaskCrop,(1/scale));    %No need to binarize
      
      curRegion.maskcrop = finalMaskCrop;
      
      curRegion.imgcrop = imag(resizedT:resizedB,resizedL:resizedR,:);
      
      parsedRegions = [parsedRegions;curRegion];
      
   end
   
end