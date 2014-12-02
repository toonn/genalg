%experiment moet een string zijn (sp, ap, cw of mw)
%seed, nofCities, nofmetainds, nofmawmetagens en alpha moeten getallen zijn
function experimentstring = getExperimentString(experiment, seed, nofCities, nofmetainds, nofmaxmetagens, alpha)
experiment=experiment; %Mogelijkheden: sp (maar 1 crossover en 1 mutation),
%ap (alle parameters), cw (beste crossover weg), mw (beste mutator weg)
seed=num2str(seed);
nofCities=num2str(nofCities);
nofmetainds=num2str(nofmetainds);
nofmaxmetagens=num2str(nofmaxmetagens);
alpha=num2str(alpha);
experimentstring=strcat('results/',experiment,'s',seed,'c',nofCities,'n',nofmetainds,'g',nofmaxmetagens,'a',alpha);
end