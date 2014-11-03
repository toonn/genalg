g=10;
sigma=linspace(1,5,5);
k2=[1 linspace(5,30,6)];
omega2_0=[-100];
modes=linspace(0,10,11);

width=size(omega2_0,2)*size(modes,2)*size(sigma,2)*size(g,2)*size(k2,2)

m=width;
m=[repmat(m,[1 size(g,2)]) ; g];
m=[repmat(m,[1 size(sigma,2)]) ; reshape(repmat(sigma,[size(m,2) 1]),[1 size(m,2)*size(sigma,2)])]
m=[repmat(m,[1 size(k2,2)]) ; reshape(repmat(k2,[size(m,2) 1]),[1 size(m,2)*size(k2,2)])]
m=[repmat(m,[1 size(omega2_0,2)]) ; reshape(repmat(omega2_0,[size(m,2) 1]),[1 size(m,2)*size(omega2_0,2)])]
m=[repmat(m,[1 size(modes,2)]) ; reshape(repmat(modes,[size(m,2) 1]),[1 size(m,2)*size(modes,2)])]



% break
% m=repmat(g,[1 width/size(g,2)])
% m=[m ; reshape(repmat(sigma,[width/size(sigma,2) 1]),[1 width])]
% 
% 
% 
% 
% m=[ones(1,60) ; ones(1,60)*(-100) ; repmat(linspace(0,4,5),12)


dlmwrite('testspkg.in',m,'\t');