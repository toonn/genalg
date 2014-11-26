function Offspring = co_cross_alternate_edges(parent1, parent2, ~)
    parent1 = adj2path(parent1);
    parent2 = adj2path(parent2);
    
    Offspring(1,:) = cross_alternate_edges([parent1 ; parent2]);
    Offspring(2,:) = cross_alternate_edges([parent2 ; parent1]);
    
    Offspring(1,:) = path2adj(Offspring(1,:));
    Offspring(2,:) = path2adj(Offspring(2,:));
end

