function [NormalFiles,LargerFiles,ImgDataset] = findMultiSignalImages(fileList,ImgDataset,thePath)

NormalFiles = [];
LargerFiles = [];

for i=1:length(fileList)
    content = fileread(fileList(i).name);
    SigEnd=strfind(content,sprintf('\n'));
    if length(SigEnd)>1
        LargerFiles = [LargerFiles; fileList(i)];
    else
        NormalFiles = [NormalFiles; fileList(i)];
        CrFile=strrep(strrep(fileList(i).name,'.txt',''),'gt/gt.','');
        CrFile=CrFile((length(thePath)+1):end);
        Phtmp=ImgDataset(CrFile);
        Phtmp.PhotoRealClass = content(SigEnd(1)-1);
        Phtmp.PhotoAmountOfSignals = 1;
        Phtmp.PhotoFictionClass = content(SigEnd(1)-1);
        ImgDataset(CrFile)=Phtmp;
    end
end
        