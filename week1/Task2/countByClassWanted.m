function byClass = countByClassWanted(ImgDataset)

byClass=zeros(6,1);

keySet = keys(ImgDataset);

for i=1:length(keySet)
    CrImg=ImgDataset(keySet{i});
    if CrImg.PhotoAmountOfSignals == 1
        if CrImg.PhotoFictionClass == 'A'
            byClass(1)=byClass(1)+1;
        elseif CrImg.PhotoFictionClass == 'B'
            byClass(2)=byClass(2)+1;
        elseif CrImg.PhotoFictionClass == 'C'
            byClass(3)=byClass(3)+1;
        elseif CrImg.PhotoFictionClass == 'D'
            byClass(4)=byClass(4)+1;
        elseif CrImg.PhotoFictionClass == 'E'
            byClass(5)=byClass(5)+1;
        elseif CrImg.PhotoFictionClass == 'F'
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