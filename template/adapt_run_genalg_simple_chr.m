function smallest_tour_dist = adapt_run_genalg_simple_chr(x, y, ps)
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
    crossover_operator = ps{6};
% PR_MUT: probability for mutation
    PR_MUT = ps{7};
    mutation_operator = ps{8};
% selection: selection method
    selection = ps{9};
% os_selection_percentage: percentage of offspring that has to be beter
%                           than either parent
    os_selection_percentage = ps{10};
% os_selection: offspring selection method
    os_selection = ps{11};
    
    GGAP = 1 - ELITIST;
    %Wat variabelen initialiseren met de correcte grootte
    best=ones(1,MAXGEN)*Inf;
    mean_fits=zeros(1,MAXGEN);
    worst=zeros(1,MAXGEN);
    NVAR = size(x, 1);
    %De matrix opbouwen, er wordt wel verondersteld dat
    %size(x,1)==size(y,1)==NVAR
    Dist=zeros(NVAR,NVAR);
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
        if(gen==ceil(MAXGEN/2))
            PR_CROSS = ps{12};
            crossover_operator = ps{13};
            PR_MUT = ps{14};
            mutation_operator = ps{15};
        end
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
        NSelOs = floor(NSel*os_selection_percentage);
        NSel2 = NSel;
        NSelPer = (NSel + mod(NSel,2))/Nind;
        SelCh = [];
        for tries = 1:5
            Parents = select(selection, Chrom, FitnV, NSelPer);
            Children = recombine({crossover_operator}, [1], Parents, Dist, PR_CROSS);
            Children = Children(1:end-mod(NSel2, 2),:);
            [Children, Garbage] = os_selection(Children, Parents, Dist);
            NSel2 = NSel - size(SelCh, 1);
            NSelPer = (NSel2 + mod(NSel2, 2))/Nind;
            if (size(Children,1) < NSel2)
                SelCh = [SelCh ; Children];
                if (size(SelCh,1) >= NSelOs)
                    break;
                end
            else
                SelCh = [SelCh ; Children(1:NSel2, :)];
                break;
            end
        end
        SelCh = [SelCh ; Garbage];
        %evaluate offspring, call objective function
        ObjVSel = tspfun(SelCh,Dist);
        %reinsert offspring into population
        [Chrom, ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
        Chrom = mutateTSP({mutation_operator}, [1], Chrom, PR_MUT);
        %Chrom = tsp_ImprovePopulation(Nind, NVAR, Chrom,1,Dist);
        %increment generation counter
        gen=gen+1;
    end
    smallest_tour_dist = best(find(best < Inf,1,'last'));
end
