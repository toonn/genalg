%Mijn bedenking hierbij: je begint steeds bij 1; daardoor leg je in feite
%op dat de eerste node sowieso de beste van zijn twee mogelijke edges
%krijgt, voor andere nodes is daar geen zekerheid over
%Waarom zou je niet gewoon random nemen in plaats van de eerste uit de
%lijst?


%Expected representation: path
function children = co_sequential_constructive_crossover(parent1, parent2, costMatrix, ~)
% costMatrix=[999 75  99  9   35  63  8 ;
%             51  999 86  46  88  29  20;
%             100 5   999 16  28  35  28;
%             20  45  11  999 59  53  49;
%             86  63  33  65  999 76  72;
%             36  53  89  31  21  999 52;
%             58  31  43  67  52  60  999];
% 
% parent1=[1 5 7 3 6 4 2];
% parent2=[1 6 2 4 3 5 7];

parents=[parent1 ; parent2]';
N=size(parent1,2);
children=zeros(2,N);

for j=1:2
    list=[0 2:N];
    p=j;
    child=[1 zeros(1,N-1)];
    for i=2:N
        subsequentNodes=parents(mod(find(parents==p),N)+[1 ; N+1]);
        
        if(isempty(find(list==subsequentNodes(1))))
            subsequentNodes(1)=find(list,1);
        end

        if(isempty(find(list==subsequentNodes(2))))
            subsequentNodes(2)=find(list,1);
        end

        cp1=costMatrix(p,subsequentNodes(1));
        cp2=costMatrix(p,subsequentNodes(2));

        if(subsequentNodes(1)==subsequentNodes(2) || cp1<cp2)
            child(i)=subsequentNodes(1);
        else
            if(cp1>cp2)
                child(i)=subsequentNodes(2);
            else
                nextNode=subsequentNodes(round(rand));
                child(i)=nextNode;
            end
        end 
        list(child(i))=0;
        p=child(i);
    end
    children(j,:)=child;
end
    
end