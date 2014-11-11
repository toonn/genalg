function child = co_cyclic_crossover(parent1, parent2, ~)

%     parent1=[1 2 3 4 5 6 7 8 9 10];
%     parent2=[3 6 7 1 8 2 4 9 5 10];

    parents=[parent1 ; parent2];
    N=size(parent1,2);
    child=zeros(1,N);

    i=rand(N);
    parent=randi(2);
    k=N+1;

    while(isempty(find(child==k)))
        child(i)=parents(parent,i)
        k=parents(mod(parent,2)+1,i)
        i=find(parents(parent,:)==k)
    end

    child(find(child==0))=parents(2,find(child==0))

end