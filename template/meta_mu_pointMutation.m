function chrom = meta_mu_pointMutation(chrom)
    global limits
    global mutFreqs
    global nofInts
    mutatedPosition=find(cell2mat(mutFreqs)>rand,1);    
    if(isa(limits{mutatedPosition},'numeric'))
        if(mutatedPosition<=nofInts)
            chrom{mutatedPosition}=randi(limits{mutatedPosition});
        else
            lbound = limits{mutatedPosition}(1);
            ubound = limits{mutatedPosition}(end);
            chrom{mutatedPosition}=(ubound-lbound) * rand + lbound;
        end
    else
        if(size(limits{mutatedPosition},2)>0)
            chrom{mutatedPosition}=limits{mutatedPosition}{randi(size(limits{mutatedPosition},2))};
        end
    end
end
