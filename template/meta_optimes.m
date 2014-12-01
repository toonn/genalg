crossover_operators = {@co_cross_alternate_edges,@co_cyclic_crossover,@co_edge_recombination_operator,@co_sequential_constructive_crossover};
mutation_operators = {@mu_insertion, @mu_inversion, @mu_reciprocal_exchange};

costs = [0.00212463420000000,0.000189217900000000,0.0130226124000000,...
         0.00110614230000000,...
         2.94919000000000e-05,3.42670000000000e-05, 2.99515000000000e-05];
coststd = [3.27108198261213e-05,8.07559051785820e-06,0.000141311430236177,...
           1.87838169040493e-05,...
           7.15825009652810e-07,6.06765726178273e-07, 5.08096815319063e-07];
     
keyset = {};
for op = crossover_operators
    keyset = [keyset func2str(op{1})];
end
for op = mutation_operators
    keyset = [keyset func2str(op{1})];
end

global optimes
optimes = containers.Map(keyset, costs, 'UniformValues', true);