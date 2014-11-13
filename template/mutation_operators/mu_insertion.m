function newChrom = mu_insertion(oldChrom)
newChrom=oldChrom;
N=size(parent,2);
oldPos=randi(N);
newPos=randi(N-1);
if(newPos==oldPos)
    newPos=N;
end

if(oldPos<newPos)
    newChrom(oldPos:newPos)=newChrom([oldpos+1:newPos oldpos]);
else
    newChrom([oldPos:N 1:newPos])=newChrom([oldPos+1:N 1 2:newPos oldPos]);
end

end