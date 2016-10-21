function [NewStructel,NewStruCent] = DilateStructel(structel,struCent,times)

NewStructel = zeros(((times+1)*size(structel))-times);

NewStructel(((times*(struCent(1)-1))+1):(((times*(struCent(1)-1))+size(structel,1))),((times*(struCent(2)-1))+1):(((times*(struCent(2)-1))+size(structel,2)))) = structel;

NewStruCent = struCent;

for i=1:times
    NewStructel=M1_Team8_Dilation(NewStructel, structel, struCent);
    NewStruCent=NewStruCent+struCent-[1,1];
end

end