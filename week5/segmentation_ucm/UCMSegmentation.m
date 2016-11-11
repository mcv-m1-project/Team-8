function parsedRegions = UCMSegmentation(imag, ucm_th, scale)
% Segment an image by thresholding an UCM
% Usage: seg = segment_ucm(ima, thresh)
%
% INPUT:
%    ima     : image to segment
%    threesh : threshold to apply to the UCM
% OUPUT
%    seg : label image

   %M_Orig=size(imag,1);
   %N_Orig=size(imag,2);
   
   %M = round(M_Orig*scale);
   %N = round(N_Orig*scale);
   
   smallImg = imresize(imag,scale);
   
   segmentedImg = segment_ucm(smallImg, ucm_th);
   
   num_regions = max(max(segmentedImg));
   
   parsedRegions = [];
   
   for i=1:num_regions
      
      BW=(segmentedImg==i);
      
      bBox = regionprops(BW,'BoundingBox');
      
      left = ceil(bBox(1));
      right = floor(bBox(3)+bBox(1));
      top = ceil(bBox(2));
      bott = floor(bBox(4)+bBox(2));
 
      smallMaskCrop = BW(top:bott,left:right);
     
      resizedL = floor(left/scale);
      resizedR = ceil(right/scale);
      resizedT = floor(top/scale);
      resizedB = ceil(bott/scale);
      
      curRegion.bBox.Left = resizedL;
      curRegion.bBox.Right = resizedR;
      curRegion.bBox.Top = resizedT;
      curRegion.bBox.Bott = resizedB;
      
      curRegion.bBox.Width = curRegion.bBox.Right - curRegion.bBox.Left +1;
      curRegion.bBox.Height = curRegion.bBox.Bott - curRegion.bBox.Top +1;
      
      interpolMaskCrop = imresize(smallMaskCrop,(1/scale));
      
      finalMaskCrop = im2bw(interpolMaskCrop,0.5);
      
      curRegion.maskcrop = finalMaskCrop;
      
      curRegion.imgcrop = imag(resizedT:resizedB,resizedL:resizedR);
      
      parsedRegions = [parsedRegions;curRegion];
      
   end
   
end