data = load(['tsp_benchmark/' 'burma14_3323.tsp']);
x=data(:,1)/max([data(:,1);data(:,2)]);
y=data(:,2)/max([data(:,1);data(:,2)]);

seed = 4;
rng(seed);

meta_chromosome;

nparams = 16;
ngens = 20;
Nind = 50;
Nind_co = 30;
Nind_mu = Nind - Nind_co - 1;
alpha = 5;

generations = cell(Nind, nparams + 2, ngens);

pop = meta_generateInitialPop(50);

for gen = 1:ngens
    [Ds, Fs] = meta_fitness(@run_genalg, x, y, pop, alpha);
    
    elite = {pop{find(Fs == min(Fs),1), :}};

%    elite={};
%     [~,order]=sort(Fs);
%     for i=1:NofElites
%         elite = [elite ; {pop{find(Fs == Fs(order(i)),1),:}}];
%     end

    % sus verwacht fitnv's die gemaximaliseerd moeten worden -> ranking(Fs)
    parents = sus(ranking(Fs), 2*Nind_co);
    
    offspring = {};
    for i = 1:2:size(parents,1)
        child = meta_co_singlepoint_crossover({pop{parents(i),:}}, {pop{parents(i+1),:}});
        offspring = [offspring ; child];
    end

    % sus verwacht fitnv's die gemaximaliseerd moeten worden -> ranking(Fs)
    mutantParents = sus(ranking(Fs), Nind_mu);
    mutants = {};
    for m = 1:size(mutantParents, 1)
        mutant = meta_mu_pointMutation({pop{mutantParents(m), :}});
        mutants = [mutants ; mutant];
    end
    pop = [elite ; offspring ; mutants];
    generations(:,:,gen) = [pop, num2cell(Ds), num2cell(Fs)];
end

cols = [14, 16];
for col = cols
    for row = 1:size(generations,1)
        for depth = 1:size(generations,3)
            generations{row, col, depth} = func2str(generations{row, col, depth});
        end
    end
end

exp = 'ap';
params = {'nind', 'maxgen', 'elitist', 'stoppercentage', 'crossprob',...
          'cross_alternate_edges', 'cross_cyclic', 'cross_edge_recombination',...
          'cross_seq_const', 'muprob', 'mut_insertion', 'mut_inversion',...
          'mut_reciprocal_exchange', 'sus', 'os_sel_per', 'os_sel', 'distance', 'fitness';
          '%d\t', '%d\t', '%f\t', '%f\t', '%f\t',...
          '%f\t', '%f\t', '%f\t',...
          '%f\t', '%f\t', '%f\t', '%f\t',...
          '%f\t', '%s\t', '%f\t', '%s\t', '%f\t', '%f\t'};
for param = 1:size(params,2)
    file_name = strcat('results/',...
                exp,...
                's', num2str(seed),...
                'c', num2str(size(x,1)),...
                'n', num2str(Nind),...
                'g', num2str(ngens),...
                'a', num2str(alpha),...
                params{1,param},...
                '.txt');
    fileID = fopen(file_name,'w');
    formatSpec = params{2,param};
    nrows = size(generations);
    for row = 1:nrows
        fprintf(fileID, formatSpec, generations{row,param,:});
        fprintf(fileID, '\n');
    end
    fclose(fileID);
end

status = 'finished'
    
