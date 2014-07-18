function [negloglik p] = thurstone(mu,k)
% [negloglik p] = thurstone(mu,k)
% 
% returns the negative log likelihood and the choice probabilities for 
% feature utilities mu. k is the number of choices for each pair where rows 
% are chosen over columns.
% 

% do a few checks, mu is a column vector
n = length(mu); % number of objects
if all(size(mu)==[1,n])
   mu = mu';
end
if not(all(size(k)==[n,n]))
   error('k has to be n by n')
end

% calculate the difference in mean utility for each pair
d = (repmat(mu,1,n)-repmat(mu',n,1));

% and translate this to choice probabilities
p = normcdf(d,0,sqrt(2));

% finally, calculate the negative log likelihood
L = k .* log(p);
negloglik = -sum(L(:));

