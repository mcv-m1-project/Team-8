addpath(genpath('.'));
[histo_chr, histo_lum, class] = ExtractHistograms('./dataset/puretrain');
[prob_chr, prob_lum, labels] = ComputeColorModels(histo_chr, histo_lum, class);
[chroma_mask] = CreateColorMask(prob_chr, 0.02);
save('model.mat');
