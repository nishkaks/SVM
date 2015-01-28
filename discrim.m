function [correct,wrong] = discrim(w,gamma,dataMatrix,features)
% syntax: [correct,wrong] = discrim(w,gamma,dataMatrix,features)
% correct - stores the number of correctly predicted papers
% wrong   - stores the number of wrongly predicted papers

result = w' * dataMatrix(:,features)' - gamma;
labels = dataMatrix(:,1);
result(result>0) = 2; % madison paper
result(result<=0) = 1; % hamilton paper
correct = sum(result'==labels);
wrong   = sum(result'~=labels);
return;
