function isSimilar = CropEdgesAreSimilar (crop,edgeTemplate,diffThresh)

%Edge Extraction
%edgeTemplate = edge(edgeTemplate,'Canny');
cropEdges = edge(crop, 'Canny');
%Compute Distance Transform    
distInCrop = bwdist(cropEdges);
%distEdgeTemplate = bwdist(edgeTemplate);
        
%Evaluate Distance transform
distOnLine = distInCrop .* edgeTemplate;
diffTotalWithLine = sum(sum(distOnLine));

isSimilar = (diffTotalWithLine < diffThresh);

