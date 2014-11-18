function children = co_edge_recombination_operator(parent1, parent2, ~)

N=size(parent1,2);

child=zeros(1,N);
children=zeros(2,N);

connectedCities_backup=zeros(N,4);

for i=1:N
    connectedCities_backup(parent1(i),1:2)=[parent1(mod(i,N)+1) parent1(mod(i-2,N)+1)];
    connectedCities_backup(parent2(i),3:4)=[parent2(mod(i,N)+1) parent2(mod(i-2,N)+1)];
end

for i=1:N
    connectedCities_backup(i,:)=[unique(connectedCities_backup(i,:),'first') zeros(1,4-size(unique(connectedCities_backup(i,:),'first'),2))];
end
connectedCities_backup;
%je moet met een random positie beginnen aangezien het op de beginpositie
%is dat een nieuwe edge zal worden geïntroduceerd normaal gezien
for j=1:2
    connectedCities=connectedCities_backup;
    list=1:N;
    p=randi(N);
    child(1)=p;
    list(find(list==p))=0;
    for i=2:N
        connectedCities(find(connectedCities==p))=0;
        possibleNewCities=connectedCities(p,find(connectedCities(p,:)));
        if(isempty(possibleNewCities))
            p=list(datasample(find(list),1));
        else
            p=possibleNewCities(1);
        end
        for j=2:size(possibleNewCities,2)
            k=possibleNewCities(j);
            if(size(find(connectedCities(k,:)),2)<=size(find(connectedCities(p,:)),2))
                if(size(find(connectedCities(k,:),2),2)==size(find(connectedCities(p,:)),2))
                    if(rand>0.5)
                        p=k;
                    end
                else
                    p=k;
                end
            end
        end
        child(i)=p;
        list(find(list==p))=0;
    end
    children(j,:)=child;
end

end