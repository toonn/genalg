% RECOMBIN.M       (RECOMBINation high-level function)
%
% This function performs recombination between pairs of individuals
% and returns the new individuals after mating. The function handles
% multiple populations and calls the low-level recombination function
% for the actual recombination process.
%
% Syntax:  NewChrom = recombin(REC_F, OldChrom, RecOpt, SUBPOP)
%
% Input parameters:
%    REC_F     - String containing the name of the recombination or
%                crossover function
%    Chrom     - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual
%    RecOpt    - (optional) Scalar containing the probability of 
%                recombination/crossover occurring between pairs
%                of individuals.
%                if omitted or NaN, 1 is assumed
%    SUBPOP    - (optional) Number of subpopulations
%                if omitted or NaN, 1 subpopulation is assumed
%
% Output parameter:
%    NewChrom  - Matrix containing the chromosomes of the population
%                after recombination in the same format as OldChrom.



function NewChrom = recombine(REC_Fs, crossover_probs, Chrom, costMatrix)
    REC_Fs = {@co_edge_recombination_operator, @co_edge_recombination_operator, @co_edge_recombination_operator, @co_edge_recombination_operator};
    crossover_probs = crossover_probs/sum(crossover_probs);
    NewChrom = [];
    for irun = 1:2:size(Chrom,1)-1
        parent1 = Chrom(irun, :);
        parent2 = Chrom(irun+1, :);
        cx_Ix = randsample(1:size(REC_Fs, 2), 1, true, crossover_probs);
        children = feval(REC_Fs{cx_Ix}, parent1, parent2, costMatrix);
        NewChrom=[NewChrom; children];
    end

