noftests=100;
nofrunspertest=100;
N=100;

rng(2)

x=rand(N,1);
y=rand(N,1);

dist=sqrt((x*ones(1,N)-(x*ones(1,N))').^2+(y*ones(1,N)-(y*ones(1,N))').^2);

chr1=path2adj(randperm(N));
chr2=path2adj(randperm(N));

crossover_operators = {@co_cross_alternate_edges,@co_cyclic_crossover,@co_edge_recombination_operator,@co_sequential_constructive_crossover};
mutation_operators = {@mu_insertion, @mu_inversion, @mu_reciprocal_exchange};

crosscosts=zeros(noftests,size(crossover_operators,2));
mutcosts=zeros(noftests,size(mutation_operators,2));
for i=1:noftests
    for j=1:size(crossover_operators,2)
        tic
        for k=1:nofrunspertest
            crossover_operators{j}(chr1,chr2,dist);
        end
        crosscosts(i,j)= toc / nofrunspertest;
    end
    for j=1:size(mutation_operators,2)
        tic
        for k=1:nofrunspertest
            mutation_operators{j}(chr1,1);
        end
        mutcosts(i,j)= toc / nofrunspertest;
    end
end


assert(noftests>1,'anders loopt die mean mis af');
costs=mean([crosscosts mutcosts])
coststd=std([crosscosts mutcosts])

%costs: 1.8241    2.1820    4.6942    2.4366    0.0184    0.0264    0.0283
%coststd: 0.3039    0.2135    1.0029    0.3749    0.0029    0.0035    0.0040


