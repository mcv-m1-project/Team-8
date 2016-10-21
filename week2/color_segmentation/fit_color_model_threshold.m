thresholds = (10:5:100) / 1000; %(1:10) / 100;
summary = FitColorModelThreshold('/home/ihcv08/dataset/trial3/validation', thresholds);

pixelTP = summary(:,1);
pixelFP = summary(:,2);
pixelFN = summary(:,3);
pixelTN = summary(:,4);

precision = pixelTP ./ (pixelTP + pixelFP);
recall = pixelTP ./ (pixelTP + pixelFN);
fallout = pixelFP .* (pixelFP + pixelTN);
f1score = 2 * (precision .* recall) ./ (precision + recall);

% ROC curve
gscatter(fallout, recall,  1:size(thresholds, 2));
for i=1:size(thresholds, 2)
    text(fallout(i) + 0.4, recall(i), num2str(thresholds(i)));
end

% Precision-recall matrix
result = [thresholds.', precision, recall, f1score];
