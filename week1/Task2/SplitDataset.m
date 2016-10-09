PathLocation = '/home/ihcv00/DataSet/train/';
gtFiles=ListTxtFilesWithPath(strcat(PathLocation,'gt/'));
ImgDataset = initDataset(gtFiles,PathLocation);
[SingleSigList,MultiSigList,ImgDataset]=findMultiSignalImages(gtFiles,ImgDataset,PathLocation);
[Trip,Doub,Unk]=SplitByNumOfSig(MultiSigList);
[DoubleTable, ImgDataset]= parseContentOfMultiSignFile(Doub,ImgDataset,PathLocation);
[TripleTable, ImgDataset]= parseContentOfMultiSignFile(Trip,ImgDataset,PathLocation);
byClassWanted=countByClassWanted(ImgDataset);
[byClassToSplit,AList,BList,CList,DList,EList,FList]=countByClassToSplit(ImgDataset);
byClassInX=round(0.7*byClassToSplit);
byClassInXWanted=round(0.7*byClassWanted);
byClassInX(1)=byClassInX(1)-1;
byClassInXWanted(5)=byClassInXWanted(5)-1;
ASamples=datasampleNoRep(AList,byClassInX(1));
BSamples=datasampleNoRep(BList,byClassInX(2));
CSamples=datasampleNoRep(CList,byClassInX(3));
DSamples=datasampleNoRep(DList,byClassInX(4));
ESamples=datasampleNoRep(EList,byClassInX(5));
FSamples=datasampleNoRep(FList,byClassInX(6));
[ImgDatasetX,ImgDatasetY] = DoSplit(ImgDataset, AList,ASamples,BList,BSamples,CList,CSamples,DList,DSamples,EList,ESamples,FList,FSamples);
byRealClassAfterTheSplitX=countByClassWanted(ImgDatasetX);
byRealClassAfterTheSplitY=countByClassWanted(ImgDatasetY);
Props = byRealClassAfterTheSplitX./byClassWanted;
PropDifferences = abs(Props-0.7);
BiggerOrSmaller = (Props-0.7)./PropDifferences;
GeneralBiggerOrSmaller = (sum(byRealClassAfterTheSplit)-sum(byClassInXWanted))/abs(sum(byRealClassAfterTheSplit)-sum(byClassInXWanted));
[vals,Ix]=sort(PropDifferences);
Ix=Ix(end:-1:1);
IxToFix=[];
for i=1:length(Ix)
    if BiggerOrSmaller(Ix(i))==GeneralBiggerOrSmaller
        IxToFix=[IxToFix; Ix(i)];
    end
end
