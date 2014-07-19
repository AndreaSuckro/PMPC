function [negloglik p] = restle(logmu,F,k)
% [negloglik p] = restle(logmu,F,k)
% 
% returns the negative log likelihood and the choice probabilities for 
% log feature utilities logmu and feature matrix F. F has objects in the rows 
% and features as columns. k is the number of choices for each pair where rows 
% are chosen over columns.
% 

n = size(F,1); % number of objects
m = size(F,2); % number of features
p = zeros(n,n);% choice probabilities

mu = exp(logmu);

% do a few checks
if all(size(mu)==[1,m])
   mu = mu';
end
if not(all(size(mu)==[m,1]))
   error('mu and F have to agree in dimensions')
end
if not(all(size(k)==[n,n]))
   error('k has to be n by n')
end

% now calculate the nominator in Restle's model for each pair
for i = 1:n
  for j = 1:n
    p(i,j) = (F(i,:)-F(i,:).*F(j,:)) * mu;
  end
end

% and normalize choice probabilities so that p+p'=1
p = p ./ (p+p');
% by definition the diagonal contains only zeros
p(eye(n)>0) = 0.5;

% finally, calculate the negative log likelihood
L = k .* log(p);
negloglik = -sum(L(:));

