data = load(['tsp_benchmark/' 'belgiumtour.tsp']);
x=data(:,1)/max([data(:,1);data(:,2)]);
y=data(:,2)/max([data(:,1);data(:,2)]);

% parameters -- ELITIST 0-20%, PR_CROSS 0-100%, PR_MUT 0-20%,
%               CROSSOVER, mutation
parameters = cartesianProduct({linspace(0,.1,2), ...
                                linspace(0,1,1), ...%5), ...
                                linspace(0,.2,3), ...
                                {@co_cross_alternate_edges}, ...
                                {@mu_inversion}});
%                 {@co_cross_alternate_edges, ...
%                     @co_edge_recombination_operator, ...
%                     @co_sequential_constructive_crossover}, ...
%                 {@mu_inversion, ...
%                     @mu_reciprocal_exchange}});
size(parameters, 1)

Fs = [];
p = gcp();
for pars = parameters'
    F = parfeval(p, @run_genalg, 1, x, y, 50, 100, ...
                    pars{1}, 0.2, ...
                    pars{2}, pars{3}, pars{4}, pars{5});
    Fs = [Fs F];
end

TourDistances = fetchOutputs(Fs)