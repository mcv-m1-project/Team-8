%ListTxtFilesWithPath: from a given directory it returns its containing
%.txt file names including their path.
%
%Input:
%   directory: String -> Directory to explore
%
%Output:
%   files: Array of Strings -> Files on the directory


function files = ListTxtFilesWithPath(directory)

f = dir(directory);

files = [];
for i=1:size(f,1)
    if f(i).isdir==0,
        if strcmp(f(i).name(end-2:end),'txt')==1,
            files = [files ; f(i)];
            files(length(files)).name= strcat(directory,files(length(files)).name);
        end
    end
end