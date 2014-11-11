nn=10000;
parent1=[1 2 3 4 5 6 7 8 9];
parent2=[4 1 2 8 7 6 9 3 5];
sols=zeros(7,1);
for i=1:nn
    child=edge_recombination_operator(parent1,parent2);
    if(child==[1 2 8 7 6 9 3 4 5])
        sols(1,1)=sols(1,1)+1/nn;
    else
        if(child==[1 2 8 7 6 9 3 5 4])
            sols(2,1)=sols(2,1)+1/nn;
        else
            if(child==[1 4 5 3 2 8 9 6 7])
                sols(3,1)=sols(3,1)+1/nn;
            else
                if(child==[1 4 5 3 2 8 7 6 9])
                    sols(4,1)=sols(4,1)+1/nn;
                else
                    if(child==[1 4 5 6 7 8 2 3 9])
                        sols(5,1)=sols(5,1)+1/nn;
                    else
                        if(child==[1 4 5 6 7 8 9 3 2])
                            sols(6,1)=sols(6,1)+1/nn;
                        else
                            sols(7,1)=sols(7,1)+1/nn;
                        end
                    end
                end
            end
        end
    end
end
%het resultaat zou iets van [0.25 0.25 0.125 0.125 0.125 0.125 0] moeten
%zijn als child(1)=1, kun je wel vastzetten in edge_recomb., anders moet
%het iets van [0.25/7 0.25/7 0.125/7 0.125/7 0.125/7 0.125/7 6/7] zijn