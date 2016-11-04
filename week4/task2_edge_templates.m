addpath(genpath('.'))
template_dir = '/home/ihcv08/Jordi/Team8/week4/templates';
edgetemplate_dir = '/home/ihcv08/Jordi/Team8/week4/edge_templates';

files = ListFiles(template_dir);
    
if exist(edgetemplate_dir, 'dir') == 0
    mkdir(edgetemplate_dir);
end

for i=1:size(files,1),
    im = imread(strcat(template_dir,'/',files(i).name));
    edge_temp = edge(im,'Canny');
    edge_file = sprintf('%s/%s.png', edgetemplate_dir, files(i).name(1:end-4));
    imwrite(edge_temp, edge_file);
end