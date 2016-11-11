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
   
   segmentedImg = segment_ucm (smallImg, ucm_th);
   
   num_regions = max(max(segmentedImg));
   
   for i=1:num_regions
      
      BW=(segmentedImg==i);
      
      bBox = regionprops(BW,'BoundingBox');
      
      bBox(1)
      left = ceil(bBox(1));
      right = floor(bBox(3)+bBox(1));
      top = ceil(bBox(2));
      bott = floor(bBox(4)+bBox(2));
 
      smallMaskCrop = BW(top:bott,left:right);
     
      resizedL = floor(left/scale);
      resizedR = ceil(right/scale);
      resizedT = floor(top/scale);
      resizedB = ceil(bott/scale);
      
      parsedRegions(i).bBox.Left = resizedL;
      parsedRegions(i).bBox.Right = resizedR;
      parsedRegions(i).bBox.Top = resizedT;
      parsedRegions(i).bBox.Bott = resizedB;
      
      parsedRegions(i).bBox.Width = parsedRegions(i).bBox.Right - parsedRegions(i).bBox.Left +1;
      parsedRegions(i).bBox.Height = parsedRegions(i).bBox.Bott - parsedRegions(i).bBox.Top +1;
      
      interpolMaskCrop = imresize(smallMaskCrop,(1/scale));
      
      finalMaskCrop = im2bw(interpolMaskCrop,0.5);
      
      parsedRegions(i).maskcrop = finalMaskCrop;
      
      parsedRegions(i).imgcrop = imag(resizedT:resizedB,resizedL:resizedR);
      
      
   end
   
end