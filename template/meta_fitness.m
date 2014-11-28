function Fs = meta_fitness( genalg, x, y, pop, cxopcosts, muopcosts )
    
    Fs = [];
    for ind = pop'  
        ind = ind';
        best_dist = genalg(x, y, ind);
        F = best_dist;
        Fs = [Fs ; F];
    end
    
    if exist('cxopcosts', 'var')
    
    end
    
    if exist('muopcosts', 'var')
        
    end
end

