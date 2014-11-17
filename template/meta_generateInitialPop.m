function pop = meta_generateInitialPop(N)
global limits
global nofInts
pop={};
for i=1:size(limits,2)
    if(isa(limits{i},'numeric'))
        if(i>nofInts)
            pop=[pop num2cell(limits{i}*rand(N,1))];
        else
            pop=[pop num2cell(round(limits{i}*rand(N,1)))];
        end
    else
        if(size(limits{i},2)>0)
            pop=[pop {limits{i}{randi(size(limits{i}),N,1)}}'];
        else
            pop=[pop num2cell(zeros(N,1))];
        end
    end
end
end
