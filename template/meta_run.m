data = load(['datasets/' 'rondrit016.tsp']);
x=data(:,1)/max([data(:,1);data(:,2)]);
y=data(:,2)/max([data(:,1);data(:,2)]);

rng(121);

Nind = 50;
Nind_co = 30;
Nind_mu = Nind - Nind_co - 1;

meta_chromosome;
pop = meta_generateInitialPop(50);

for gen = 1:20
    Fs = [];
    for ind = pop'  
        ind = ind';
        tic;
            best_dist = run_genalg(x, y, ind);
        t = toc;
        F = best_dist + t;
        Fs = [Fs ; F];
    end

    elite = Fs(Fs == min(Fs));

    parents = sus(Fs, 2*Nind_co);
    offspring = {};
    for i = 1:2:size(parents,1)
        child = meta_co_singlepoint_crossover(pop{parents(i)}, pop{parents(i+1)});
        offspring = [offspring ; child];
    end

    mutantParents = sus(Fs, Nind_mu);
    mutants = {};
    for m = 1:size(mutantParents, 1)
        mutant = meta_mu_pointMutation(pop{mutantParents(m)});
        mutants = [mutants ; mutant];
    end
    
    pop = [elite ; offspring ; mutants];
end

elite
    
