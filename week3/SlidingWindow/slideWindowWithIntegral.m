function def_candidates= slideWindowWithIntegral(Imag,WinSize,step,fr_threshold)

ImgSize=size(Imag);

Candidates=[];

filling_ratio_max = 0.1138;
tlx = 0; tly = 0; brx = 0; bry = 0;
IntegralImg = integralImage(Imag);

for i=1:step:(ImgSize(1)-WinSize(1)+1)
  for j=1:step:(ImgSize(2)-WinSize(2)+1)
    crop=Imag(i:(i+WinSize(1)-1),j:(j+WinSize(2)-1));
    [is_box, filling_ratio] = EvaluateIntegral(IntegralImg, [i+1,(i+WinSize(1)),j+1,(j+WinSize(2))], fr_threshold);
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
            %Imag((i-step):(i+WinSize(1)-1-step),(j-step):(j+WinSize(2)-1-step))=0;
            filling_ratio_max = 0.1138;
        end
            
    end
    %disp(filling_ratio_prev);
    %filling_ratio_max = filling_ratio_prev;
  end
end
def_candidates = check_candidates(Candidates,step);