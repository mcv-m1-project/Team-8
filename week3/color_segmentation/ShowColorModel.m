function [fig] = ShowColorModel(model)
% ShowColorModel
% Show and return a figure with the normalized histogram for
% each signal group in the color model.
%
% NOTE: Use ExtractHistograms() and then ComputeColorModel() to obtain a
% color model. The color model is the first parameter returned by
% ComputeColorModel().

    hue_bins = size(model, 1);
    sat_bins = size(model, 2);
    h = 360 / hue_bins;  % height per bin
    w = 1 / sat_bins;    % width per bin


    fig = figure('Color', [1,1,1]);


    ax1 = subplot(3,1,1);
    imagesc(model(:,:,1))
    colormap(ax1, summer)
    colorbar
    title('Red-White-Black Signals', 'FontWeight','bold', ...
          'FontName','DejaVu Sans', 'FontSize', 14);
    xlabel('Saturation', 'FontName', 'DejaVu Sans', 'FontSize', 12);
    ylabel('Hue',  'FontName', 'DejaVu Sans', 'FontSize', 12);
    set(gca, 'YTick', (0:hue_bins) + 0.5);
    set(gca, 'XTick', (0:sat_bins) + 0.5);
    set(gca, 'XTickLabel', (0:sat_bins) * w);
    set(gca, 'YTickLabel', (0:hue_bins) * h);
    set(gca,'TickDir','out');
    set(gca,'box','off')


    ax2 = subplot(3,1,2);
    imagesc(model(:,:,2))
    colormap(ax2, summer)
    colorbar
    title('Blue-White-Black Signals', 'FontWeight','bold', ...
          'FontName','DejaVu Sans', 'FontSize', 14);
    xlabel('Saturation', 'FontName', 'DejaVu Sans', 'FontSize', 12);
    ylabel('Hue',  'FontName', 'DejaVu Sans', 'FontSize', 12);
    set(gca, 'YTick', (0:hue_bins) + 0.5);
    set(gca, 'XTick', (0:sat_bins) + 0.5);
    set(gca, 'XTickLabel', (0:sat_bins) * w);
    set(gca, 'YTickLabel', (0:hue_bins) * h);
    set(gca,'TickDir','out');
    set(gca,'box','off')


    ax3 = subplot(3,1,3);
    imagesc(model(:,:,3))
    colormap(ax3, summer)
    colorbar
    title('Red-Blue Signals', 'FontWeight','bold', ...
          'FontName','DejaVu Sans', 'FontSize', 14);
    xlabel('Saturation', 'FontName', 'DejaVu Sans', 'FontSize', 12);
    ylabel('Hue',  'FontName', 'DejaVu Sans', 'FontSize', 12);
    set(gca, 'YTick', (0:hue_bins) + 0.5);
    set(gca, 'XTick', (0:sat_bins) + 0.5);
    set(gca, 'XTickLabel', (0:sat_bins) * w);
    set(gca, 'YTickLabel', (0:hue_bins) * h);
    set(gca,'TickDir','out');
    set(gca,'box','off')
