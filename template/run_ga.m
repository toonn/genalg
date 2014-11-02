function run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, mutation, selection, os_selection_percentage, os_selection)
% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, 
%               ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% MAXGEN: maximal number of generations
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP}
    %default waarden voor de extra toegevoegde opties
    if ~exist('mutation', 'var')
        mutation = 'inversion';
    end
    if ~exist('selection', 'var')
        selection = 'sus';
    end
    if ~exist('os_selection_percentage', 'var')
        os_selection_percentage = 0;
    end
    if ~exist('os_selection', 'var')
        os_selection = 'aMethod';
    end
    
    GGAP = 1 - ELITIST;
    %Wat variabelen initialiseren met de correcte grootte
    mean_fits=zeros(1,MAXGEN+1);
    worst=zeros(1,MAXGEN+1);
    Dist=zeros(NVAR,NVAR);
    %De matrix opbouwen, er wordt wel verondersteld dat
    %size(x,1)==size(y,1)==NVAR
    for j=1:NVAR
        Dist(:,j)=sqrt((x(:)-x(j)).^2+(y(:)-y(j)).^2);
    end
    
    % initialize population
    Chrom=zeros(NIND,NVAR);
    for row=1:NIND
        Chrom(row,:)=path2adj(randperm(NVAR));
        %Chrom(row,:)=randperm(NVAR);
    end
    
    gen=0;
    % number of individuals of equal fitness needed to stop
    stopN=ceil(STOP_PERCENTAGE*NIND);
    % evaluate initial population
    ObjV = tspfun(Chrom,Dist);
    best=zeros(1,MAXGEN);
    % generational loop
    while gen<MAXGEN
        %de sObjV is belangrijk voor het stopcriterium
        [sObjV,indices]=sort(ObjV);
        best(gen+1)=sObjV(1);
        minimum=best(gen+1);
        mean_fits(gen+1)=mean(ObjV);
        worst(gen+1)=sObjV(end);
        t=indices(1);

        visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);

        %termination criterion
        if (sObjV(stopN)-sObjV(1) <= 1e-15)
              break;
        end
        %assign fitness values to entire population
        FitnV=ranking(ObjV);
        %select individuals for breeding
        SelCh=select(selection, Chrom, FitnV, GGAP);
        %recombine individuals (crossover)
        if(round(os_selection_percentage*NVAR)>=1)
            %iets dat de offspringselection moet doen
            selCh = offspringSelection(os_selection,CROSSOVER,mutation,SelCh,pr_cross,pr_mut,round(os_selection_percentage*NVAR));
            %nog iets om [Chrom ObjV te krijgen]
        else
            SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
            SelCh = mutateTSP(mutation,SelCh,PR_MUT);
            %evaluate offspring, call objective function
            ObjVSel = tspfun(SelCh,Dist);
            %reinsert offspring into population
            [Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
        end
        
        Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
        %increment generation counter
        gen=gen+1;            
    end
end
