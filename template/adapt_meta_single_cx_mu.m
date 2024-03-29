data = load(['datasets/' 'rondrit016.tsp']);
x=data(:,1)/max([data(:,1);data(:,2)]);
y=data(:,2)/max([data(:,1);data(:,2)]);

seed = 4;
rng(seed);

adapt_meta_chr_single_cx_mu;

nparams = 15;
ngens = 50;
Nind = 50;
Nind_co = 30;
Nind_mu = Nind - Nind_co - 1;
alpha = 0.02;

generations = cell(Nind, nparams + 2, ngens);


pop = meta_generateInitialPop(50);

for gen = 1:ngens
    [Ds, Fs] = adapt_meta_fitness(@adapt_run_genalg_simple_chr, x, y, pop, alpha);
    
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

cols = [6,8,9,11,13,15];
for col = cols
    for row = 1:size(generations,1)
        for depth = 1:size(generations,3)
            generations{row, col, depth} = func2str(generations{row, col, depth});
        end
    end
end

exp = 'asp';
params = {'nind', 'maxgen', 'elitist', 'stoppercentage',...
          'crossprob', 'crossop', 'muprob', 'muop',...
          'sus', 'os_sel_per', 'os_sel',...
          'crossprob2', 'crossop2',...
          'muprob2', 'muop2',...
          'distance', 'fitness';
          '%d\t', '%d\t', '%f\t', '%f\t',...
          '%f\t', '%s\t', '%f\t', '%s\t',...
          '%s\t', '%f\t', '%s\t',...
          '%f\t', '%s\t', ...
          '%f\t', '%s\t', ...
          '%f\t', '%f\t'};
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
    
