function plotStdOverGens(nofmaxmetagens,cop,mup,elitcop2,mup2)
plot(1:nofmaxmetagens,std(cop),'b');
hold all;
plot(1:nofmaxmetagens,std(mup),'g');
if(exist('elitcop2','var'))
    plot(1:nofmaxmetagens,std(elitcop2),'r');
end
if(exist('mup2','var'))
    plot(1:nofmaxmetagens,std(mup2),'c');
end
hold off;