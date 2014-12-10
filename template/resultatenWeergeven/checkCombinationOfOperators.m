function frequenciesOfCombinations = checkCombinationOfOperators(cos, mus, nofmetainds, nofmaxmetagens)

musToCheck = {'mu_insertion',...
         'mu_inversion',...
         'mu_reciprocal_exchange'};
cosToCheck = {'co_cross_alternate_edges',...
         'co_cyclic_crossover',...
         'co_edge_recombination_operator',...
         'co_sequential_constructive_crossover'};

cosnof=changeStringsToNumbers(cos,cosToCheck);
musnof=changeStringsToNumbers(mus,musToCheck);

for i=1:size(cosToCheck,2)
    for j=1:size(musToCheck,2)
        frequenciesOfCombinations(i,j)=size(find(((cosnof==i)+(musnof==j))==2),1)/nofmaxmetagens/nofmetainds;
    end
end

end