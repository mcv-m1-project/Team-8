function [fig] = ShowPrecisionRecallCurve(labels, TP, FP, FN)
% Plot the Precision-Recall curve.
% labels must be a cell array of strings, one for each given point of
% the curve.

    precision = TP ./ (TP + FP);
    recall = TP ./ (TP + FN);

    fig = figure('Color', [1,1,1]);
    
    plot(recall, precision, '-s', 'MarkerSize', 5, ...
         'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red')
    xlim([0, 1]);
    ylim([0, 1]);
    
    for i=1:numel(TP)
        text(recall(i) + 0.001, precision(i) + 0.003, ...
             labels{i});
    end
    
    legend('threshold');
    title('Precision-Recall curve', 'FontWeight','bold', ...
          'FontName','DejaVu Sans', 'FontSize', 14);
    xlabel('Recall', 'FontName', 'DejaVu Sans', 'FontSize', 12);
    ylabel('Precision', 'FontName', 'DejaVu Sans', 'FontSize', 12);
    