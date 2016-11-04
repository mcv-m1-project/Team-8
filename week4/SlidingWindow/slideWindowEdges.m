function def_candidates= slideWindowEdges(Imag,WinSize,step,fr_threshold,margin)

ImgSize=size(Imag);

Candidates=[];

filling_ratio_max = 0.1138;
tlx = 0; tly = 0; brx = 0; bry = 0;

for i=1:step:(ImgSize(1)-WinSize(1)+1)
  for j=1:step:(ImgSize(2)-WinSize(2)+1)
    crop=Imag(i:(i+WinSize(1)-1),j:(j+WinSize(2)-1));
    [is_box, filling_ratio] = EvaluateWind(crop, fr_threshold);
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
def_candidates = check_candidates(Candidates,step,margin);
% if(size(def_candidates)~=[0,0])
%     for p=1:size(def_candidates(:,1))
%         imshow(Imag(def_candidates(p,1):def_candidates(p,2),def_candidates(p,3):def_candidates(p,4)));
%     end
% %disp(def_candidates);
% 
%     %def_candidates(:,1:4)=def_candidates(:,1:4)/size(Imag,1);
%     %def_candidates(:,1:4)=def_candidates(:,1:4)/size(Imag,2);
% end