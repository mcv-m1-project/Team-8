classdef ImageFile
    properties
        FileName
        NumSignalsOfClass = containers.Map
    end
    methods
        function LoadNumSignals(SigClass, Numero)
            NumSignalsOfClass(SigClass)=Numero;
        end
    end
end
    