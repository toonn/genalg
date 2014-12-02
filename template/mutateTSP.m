% MUTATETSP.M       (MUTATion for TSP high-level function)
%
% This function takes a matrix OldChrom containing the 
% representation of the individuals in the current population,
% mutates the individuals and returns the resulting population.
%
% Syntax:  NewChrom = mutate(MUT_F, OldChrom, MutOpt)
%
% Input parameter:
%    MUT_F     - String containing the name of the mutation function
%    OldChrom  - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual.
%    MutOpt    - mutation rate
% Output parameter:
%    NewChrom  - Matrix containing the chromosomes of the population
%                after mutation in the same format as OldChrom.


function NewChrom = mutateTSP(MUT_Fs, mutation_probs, OldChrom, MutOpt)
% Check parameter consistency
   if nargin < 3,  error('Not enough input parameters'); end

    [rows,cols]=size(OldChrom);
    NewChrom=OldChrom;

    for r=1:rows
            mut_Ix = randsample(1:size(MUT_Fs, 2), 1, true, mutation_probs);
            if (rand < MutOpt)
                NewChrom(r,:) = feval(MUT_Fs{mut_Ix}, OldChrom(r,:),1);
            end
    end
end

