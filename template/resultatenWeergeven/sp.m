experiment='sp';
seed=4;
nofCities=14;
nofmetainds=50;
nofmaxmetagens=20;
alpha=1;
expstring=getExperimentString(experiment,seed,nofCities,nofmetainds,nofmaxmetagens,alpha);

%%

param1='crossop';
param2='muop';
cos=openFileWithStrs(strcat(expstring,param1,'.txt'));
mus=openFileWithStrs(strcat(expstring,param2,'.txt'));

%Geeft welke combinatie van operators hoeveel keer voorkomt
frequenciesOfCombinations = checkCombinationOfOperators(cos,mus,nofmetainds,nofmaxmetagens)

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

figure(1)
subplot(131)
plotMeanOverGens(nofmaxmetagens,cop,mup,elit)
legend('cross_pr','mut_pr','elitism')
subplot(132)
plotStdOverGens(nofmaxmetagens,cop,mup,elit)
legend('cross_pr_std','mut_pr_std','elitism_std')
subplot(133)
plotMinOverGens(nofmaxmetagens,F,D)
legend('minimale fitness','minimale distance')


%%
param1='muop';
mus=openFileWithStrs(strcat(expstring,param1,'.txt'));
param2='muprob';
mup=load(strcat(expstring,param2,'.txt'));

figure(2)
musToCheck = {'mu_insertion',...
         'mu_inversion',...
         'mu_reciprocal_exchange'};
musnof = changeStringsToNumbers(mus,musToCheck);
for n=1:size(musToCheck,2)
    nof(n)=size(find(musnof(:,end)==n),1);
    means(n)=mean(mup(find(musnof(:,end)==n),end));
    stds(n)=std(mup(find(musnof(:,end)==n),end));
end




