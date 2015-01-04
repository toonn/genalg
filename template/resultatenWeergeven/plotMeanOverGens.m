function plotMeanOverGens(nofmaxmetagens, datacell)

hold all;
for data=datacell
    plot(1:nofmaxmetagens,mean(data{1}));
end
hold off;

end