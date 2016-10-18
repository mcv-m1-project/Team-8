%countByClass: takes a dataset of images and returns the total number of
%signals of each class on it.
%
%Input:
%   -ImgDataset: Map of PhotoInDataset -> the dataset of images to explore
%
%Output:
%   -byClass: Array of Double -> array containing the number of Signals in
%   each class. It has the following order: [A,B,C,D,E,F].

function byClass = countByClass(ImgDataset)

byClass=zeros(6,1);

keySet = keys(ImgDataset);

for i=1:length(keySet)
    CrImg=ImgDataset(keySet{i});
    if CrImg.PhotoAmountOfSignals == 1
        if CrImg.PhotoRealClass == 'A'
            byClass(1)=byClass(1)+1;
        elseif CrImg.PhotoRealClass == 'B'
            byClass(2)=byClass(2)+1;
        elseif CrImg.PhotoRealClass == 'C'
            byClass(3)=byClass(3)+1;
        elseif CrImg.PhotoRealClass == 'D'
            byClass(4)=byClass(4)+1;
        elseif CrImg.PhotoRealClass == 'E'
            byClass(5)=byClass(5)+1;
        elseif CrImg.PhotoRealClass == 'F'
            byClass(6)=byClass(6)+1;
        end
    elseif CrImg.PhotoAmountOfSignals == 2
        for j= 1:2
            if CrImg.PhotoRealClass(j) == 'A'
                byClass(1)=byClass(1)+1;
            elseif CrImg.PhotoRealClass(j) == 'B'
                byClass(2)=byClass(2)+1;
            elseif CrImg.PhotoRealClass(j) == 'C'
                byClass(3)=byClass(3)+1;
            elseif CrImg.PhotoRealClass(j) == 'D'
                byClass(4)=byClass(4)+1;
            elseif CrImg.PhotoRealClass(j) == 'E'
                byClass(5)=byClass(5)+1;
            elseif CrImg.PhotoRealClass(j) == 'F'
                byClass(6)=byClass(6)+1;
            end
        end
    elseif CrImg.PhotoAmountOfSignals == 3
        for j= 1:3
            if CrImg.PhotoRealClass(j) == 'A'
                byClass(1)=byClass(1)+1;
            elseif CrImg.PhotoRealClass(j) == 'B'
                byClass(2)=byClass(2)+1;
            elseif CrImg.PhotoRealClass(j) == 'C'
                byClass(3)=byClass(3)+1;
            elseif CrImg.PhotoRealClass(j) == 'D'
                byClass(4)=byClass(4)+1;
            elseif CrImg.PhotoRealClass(j) == 'E'
                byClass(5)=byClass(5)+1;
            elseif CrImg.PhotoRealClass(j) == 'F'
                byClass(6)=byClass(6)+1;
            end
        end
    end
end

end