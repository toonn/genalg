function ord = path2ord(path)
N=size(path,2);
ord=zeros(1,N);
list=[1:N];
for i=1:N
    ord(i)=list(path(i));
    list(path(i):end)=list(path(i):end)-1;    
end
end