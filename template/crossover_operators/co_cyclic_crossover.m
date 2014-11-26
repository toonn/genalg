function child = co_cyclic_crossover(parent1, parent2, ~)
    i=randi(size(parent1, 2)-1);
    
    parent1 = adj2path(parent1);
    parent2 = circshift(adj2path(parent2), [0, i]);

    parents=[parent1 ; parent2];
    N=size(parent1,2);
    child=zeros(2,N);

    child(1,1) = parents(1,1);
    child(2,1) = parents(2,1);
    next = [find(parents(1,:) == parents(2,1)), ...
            find(parents(2,:) == parents(1,1))];
    while (next(1) ~= 1)
        child(1, next(1)) = parents(1, next(1));
        child(2, next(2)) = parents(2, next(2));
        next = [find(parents(1,:) == parents(2,next(1))), ...
                find(parents(2,:) == parents(1,next(2)))];
    end
    parents([1 2], :) = parents([2 1], :);
    child(find(child==0)) = parents(find(child==0));
    
    child(1,:) = path2adj(child(1,:));
    child(2,:) = path2adj(child(2,:));
end