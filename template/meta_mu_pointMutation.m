function chrom = meta_mu_pointMutation(chrom)
    global limits
    global mutFreqs
    global nofInts
    mutatedPosition=find(cell2mat(mutFreqs)>rand,1);    
    if(isscalar(limits{mutatedPosition}))
        chrom{mutatedPosition}=limits{mutatedPosition}*rand;
        if(mutatedPosition<=nofInts)
            chrom{mutatedPosition}=round(chrom{mutatedPosition});
        end
    else
        if(size(limits{mutatedPosition},2)>0)
            chrom{mutatedPosition}=limits{mutatedPosition}{randi(size(limits{mutatedPosition},2))}
        end
    end
end
