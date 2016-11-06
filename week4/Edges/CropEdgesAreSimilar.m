function isSimilar = CropEdgesAreSimilar (crop,edgeTemplate,diffThresh)

%Edge Extraction
%edgeTemplate = edge(edgeTemplate,'Canny');
cropEdges = edge(crop, 'Canny');
%Compute Distance Transform    
distInCrop = bwdist(cropEdges);
%distEdgeTemplate = bwdist(edgeTemplate);
        
%Evaluate Distance transform
distOnLine = distInCrop .* edgeTemplate;

distOnLine(distOnLine==Inf)=(size(crop,1)*size(crop,2))+1;

diffTotalWithLine = sum(sum(distOnLine));

isSimilar = (diffTotalWithLine < diffThresh);

