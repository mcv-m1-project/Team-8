function [summary, classes] = SummarizeSignalFeatures (features, signs, group_by)
  % SummarizeSignalFeatures
  % 
  % Compute some statistics from the feature array returned by
  % ExtractSignalFeatures().
  % 
  % For each feature (height, width, form_factor, filling_ratio), the
  % function compute the mean, std, min and max values.
  %
  % In order to compute these values, the input data is grouped
  % according to the `group_by` parameter. Accepted values are:
  % 
  % - 'type':  group by signal type (A, B, C, D, E, F).
  % - 'shape': group by signal shape (triangle, inverted triangle,
  %            circle, rectangle).
  % - 'color': group by signal color (red-white-black [A, B & C types],
  %            blue-white-black [D & F types], and red-blue [E type];
  %
  %
  % Parameter name   Value
  % --------------   -----
  % 'features'       matrix with the sign features returned by ExtractSignalFeatures.
  % 'signs'          vector with the type of each sign (see ExtractSignalFeatures).
  % 'group_by'       grouping criterium ('type', 'shape' or 'color').
  %
  %
  % Output       Value
  % ------       -----
  % 'summary'    struct with field names: 'height', 'width',
  %              'form_factor', 'filling_ratio' and 'frequency'. Each
  %              field is a Nx4 matrix with the respective summary for
  %              the N groups. Columns are the mean, std, min and max
  %              values.
  % 'classes'    identifier for each class in the summary. The values
  %              are sorted, so that the first row in the summaries
  %              corresponds to the first class, and so on.
  
  switch (group_by)
    case 'type'
      filters = {'A', 'B', 'C', 'D', 'E', 'F'};
      classes = {'A', 'B', 'C', 'D', 'E', 'F'};
    case 'shape'
      filters = {'A', 'B', 'CDE', 'F'};
      classes = {'triangle', 'inverted_triangle', 'circle', 'rectangle'};
    case 'color'
      filters = {'ABC', 'DF', 'E'};
      classes = {'red_white_black', 'blue_white_black', 'red_blue'};
    otherwise
      error('invalid value: group_by');
  end

  summary.height = [];
  summary.width = [];
  summary.form_factor = [];
  summary.filling_ratio = [];
  summary.frequency = [];
  
  n_classes = size(classes, 2);
  
  for i = 1:n_classes
    mask = zeros(size(signs, 1), 1);
    types = filters{1, i};

    for j = 1:size(types, 2)
      mask = mask | signs == types(j);
    end

    data = features(mask, :);

    summary.height = [summary.height; ...
		      mean(data(:, 1)), std(data(:, 1)), ...
		      max(data(:, 1)), min(data(:, 1))];

    summary.width = [summary.width; ...
		     mean(data(:, 2)), std(data(:, 2)), ...
		     max(data(:, 2)), min(data(:, 2))];

    summary.form_factor = [summary.form_factor; ...
			   mean(data(:, 3)), std(data(:, 3)), ...
			   max(data(:, 3)), min(data(:, 3))];

    summary.filling_ratio = [summary.filling_ratio; ...
			     mean(data(:, 4)), std(data(:, 4)), ...
			     max(data(:, 4)), min(data(:, 4))];

    summary.frequency = [summary.frequency; sum(mask)];
  end
  
end
