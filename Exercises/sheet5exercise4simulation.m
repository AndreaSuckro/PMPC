clc; clear all; close all;
x = 0:0.001:1;
alpha = 1;
beta = 1;
n = 25;
k = 5;
binomialFactor = nchoosek(n,k);

for i = 1:1000
    alpha = alpha + n;
    beta  = beta + n - k;
end

%plot(x, betapdf(x,alpha,beta));
disp(['Alpha ' num2str(alpha) '; Beta ' num2str(beta)]);
csvwrite('beta.txt', [x' betapdf(x,alpha,beta)']);