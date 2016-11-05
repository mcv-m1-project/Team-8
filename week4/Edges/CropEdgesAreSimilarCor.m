function isSimilar = CropEdgesAreSimilarCor (crop,edgeTemplate,corThresh)

%Edge Extraction
%edgeTemplate = edge(edgeTemplate,'Canny');
cropEdges = edge(crop, 'Canny');
%Compute Distance Transform    
distInCrop = bwdist(cropEdges);
distEdgeTemplate = bwdist(edgeTemplate);

sim = corr2(distInCrop,distEdgeTemplate);

isSimilar = (sim > corThresh);