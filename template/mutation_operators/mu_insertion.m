function newChrom = mu_insertion(oldChrom, Representation)
if Representation==1 
	oldChrom=adj2path(oldChrom);
end

newChrom=oldChrom;
N=size(oldChrom,2);
oldPos=randi(N);
newPos=randi(N-1);
if(newPos==oldPos)
    newPos=N;
end

if(oldPos<newPos)
    newChrom(oldPos:newPos)=newChrom([oldPos+1:newPos oldPos]);
else
    newChrom([oldPos:N 1:newPos])=newChrom([oldPos+1:N 1 2:newPos oldPos]);
end

if Representation==1 
	newChrom=path2adj(newChrom);
end
end