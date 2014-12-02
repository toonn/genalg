experiment='sp';
seed=4;
nofCities=14;
nofmetainds=50;
nofmaxmetagens=20;
alpha=1;
expstring=getExperimentString(experiment,seed,nofCities,nofmetainds,nofmaxmetagens,alpha);

%%

param1='co_operator';
cos=load(strcat(expstring,param1,'.txt'));
param2='mu_operator';
mus=load(strcat(expstring,param2,'.txt'));

muops = {'mu_insertion',...
         'mu_inversion',...
         'mu_reciprocal_exchange'};
cxops = {'co_cross_alternate_edges',...
         'co_cyclic_crossover',...
         'co_edge_recombination_operator',...
         'co_sequential_constructive_crossover'};

for i=size(cosToCheck,2)
    for j=size(musToCheck,2)
        frequenciesOfCombinations=size(find(cos==cosToCheck(i) && mus==musToCheck(j)))/nofmetainds;
    end
end

%Geeft welke combinatie van operators hoeveel keer voorkomt
frequenciesOfCombinations

%%
param1='crossprob';
cop=load(strcat(expstring,param1,'.txt'));
param2='muprob';
mup=load(strcat(expstring,param2,'.txt'));

plot(1:nofmaxmetagens,mean(cop));
hold all;
plot(1:nofmaxmetagens,mean(mup));
hold off;









