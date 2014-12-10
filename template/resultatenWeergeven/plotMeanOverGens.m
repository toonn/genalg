function plotMeanOverGens(nofmaxmetagens,cop,mup,elitcop2,mup2)

plot(1:nofmaxmetagens,mean(cop),'b');
hold all;
plot(1:nofmaxmetagens,mean(mup),'g');
if(exist('elitcop2','var'))
    plot(1:nofmaxmetagens,mean(elitcop2),'r');
end
if(exist('mup2','var'))
    plot(1:nofmaxmetagens,mean(mup2),'c');
end
hold off;

end