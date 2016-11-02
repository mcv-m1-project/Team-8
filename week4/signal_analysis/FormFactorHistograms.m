function [bincounts] = FormFactorHistograms(formfactors, signs, binranges)
% formfactors: Nx1, signs: Nx1
    
    filters = {'A', 'B', 'CDE', 'F'};
    classes = {'triangle', 'inverted_triangle', 'circle', 'rectangle'};

    bincounts = [];
    
    for i = 1:size(classes, 2)
        mask = zeros(size(signs, 1), 1);
        types = filters{1, i};

        for j = 1:size(types, 2)
            mask = mask | signs == types(j);
        end

        data = formfactors(mask);
        bincounts = [bincounts; histc(data, binranges)'];
    end
end