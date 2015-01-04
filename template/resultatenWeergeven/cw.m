experiment='cw';
seed=4;
nofCities=16;
nofmetainds=50;
nofmaxmetagens=50;
alpha=0.02;
expstring=getExperimentString(experiment,seed,nofCities,nofmetainds,nofmaxmetagens,alpha);

%%

param1='crossop';
param2='muop';
cos=openFileWithStrs(strcat(expstring,param1,'.txt'));
mus=openFileWithStrs(strcat(expstring,param2,'.txt'));

%Geeft welke combinatie van operators hoeveel keer voorkomt
frequenciesOfCombinations = checkCombinationOfOperators(cos,mus,nofmetainds,nofmaxmetagens)

%%
cx_strings = {'co_cross_alternate_edges', 'co_cyclic_crossover', 'co_edge_recombination_operator'};
param1='crossop';
cxid=fopen(strcat(expstring,param1,'.txt'));
cxread=textscan(cxid,repmat('%s',1,50));
cxop= cat(2,cxread{:})';
fclose(cxid);

figure(1)
plotNofOpsOverGens(nofmaxmetagens,cxop,cx_strings);
legend('alternate\_edges','cyclic','edge\_recombination','Location','east');

mu_strings = {'mu_insertion', 'mu_inversion', 'mu_reciprocal_exchange'};
param2='muop';
muid=fopen(strcat(expstring,param2,'.txt'));
muread= textscan(muid,repmat('%s',1,50));
muop=cat(2,muread{:})';
fclose(muid);

figure(2)
plotNofOpsOverGens(nofmaxmetagens,muop,mu_strings);
legend('insertion','inversion','reciprocal\_exchange');