[train,tune,test,dataDim] = getFederalistData;

% Question 1 - work with training set

for mu = [0, 0.001, 0.01, 0.1, 1, 10 , 100]
    
    [w,gamma,obj] = separatelp(train,2:71,mu);
    normw = norm(w,1);
    fprintf('Mu value = %f \n',mu);
    fprintf('Optimal LP objective = %f \n',obj);
    fprintf('Gamma = %f \nFirst norm of w (after post processing) = %f \n', gamma, normw);
    fprintf('Number of non zero elements in w (after post processing) = %f\n',nnz(w));
    
    [correct,wrong] = discrim(w,gamma,train,[2:71]);
    fprintf('Number of misclassified points (wrong side of hyperplane) from training set = %f \n',wrong);
    [correct,wrong] = discrim(w,gamma,tune,[2:71]);
    fprintf('Number of misclassified points (wrong side of hyperplane) from tuning set = %f \n',wrong);
    
    predict(w,gamma,test,1:70);
    fprintf('-------------------------------------------------------------------------------------------\n');
end

%Question 3
mu = 0.01;
leastwrong =  size(tune,1); % 20
for i=2:71
    for j=i+1:71
        [w,gamma,obj] = separatelp(train,[i,j],mu);
        [correct,wrong] = discrim(w,gamma,tune,[i,j]);
        if wrong <= leastwrong
            leastwrong = wrong;
            besti = i;
            bestj = j;
            fprintf('atts %2d %2d: missclass %d : objective = %f : norm1 %f \n',i-1,j-1,wrong,obj,norm(w,1));
        end
    end
end

%Question 4
clf
[w,gamma,obj] = separatelp(train,[besti,bestj],mu);
predict(w,gamma,test,[besti-1,bestj-1]);
load federalData;
wordlist(besti-1);
wordlist(bestj-1);
fprintf('Words %s %s \n',wordlist{besti-1},wordlist{bestj-1});
hold on
gscatter(data(:,besti),data(:,bestj),data(:,1),[],'o+*')
xaxis = 0:45;
yaxis = (-w(1) * xaxis + gamma)/w(2);
plot(xaxis,yaxis)
xlabel(wordlist{besti-1})
ylabel(wordlist{bestj-1})
hold off













    