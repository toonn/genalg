function smallest_tour_dist = run_genalg(x, y, ps)
% x, y: coordinates of the cities
% NIND: number of individuals
    Nind = ps{1};
% MAXGEN: maximal number of generations
    MAXGEN = ps{2};
% ELITIST: percentage of elite population
    ELITIST = ps{3};
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
    STOP_PERCENTAGE = ps{4};
% PR_CROSS: probability for crossover
    PR_CROSS = ps{5};
    crossover_operators = {@co_cyclic_crossover,@co_cyclic_crossover,@co_cyclic_crossover,@co_cyclic_crossover};
%     {@co_cross_alternate_edges, ...
%                             @co_cyclic_crossover, ...
%                             @co_edge_recombination_operator, ...
%                             @co_sequential_constructive_crossover};
    crossover_probs = [ps{6:9}];
% PR_MUT: probability for mutation
    PR_MUT = ps{10};
    mutation_operators = {@mu_inversion, @mu_reciprocal_exchange, @mu_insertion};
    mutation_probs = [ps{11:13}];
% selection: selection method
    selection = ps{14};
% os_selection_percentage: percentage of offspring that has to be beter
%                           than either parent
    os_selection_percentage = ps{15};
% os_selection: offspring selection method
    os_selection = ps{16};
    
    GGAP = 1 - ELITIST;
    %Wat variabelen initialiseren met de correcte grootte
    best=zeros(1,MAXGEN);
    mean_fits=zeros(1,MAXGEN+1);
    worst=zeros(1,MAXGEN+1);
    NVAR = size(x, 1);
    Dist=zeros(NVAR,NVAR);
    %De matrix opbouwen, er wordt wel verondersteld dat
    %size(x,1)==size(y,1)==NVAR
    for j=1:NVAR
        Dist(:,j)=sqrt((x(:)-x(j)).^2+(y(:)-y(j)).^2);
    end
    
    % initialize population
    Chrom=zeros(Nind,NVAR);
    for row=1:Nind
        Chrom(row,:)=path2adj(randperm(NVAR));
    end

    % number of individuals of equal fitness needed to stop
    stopN=ceil(STOP_PERCENTAGE*Nind);
    % evaluate initial population
    ObjV = tspfun(Chrom,Dist);
    
    gen=0;
    % generational loop
    while gen<MAXGEN
        %de sObjV is belangrijk voor het stopcriterium
        [sObjV,~]=sort(ObjV);
        best(gen+1)=sObjV(1);
        mean_fits(gen+1)=mean(ObjV);
        worst(gen+1)=sObjV(end);
        
        %termination criterion
        if (sObjV(stopN)-sObjV(1) <= 1e-15)
              break;
        end
        %assign fitness values to entire population
        FitnV=ranking(ObjV);
        %select individuals for breeding
        % Werkt niet voor subpopulaties!
        NSel=max(floor(Nind*GGAP+.5),2);
        SelCh=select(selection, Chrom, FitnV, GGAP+(mod(NSel,2)/Nind));

        %recombine individuals (crossover)
        if(false && round(os_selection_percentage*NVAR)>=1)
            %iets dat de offspringselection moet doen
            SelCh = offspringSelection(os_selection,CROSSOVER,mutation, ...
                                        SelCh,pr_cross,pr_mut, ...
                                        round(os_selection_percentage*NVAR));
            %nog iets om [Chrom ObjV te krijgen]
        else
            SelCh = recombine(crossover_operators, crossover_probs, SelCh, Dist);
            SelCh = SelCh(1:end-mod(NSel,2),:);
            %evaluate offspring, call objective function
            ObjVSel = tspfun(SelCh,Dist);
            %reinsert offspring into population
            [Chrom, ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            Chrom = mutateTSP(mutation_operators, mutation_probs, Chrom, PR_MUT);
        end
        %Chrom = tsp_ImprovePopulation(Nind, NVAR, Chrom,1,Dist);
        %increment generation counter
        gen=gen+1;
    end
    smallest_tour_dist = best(end);
end
