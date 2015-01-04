experiment='ap';
seed=4;
nofCities=16;
nofmetainds=50;
nofmaxmetagens=50;
alpha=0.02;
expstring=getExperimentString(experiment,seed,nofCities,nofmetainds,nofmaxmetagens,alpha);

%%
param1='crossprob';
cop=load(strcat(expstring,param1,'.txt'));
param2='cross_alternate_edges';
cx_alt_edge=load(strcat(expstring,param2,'.txt'));
param3='cross_cyclic';
cx_cyclic=load(strcat(expstring,param3,'.txt'));
param4='cross_edge_recombination';
cx_edge_recomb=load(strcat(expstring,param4,'.txt'));
param5='cross_seq_const';
cx_seq_const=load(strcat(expstring,param5,'.txt'));
figure(1)
plotMeanOverGens(nofmaxmetagens,{cop,cx_alt_edge,cx_cyclic,cx_edge_recomb,cx_seq_const})
legend('cross\_pr','alternate\_edges','cyclic','edge\_recombination','seq\_const', 'Location', 'northwest')

param1='muprob';
mup=load(strcat(expstring,param1,'.txt'));
param2='mut_insertion';
mu_insertion=load(strcat(expstring,param2,'.txt'));
param3='mut_inversion';
mu_inversion=load(strcat(expstring,param3,'.txt'));
param4='mut_reciprocal_exchange';
mu_recip=load(strcat(expstring,param4,'.txt'));

figure(2)
plotMeanOverGens(nofmaxmetagens,{mup,mu_insertion,mu_inversion,mu_recip})
legend('mut\_pr','insertion','inversion','reciprocal\_exchange', 'Location', 'northwest')


param1='fitness';
F=load(strcat(expstring,param1,'.txt'));
param2='distance';
D=load(strcat(expstring,param2,'.txt'));
figure(3)
plotMinOverGens(nofmaxmetagens,F,D)
legend('minimale fitness','minimale distance')





