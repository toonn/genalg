experiment='asp';
seed=4;
nofCities=16;
nofmetainds=50;%50 50 50
nofmaxmetagens=50;%50 20 50
alpha=0.02;%0.02 1 1
expstring=getExperimentString(experiment,seed,nofCities,nofmetainds,nofmaxmetagens,alpha);

%%
param1='crossop';
param2='muop';
cos=openFileWithStrs(strcat(expstring,param1,'.txt'));
mus=openFileWithStrs(strcat(expstring,param2,'.txt'));
frequencies = checkCombinationOfOperators(cos, mus, nofmetainds, nofmaxmetagens)

param1='crossop2';
param2='muop2';
cos=openFileWithStrs(strcat(expstring,param1,'.txt'));
mus=openFileWithStrs(strcat(expstring,param2,'.txt'));
frequencies2 = checkCombinationOfOperators(cos, mus, nofmetainds, nofmaxmetagens)

%%
param1='crossprob';
cop=load(strcat(expstring,param1,'.txt'));
param2='muprob';
mup=load(strcat(expstring,param2,'.txt'));
param3='elitist';
elit=load(strcat(expstring,param3,'.txt'));
param4='fitness';
F=load(strcat(expstring,param4,'.txt'));
param5='distance';
D=load(strcat(expstring,param5,'.txt'));
param6='crossprob2';
cop2=load(strcat(expstring,param6,'.txt'));
param7='muprob2';
mup2=load(strcat(expstring,param7,'.txt'));

figure(1)
subplot(131)
plotMeanOverGens(nofmaxmetagens,cop,mup,cop2,mup2)
legend('cross\_pr','mut\_pr','cop2\_pr','mup2\_pr')
subplot(132)
plotStdOverGens(nofmaxmetagens,cop,mup,cop2,mup2)
legend('cross\_pr\_std','mut\_pr\_std','cop2\_pr\_std','mup2\_pr\_std')
subplot(133)
plotMinOverGens(nofmaxmetagens,F,D)
legend('minimale fitness','minimale distance')

