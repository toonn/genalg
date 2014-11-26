global nofInts
nofInts=2;

%aantal individuen, maxgen, elitism, stopper, percross, cross1, cross2,
%cross3, cross4 (9), permut, mut1, mut2, mut3, selectionOp, perOsSel,
%osSelOp (16) 

possibleSels={@sus};
possibleOsSels={};

cross = [0, 1];
mut = [0, 1];
global limits
limits={[1, 100] [1, 20] [0, 1] [0, 1]...
        [0, 1] cross cross cross cross...
        [0, 1] mut mut mut...
        possibleSels [0, 0] possibleOsSels};

global mutFreqs
mutFreqs=num2cell(cumsum(ones(1,16)/16));
