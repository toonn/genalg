function [ Children, Garbage ] = offspring_selection( Sel, Parents, Dists )
    FParents = ranking(tspfun(Parents, Dists));
    FSel = ranking(tspfun(Sel, Dists));

    Children = [];
    Garbage = [];
    for nr = 1:2:size(FParents, 1)-mod(size(FSel,1), 2)-1
        minParentF = min(FParents(nr), FParents(nr+1));
        if (FSel(nr) > minParentF)
            Children = [Children ; Sel(nr,:)];
        else
            Garbage = [Garbage ; Sel(nr,:)];
        end
        if (FSel(nr+1) > minParentF)
            Children = [Children ; Sel(nr+1,:)];
        else
            Garbage = [Garbage ; Sel(nr+1,:)];
        end
    end
    if (mod(size(FSel,1),2) == 1)
        minParentF = min(FParents(end-1), FParents(end));
        if (FSel(end) > minParentF)
            Children = [Children ; Sel(end,:)];
        else
            Garbage = [Garbage ; Sel(end,:)];
        end
    end
end

