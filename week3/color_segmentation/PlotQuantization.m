function [fig] = PlotQuantization(hue_bins, sat_bins)

    h = 360 / hue_bins;  % height per bin
    w = 1 / sat_bins;    % width per bin

    % Store mean value for each bin
    palette = zeros(hue_bins, sat_bins, 3);

    for i=1:hue_bins
        for j=1:sat_bins
            palette(i,j,:) = colorspace('HSL->RGB', ...
                                        [(i-1)*h + h/2, (j-1)*w + w/2, 0.5]);
        end
    end


    fig = figure('Color', [1,1,1]);
    image(palette);

    title(sprintf('Quantization %dx%d', hue_bins, sat_bins), ...
          'FontName','DejaVu Sans', ...
          'FontWeight','bold', ...
          'FontSize', 14);

    xlabel('Saturation', 'FontName', 'DejaVu Sans', 'FontSize', 12);
    ylabel('Hue',  'FontName', 'DejaVu Sans', 'FontSize', 12);

    set(gca, 'YTick', (0:hue_bins) + 0.5);
    set(gca, 'XTick', (0:sat_bins) + 0.5);
    set(gca, 'XTickLabel', (0:sat_bins) * w);
    set(gca, 'YTickLabel', (0:hue_bins) * h);
    set(gca,'TickDir','out');
    set(gca,'box','off')

    annotation('textbox', [0.6357 0 0.2751 0.08262], ...
               'String',{'Colors in this figure correspond to the mean of each bin.',
                        'Axes mark the boundaries of each bin.'},...
               'HorizontalAlignment','right',...
               'FontSize', 11, ...
               'FontName', 'DejaVu Sans', ...
               'FontAngle', 'italic', ...
               'FitBoxToText','on', ...
               'LineStyle', 'none');
