data = load(['datasets/' 'rondrit016.tsp']);
x=data(:,1)/max([data(:,1);data(:,2)]);
y=data(:,2)/max([data(:,1);data(:,2)]);

rng(4);

meta_chr_single_cx;

nparams = 11;
ngens = 20;
Nind = 50;
Nind_co = 30;
Nind_mu = Nind - Nind_co - 1;

generations = cell(Nind, nparams + 1, ngens);

pop = meta_generateInitialPop(50);

for gen = 1:ngens
    Fs = meta_fitness(@run_genalg_simple_chr, x, y, pop);
    
    elite = {pop{find(Fs == min(Fs),1), :}};

%    elite={};
%     [~,order]=sort(Fs);
%     for i=1:NofElites
%         elite = [elite ; {pop{find(Fs == Fs(order(i)),1),:}}];
%     end
    

    parents = sus(Fs, 2*Nind_co);
    
    offspring = {};
    for i = 1:2:size(parents,1)
        child = meta_co_singlepoint_crossover({pop{parents(i),:}}, {pop{parents(i+1),:}});
        offspring = [offspring ; child];
    end

    mutantParents = sus(Fs, Nind_mu);
    mutants = {};
    for m = 1:size(mutantParents, 1)
        mutant = meta_mu_pointMutation({pop{mutantParents(m), :}});
        mutants = [mutants ; mutant];
    end
    pop = [elite ; offspring ; mutants];
    generations(:,:,gen) = [pop, num2cell(Fs)];
end

status = 'finished'
    
