function child = meta_co_singlepoint_crossover( parent1, parent2 )
    co_point = randi(size(parent1, 2));
    child = [parent1(1, 1:co_point) parent2(1, co_point+1:end)];
end
