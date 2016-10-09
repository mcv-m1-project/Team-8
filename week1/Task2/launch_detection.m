function TableOfMultiSignal = parseContentOfMultiSignal (MultiSignalFiles)

TableOfMultiSignal = [];

for i=1:length(MultiSignalFiles)
    SignalsInThisFile=[];
    