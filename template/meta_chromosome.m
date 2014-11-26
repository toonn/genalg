global nofInts
nofInts=2;

%aantal individuen, maxgen, elitism, stopper, percross, cross1, cross2,
%cross3, cross4 (9), permut, mut1, mut2, mut3, selectionOp, perOsSel,
%osSelOp (16)

nofparams = 16;

ninds = [1, 100];
ngens = [1, 20];
eliteper = [0, 1];
stopper = [0, 1];

crossprob = [0, 1];
cross = [0, 1];
mutprob = [0, 1];
mut = [0, 1];

possibleSels={@sus};
possibleOsSels={};

global limits
limits={ninds ngens eliteper stopper...
        crossprob cross cross cross cross...
        mutprob mut mut mut...
        possibleSels [0, 0] possibleOsSels};

global mutFreqs
mutFreqs=num2cell(cumsum(ones(1,nofparams)/nofparams));
