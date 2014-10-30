%pathRepresentation
%geeft een matrix met in de eerste twee kolommen de edges die gelijk zijn
%(in de richting van path1) de derde kolom geeft aan of de edge in path1 en
%path2 in dezelfde richting werd doorlopen of niet
function [overlap] = overlap(ncities, path1, path2)
for i=1:ncities
    j=find(path2==path1(i));
    if(path2(mod(j+1-1,ncities)+1)==path1(mod(i+1-1,ncities)+1))
        overlap=[overlap; [path1(i),path1(mod(i+1-1,ncities)+1),1]];
    end
    if(path2(mod(j+ncities-1-1,ncities)+1))==path1(mod(i+ncities-1-1,ncities)+1)))
        overlap=[overlap; [path1(mod(i+ncities-1-1,ncities)+1),path1(i),1]];
    end
    if(path2(mod(j+ncities-1-1,ncities)+1))==path1(mod(i+1-1,ncities)+1))
        overlap=[overlap; [path1(i),path1(mod(i+1-1,ncities)+1),-1]];
        
    end
    if(path2(mod(j+1-1,ncities)+1)==path1(mod(i+ncities-1-1,ncities)+1)))
        overlap=[overlap; [path1(mod(i+ncities-1-1,ncities)+1),path1(i),-1]];
    end
end
end