function [] = plotNofOpsOverGens( nofmaxmetagens, ops, opstrings )

occurences = [];
for op=opstrings
    occurences = [occurences, sum(cellfun(@(str) strcmp(str,op{1}), ops),2)];
end

hold all;
for ix=1:size(occurences,2)
    plot(1:nofmaxmetagens,occurences(:,ix));
end
hold off;

end

