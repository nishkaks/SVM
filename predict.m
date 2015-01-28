function predict(w,gamma,dataMatrix,features)
% syntax: predict(w,gamma,dataMatrix,features)
% predicts the authorship of the 12 disputed papers

result = w' * dataMatrix(:,features)' - gamma;
fprintf('Paper number, Predicted author, margin \n')
fprintf('---------------------------------------\n')
for i=1:size(result,2)    
    if result(1,i) > 0
        fprintf('Paper %f , 2 , margin = %f \n',i,result(1,i));
    elseif result(1,i) <= 0
        fprintf('Paper %f , 1 , margin = %f \n',i,result(1,i));
    end
end
return;
