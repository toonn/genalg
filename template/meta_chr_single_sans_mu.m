global nofInts
nofInts=2;

% Single Cx Mu
%aantal individuen, maxgen, elitism, stopper, percross, crossop,
%permut, mutop, selectionOp, perOsSel,
%osSelOp

nofparams = 11;

ninds = [1, 100];
ngens = [1, 20];
eliteper = [0, 1];
stopper = [0, 1];

crossprob = [0, 1];
cxops = {@co_cross_alternate_edges,...
         @co_cyclic_crossover,...
         @co_edge_recombination_operator,...
         @co_sequential_constructive_crossover};
mutprob = [0, 1];
%verwijder beste
muops = {@mu_insertion,...
         @mu_reciprocal_exchange};

possibleSels={@sus};
possibleOsSels={@offspring_selection};
osper = [0, 1];

global limits
limits = {ninds ngens eliteper stopper...
          crossprob cxops...
          mutprob muops...
          possibleSels osper possibleOsSels};
                   
global mutFreqs
mutFreqs=num2cell(cumsum(ones(1,nofparams)/nofparams));