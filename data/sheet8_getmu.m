% prepare q with "known" values
q = [0.5 0.75 0.345; 0.25 0.5 0.45; 0.655 0.55 0.5];
% calculate the inverse of the normal distribution and normalize it
P = norminv(q, 0, 1) * sqrt(2)
% extract the mu's
mu = P(:,1)'