global nofInts
nofInts=2;

%aantal individuen, maxgen, elitism, stopper, percross, cross1, cross2,
%cross3, cross4 (9), permut, mut1, mut2, mut3, selectionOp, perOsSel,
%osSelOp (16) 

possibleSels={@sus};
possibleOsSels={};

global limits
limits={100 20 1 1 1 1 1 1 1 1 1 1 1 possibleSels 0 possibleOsSels};

global mutFreqs
mutFreqs=num2cell(cumsum(ones(1,16)/16));
