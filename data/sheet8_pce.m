% create the three mu's
mu = [1 1.5 2.5]';

% calculate their distance matrix
M = repmat(mu, 1, 3);
D = M - M'
% result:
%D =      0   -0.5000   -1.5000
%    0.5000         0   -1.0000
%    1.5000    1.0000         0

% calculate the probability for each choice
P = normcdf(D / sqrt(2), 0, 1)
% result:
%P = 0.5000    0.3618    0.1444
%    0.6382    0.5000    0.2398
%    0.8556    0.7602    0.5000

probability = P(2,1) * P(3,2) * P(1,3)
% result:
%probability = 0.0701