experiment='sp';
seed=4;
nofCities=14;
nofmetainds=50;
nofmaxmetagens=20;
alpha=1;
expstring=getExperimentString(experiment,seed,nofCities,nofmetainds,nofmaxmetagens,alpha);

%%

param1='crossop';
cos=openFileWithStrs(strcat(expstring,param1,'.txt'));
param2='muop';
mus=openFileWithStrs(strcat(expstring,param2,'.txt'));

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

%Geeft welke combinatie van operators hoeveel keer voorkomt
frequenciesOfCombinations

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
plot(1:nofmaxmetagens,mean(cop),'b');
hold all;
plot(1:nofmaxmetagens,mean(mup),'g');
plot(1:nofmaxmetagens,mean(elit),'r');
hold off;
legend('cross_pr','mut_pr','elitism')
subplot(132)
plot(1:nofmaxmetagens,std(cop),'b');
hold all;
plot(1:nofmaxmetagens,std(mup),'g');
plot(1:nofmaxmetagens,std(elit),'r');
hold off;
legend('cross_pr_std','mut_pr_std','elitism_std')
subplot(133)
plot(1:nofmaxmetagens,min(F),'b')
hold all;
plot(1:nofmaxmetagens,min(D),'g')
hold off;
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




