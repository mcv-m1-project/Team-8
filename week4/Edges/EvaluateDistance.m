function edgeCandidates = EvaluateDistance(pixelCandidates,windowCandidates,dir_edges, threshold)
%Obtain correlation between template read from dir_edges and the input
%Window composed by image pixelCandidates and gorund turth windowCandidates
%returns an array of structs edgeCandidates which contain the selected
%windows
templates = ListFiles(dir_edges);
edgeCandidates = [];


for i=1:length(windowCandidates)
    matchesAny = false;
    for t=1:size(templates,1)
    
        
        %Window Image Cropping
        x1 = windowCandidates(i).x;
        x2 = windowCandidates(i).x + windowCandidates(i).w - 1;
        y1 = windowCandidates(i).y;
        y2 = windowCandidates(i).y + windowCandidates(i).h - 1;
        bboxCandidate = pixelCandidates(y1:y2,x1:x2);
       
        %Template modeling  
        edgeTemplate = imread(strcat(dir_edges,'/',templates(t).name));
        bboxCandidate=imresize(bboxCandidate,size(edgeTemplate));        
        
        if CropEdgesAreSimilar(bboxCandidate, edgeTemplate, threshold)  %threshold hardcoded
            matchesAny = true;
        end    
    end
    if matchesAny
        edgeCandidates =[edgeCandidates; windowCandidates(i)];
    end
end
   