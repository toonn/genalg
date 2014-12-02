function data=openFileWithStrs(name)
fID=fopen(name,'r');
tline = fgetl(fID);
data={};
while ischar(tline)
    data=[data ; strsplit('	',tline)];
    tline = fgetl(fID);
end
data=data(:,1:end-1);
fclose(fID);
end