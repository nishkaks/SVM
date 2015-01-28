function [w,gamma,obj] = separatelp(train,features,mu)
% syntax: [w,gamma,obj,misclass] = separatelp(dataMatrix,features,mu)

%Problem formulation
labels = train(:,1);
H = train(labels==1,features);
M = train(labels==2,features);
[mrow,mcol] = size(M); % [42,70]
[hrow,hcol]= size(H);  % [44,70]
A = [M -M -ones(mrow,1) eye(mrow,mrow) zeros(mrow,hrow);
     -H H  ones(hrow,1) zeros(hrow,mrow) eye(hrow,hrow)];

b = [ones(mrow,1);
     ones(hrow,1)]; 

xsize = mcol + mcol + 1 + mrow + hrow; % 227

Q = zeros(xsize,xsize);


lb = [zeros(1,mcol) zeros(1,mcol) -inf zeros(1,mrow) zeros(1,hrow)];
ub = inf(1,xsize);
le = [];
ge = 1:mrow+hrow;

c = [mu * ones(mcol,1);
    mu * ones(mcol,1);
    0;
    (1/mrow) * ones(mrow,1);
    (1/hrow) * ones(hrow,1)];


[obj,x] = cplexqp(c,A,b,Q,lb,ub,le,ge);

w = x(1:mcol) - x(mcol+1:mcol+mcol); % wplus - wminus;
normw = norm(w,1);
w(abs(w)<= 10^-6 * max(normw,1) ) = 0;
gamma = x(mcol + mcol + 1);
return

