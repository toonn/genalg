function plotMinOverGens(nofmaxmetagens,F,D)

plot(1:nofmaxmetagens,min(F),'b')
hold all;
plot(1:nofmaxmetagens,min(D),'g')
hold off;

end