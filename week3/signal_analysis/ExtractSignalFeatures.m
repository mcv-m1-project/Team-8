function [features signs] = ExtractSignalFeatures(dir)
  % ExtractSignalFeatures
  % Extract the features of each signal found in the dataset and
  % store them in arrays.
  %
  % Parameters:
  % - dir: directory with the dataset (jpeg files + gt/ + mask/)
  %
  % Output:
  % - features: Nx4 matrix with the features of each sign.
  %             Columns: height, width, form factor and filling ratio.
  % - signs:    character vector with the type of each sign.
  %
<<<<<<< HEAD
=======
  addpath(genpath('.'));
>>>>>>> block3-task2-intra
  
  features = [];
  signs = '';

  files = ListFiles(dir);

  for i = 1:size(files, 1)
    name = files(i).name(1:9);
    txt = strcat(dir, '/gt/gt.', name, '.txt');
    png = strcat(dir, '/mask/mask.', name, '.png');

    gt = imread(png);
    [window, type] = LoadAnnotations(txt);

    for j = 1:size(window, 1)
      x1 = round(window(j).x);
      y1 = round(window(j).y);
      x2 = round(window(j).x + window(j).w);
      y2 = round(window(j).y + window(j).h);
      mask = gt(y1:y2, x1:x2);

      filling_ratio = sum(mask(:) >= 1) / numel(mask);
      form_factor = window(j).w / window(j).h;

      features = [features; window(j).h, window(j).w, form_factor, filling_ratio];
      signs = [signs; type{j}];
    end
  end
end
