data = load(['datasets/' 'rondrit016.tsp']);
x=data(:,1)/max([data(:,1);data(:,2)]);
y=data(:,2)/max([data(:,1);data(:,2)]);

Nind = 50;
Noffspring = 30;
Nmutants = Nind - Noffspring - 1;

meta_chromosome;
pop = meta_generateInitialPop(50);

for gen = 1:20
    Fs = [];
    for ind = pop'  
        ind = ind';
        tic;
            best_dist = run_genalg(x, y, ind);
        t = toc;
        F = f + t;
        Fs = [Fs ; F];
    end

    Elite = Fs(Fs == min(Fs));

    Parents = sus(Fs, 2*Noffspring);
    Offspring = {};
    for i = 1:2:size(Parents,1)
        child = meta_co_singlepoint_crossover(pop{Parents(i)}, pop{Parents(i+1)});
        Offspring = [Offspring ; child];
    end

    Mutands = sus(Fs, Nmutants);
    Mutants = {};
    for m = 1:size(Mutands, 1)
        mutant = meta_mu_pointMutation(pop{Mutands(m)});
        Mutants = [Mutants ; mutant];
    end
    
    pop = [Elite ; Offspring ; Mutants];
end

Elite
    