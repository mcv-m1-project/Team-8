addpath(genpath('.'))
template_dir = 'image_templates/50x50/';
edgetemplate_dir = 'edge_templates/';

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
