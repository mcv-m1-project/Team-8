function Candidates= slideWindow(Imag,WinSize)

ImgSize=size(Imag);

step=[3,3];

Candidates=[];

filling_ratio_max = 0.1138;
tlx = 0; tly = 0; brx = 0; bry = 0;

for i=1:step(1):(ImgSize(1)-WinSize(1)+1)
  for j=1:step(2):(ImgSize(2)-WinSize(2)+1)
    crop=Imag(i:(i+WinSize(1)-1),j:(j+WinSize(2)-1));
    [is_box, filling_ratio] = EvaluateWind(crop, filling_ratio_max);
    if(is_box)
        if(filling_ratio > filling_ratio_max)
            filling_ratio_max = filling_ratio;
            tlx = i;
            brx = i+WinSize(1)-1;
            tly = j;
            bry = j+WinSize(2)-1;

        end
    else
        if(filling_ratio_max > 0.1138)
            Candidates=[Candidates;tlx,brx,tly,bry,filling_ratio_max];
            filling_ratio_max = 0.1138;
        end
            
    end
    %disp(filling_ratio_prev);
    %filling_ratio_max = filling_ratio_prev;
  end
end
disp(Candidates);
if(size(Candidates)~=[0,0])
    Candidates(:,1:4)=Candidates(:,1:4)/size(Imag,1);
    Candidates(:,1:4)=Candidates(:,1:4)/size(Imag,2);
end
buea