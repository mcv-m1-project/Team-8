function [fig] = ShowROC(thresholds, TP, FP, FN, TN)

    recall = TP ./ (TP + FN);
    fallout = FP ./ (FP + TN);

    fig = figure('Color', [1,1,1]);
    
    plot(fallout, recall, '-s', 'MarkerSize', 5, ...
         'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red')
    
    for i=1:numel(TP)
        text(fallout(i) - 0.02, recall(i) + 0.01, ...
             num2str(thresholds(i)));
    end
    
    legend('threshold');
    title('ROC curve', 'FontWeight','bold', ...
          'FontName','DejaVu Sans', 'FontSize', 14);
    xlabel('Fallout', 'FontName', 'DejaVu Sans', 'FontSize', 12);
    ylabel('Recall', 'FontName', 'DejaVu Sans', 'FontSize', 12);
    