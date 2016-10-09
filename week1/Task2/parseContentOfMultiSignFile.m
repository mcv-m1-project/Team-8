function [TableOfMultiSignal, ImgDataset] = parseContentOfMultiSignFile (MultiSignFiles, ImgDataset, thePath)

TableOfMultiSignal=[];

for i=1:length(MultiSignFiles)
    content = fileread(MultiSignFiles(i).name);
    SignalsInThisFile=[];
    SigEnd=strfind(content,sprintf('\n'));    
    CrFile=strrep(strrep(MultiSignFiles(i).name,'.txt',''),'gt/gt.','');
    CrFile=CrFile((length(thePath)+1):end);
    Phtmp=ImgDataset(CrFile);
    Phtmp.PhotoRealClass = '';
    Phtmp.PhotoAmountOfSignals = length(SigEnd);
    Phtmp.PhotoFictionClass = content(SigEnd(1)-1);
    for j=1:length(SigEnd)
        SignalsInThisFile=[SignalsInThisFile,content(SigEnd(j)-1)];
        Phtmp.PhotoRealClass = strcat(Phtmp.PhotoRealClass,content(SigEnd(j)-1));
    end
    ImgDataset(CrFile)=Phtmp;
    TableOfMultiSignal = [TableOfMultiSignal;SignalsInThisFile];
end