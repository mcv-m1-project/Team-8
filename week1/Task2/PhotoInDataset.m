%Class PhotoInDataset: Image file with its necessary information.
%
%Attributes
%   -PhotoName: String -> file name without extensions
%   -PhotoRealClass: String -> character labels of its containing signals
%   -PhotoAmountOfSignals: Double -> number of signals it has
%   -PhotoGTFileAssociated: String -> ground truth file associated
%   including its path

classdef PhotoInDataset
    
    properties
        PhotoName
        PhotoRealClass
        PhotoAmountOfSignals
        PhotoGTFileAssociated
    end
    
end

