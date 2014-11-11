function path = ord2path(ord)
N=size(ord,2);
path=zeros(1,N);
list=[1:7];
for i=1:N
    path(i)=list(ord(i));
    list(ord(i):N-1)=list(ord(i)+1:N);
end
end