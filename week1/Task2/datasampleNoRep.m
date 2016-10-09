function Samples = datasampleNoRep(TheList,NumOfSamp)

Samples=[];

sortVec=randperm(length(TheList));
for i=1:NumOfSamp
    Samples=[Samples;TheList(i,:)];
end
