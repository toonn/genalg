function [Ds, Fs] = adapt_meta_fitness( genalg, x, y, pop, alpha)
    meta_optimes;
    
    if size(pop(1,:), 2) > 15
        op_times = [optimes('co_cross_alternate_edges'),...
                 optimes('co_cyclic_crossover'),...
                 optimes('co_edge_recombination_operator'),...
                 optimes('co_sequential_constructive_crossover'),...
                 optimes('mu_insertion'),...
                 optimes('mu_inversion'),...
                 optimes('mu_reciprocal_exchange')];
    end
    
    Fs = [];
    Ds = [];
    for ind = pop'
        ind = ind';
        best_dist = genalg(x, y, ind);
        D = best_dist;
        
        % Tijd is som van (#keer operators uitgevoerd worden * kost operators)
        % #keer is #indiv * #gens ~ #maxgens * (1-elite)
        nofoperatorexecutions = ind{1} * ind{2} * (1-ind{3});
        if exist('op_times', 'var')
            % kost is kans op cx/mu ind(5/10) * kans op operator ([ind...]) * tijd voor operator (op_times)
            F = best_dist + alpha * sum( nofoperatorexecutions *...
                            ([(ind{5} .* [ind{6:9}]) (ind{10} .* [ind{11:13}])] .* op_times));
        else
            %ook aangepast voor adapt
            F = best_dist + alpha * nofoperatorexecutions * 0.5 * (ind{5} * optimes(func2str(ind{6}))...
                                            + ind{7} * optimes(func2str(ind{8})) + ind{12} * optimes(func2str(ind{13})) + ind{14} * optimes(func2str(ind{15})));
        end
        Fs = [Fs ; F];
        Ds = [Ds ; D];
    end
    
end

