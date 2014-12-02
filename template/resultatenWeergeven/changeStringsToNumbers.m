function snof = changeStringsToNumbers(s,list)
snof=zeros(size(s));
for i=1:size(s,1)
    for j=1:size(s,2)
        for n=1:size(list,2)
           if(size(s{i,j})==size(list{n}))
               if(s{i,j}==list{n})
                   snof(i,j)=n;
               end
           end
        end
    end
end