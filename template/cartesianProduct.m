function result = cartesianProduct(sets)
    if size(sets, 2) == 0
        result = [{}]
    else
        result = zeros(0,1)
        for elem = sets(1)
            for cell = cartesianProduct(sets(2:end))
                [result ; [elem cell]]
            end
        end
    end
end