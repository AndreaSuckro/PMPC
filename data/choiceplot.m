function choiceplot(p,q,N)
% choiceplot(p,q,N)
%
% take a matrix of theoretical choice probabilities p and compare them to 
% empirical probabilities q where each q is based on N trials.
%

n = size(p,1);

select = logical(1-tril(ones(n)));
fit = p(select);
data = q(select);
clf
plot(fit,data,'b+')
for i = 1:n
  for j = i+1:n
    text(p(i,j),q(i,j),sprintf('%d,%d',i,j));
  end
end
hold on
plot([0 1],[0 1],'k:', 'linewidth', 2)

% and add two-sided 95% confidence intervals
r = linspace(0,1,100);
delta = norminv(0.975,0,1) * sqrt(r.*(1-r) / N);
plot(r,r+delta,'r','linewidth',2);
plot(r,r-delta,'r','linewidth',2);
set(gca,'ylim',[0,1])

xlabel('fitted')
ylabel('actual')  
