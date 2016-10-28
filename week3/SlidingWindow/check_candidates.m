function def_Candidates = check_candidates(Candidates,step)
    def_Candidates=[];
    if(size(Candidates,1) > 0)
        for i=1:size(Candidates,1)-1          
               keepCand = true;
               if(Candidates(i,5) == 100)
                   keepCand = false;
               end
               %if(keepCand == true)
                    list_equals = find(Candidates(:,1) == Candidates(i,1) + step);
                    for j=1:length(list_equals)
                        if(((Candidates(i,3)) >= (Candidates(list_equals(j),3) - step)) & ((Candidates(i,3)) <= (Candidates(list_equals(j),3) + step)))
                            if(Candidates(i,5) <= Candidates(list_equals(j),5))
                                keepCand = false;
                            else
                                Candidates(list_equals(j),5) = 100;
                            end
                        end
                    end
               %end
               if(keepCand == true)     
                    def_Candidates =[def_Candidates;Candidates(i,1:4)];
               end            
        end
        if Candidates(size(Candidates,1),5) ~= 100 
            def_Candidates =[def_Candidates;Candidates(size(Candidates,1),1:4)];
        end
    end 
        
end

