function result = cartesianProduct(sets)
    if size(sets, 2) == 0
        result = {{}};
    else
        if size(sets, 2) == 1
            result = {};
            for elem = sets{1}
                result = [result ; elem];
            end
        else
            result = {};
            previous = cartesianProduct(sets(2:end));
            for elem = sets{1}
                for cell = previous'
                    result = [result ; [elem cell']];
                end
            end
        end
    end
end