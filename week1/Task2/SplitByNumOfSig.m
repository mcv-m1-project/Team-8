function [TripleMultiSigFiles, DoubleMultiSigFiles, UnknownMultiSigFiles] = SplitByNumOfSig( MultiSigFiles )

TripleMultiSigFiles = [];
DoubleMultiSigFiles = [];
UnknownMultiSigFiles = [];



for i=1:length(MultiSigFiles)
    content = fileread(MultiSigFiles(i).name);
    if length(strfind(content,sprintf('\n')))==3
        TripleMultiSigFiles=[TripleMultiSigFiles,MultiSigFiles(i)];
        
    elseif length(strfind(content,sprintf('\n')))==2
        DoubleMultiSigFiles=[DoubleMultiSigFiles,MultiSigFiles(i)];
    else
        UnknownMultiSigFiles=[UnknownMultiSigFiles,MultiSigFiles(i)];
    end
end


end

