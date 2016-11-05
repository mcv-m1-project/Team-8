function edgeCandidates = EvaluateDistance(pixelCandidates,windowCandidates,dir_edges)
%Obtain correlation between template read from dir_edges and the input
%Window composed by image pixelCandidates and gorund turth windowCandidates
%returns an array of structs edgeCandidates which contain the selected
%windows
templates = ListFiles(dir_edges);
edgeCandidates = [];

for t=1:size(templates,1),
    for i=1:length(windowCandidates)
        
        %Window Image Cropping
        x1 = windowCandidates(i).x;
        x2 = windowCandidates(i).x + windowCandidates(i).w - 1;
        y1 = windowCandidates(i).y;
        y2 = windowCandidates(i).y + windowCandidates(i).h - 1;
        bboxCandidate = pixelCandidates(y1:y2,x1:x2);
       
        %Template modeling  
        edgeTemplate = imread(strcat(dir_edges,'/',templates(t).name));
        edgeTemplate = imresize(edgeTemplate, [windowCandidates(i).h,windowCandidates(i).w]);        
        
        %Edge Extraction
        edgeTemplate = edge(edgeTemplate,'Canny');
        bboxCandidate = edge(bboxCandidate, 'Canny');
        %Compute Distance Transform    
        distBboxCandidate = bwdist(bboxCandidate);
        distEdgeTemplate = bwdist(edgeTemplate);
        %Compute cross-correlation
        sim = corr2(distBboxCandidate,distEdgeTemplate);
        sim
        %Evaluate correlation
        if(sim >= -1 && sim <=1)
            edgeCandidates =[edgeCandidates; windowCandidates(i)];
        end
        %edgeCandidates = windowCandidates;
        
     
    end
end
   