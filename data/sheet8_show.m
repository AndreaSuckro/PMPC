load celebrities.txt
c = celebrities;

% empirical probabilities
q = c./234;

% estimates for differences
d = sqrt(2) * norminv(q,0,1);

% estimates for the means
mu = mean(d,2);

% fitted probabilities:
p = normcdf((repmat(mu,1,9)-repmat(mu',9,1))/sqrt(2),0,1);

% plot data versus predictions
figure(1)
choiceplot(p,q,234)
title('Thurstone with least squares')

% now do the same for a ml fit
c = celebrities;
negloglik = @(mu) thurstone(mu,c); 
muml = zeros(9,1);

% OPTIMIZATION IN OCTAVE:
% muml = fminunc(negloglik,muml);

% OPTIMIZATION IN MATLAB:
o = optimset; % make sure we have sufficient precision in matlab
o.MaxFunEvals = 100000;
o.MaxIter = 100000;
o.TolX = 10^-8;
o.TolFun = 10^-8;
[muml,fval,exitflag,output] = fminsearch(negloglik,muml);

% plot data versus predictions
figure(2)
choiceplot(p,q,234)
title('Thurstone ML fit')

% compare the estimates of least square and ml fit
muml = muml-mean(muml); % subtract mean as for lsq fit
[negloglik,p] = thurstone(mu,c);
[negloglikml,p] = thurstone(muml,c);
fprintf('\n')
fprintf('Thurstonian Scaling\n')
fprintf('-----------------------------------------------------------------\n')
fprintf('      LJ1   HW2   CD3   JH4   CY5   AF6   BB7   ET8   SL9 NLL\n')
fprintf('lsq ')
fprintf('%+5.2f ', mu')
fprintf('%7.2f\n', negloglik)
fprintf('ml  ')
fprintf('%+5.2f ', muml')
fprintf('%7.2f\n', negloglikml)
fprintf('-----------------------------------------------------------------\n\n')

% now identify the cases that violate strong stochastic transitivity. If there
% are many violations this will be an indication that the assumption of s.s.t.
% does not hold for the data and therefore fitting a Thurstonian model was not
% the right thing to do.
fprintf('\n')
fprintf('Violations of strong stochastic transitivity\n')
fprintf('-----------------------------------------------------------------\n')
fprintf('a b c | q(a,b)         q(b,c)         q(a,c)\n')
fprintf('-----------------------------------------------------------------\n')
for a = 1:9
  for b = 1:9
    for c = 1:9
       if (q(a,b)>0.5) && (q(b,c)>0.5)
          if not(q(a,c)>q(a,b) & q(a,c)>q(b,c))
             % check whether the violation is significant:
             % assuming that q(a,c) was exact we can check how far the
             % other two are away from q(a,c) and whether one of them is
             % significantly bigger. This is just a quick hack but should
             % give you some idea as to which differences are relatively
             % big:
             s = sqrt(q(a,c)*(1-q(a,c))/234);
             d1 = (q(a,b)-q(a,c))/s;
             d2 = (q(b,c)-q(a,c))/s; 
             sig = '';
             if (d1 > norminv(0.95,0,1)) || (d2 > norminv(0.95,0,1))
                 sig = '*';
                 if (d1 > norminv(0.99,0,1)) || (d2 > norminv(0.99,0,1))
                     sig = '**';
                 end
	     end
             fprintf(['%d %d %d | '...
                      '  %.2f (%+1.2f)   %.2f (%+1.2f)   %.2f %s\n'],...
                     a,b,c,q(a,b),d1,q(b,c),d2,q(a,c),sig);
          end
       end
    end
  end
end
fprintf('-----------------------------------------------------------------\n\n')

% fit Restle's model to the same data but add features for 3 clusters
F = [eye(9); 1 1 1 0 0 0 0 0 0; 0 0 0 1 1 1 0 0 0; 0 0 0 0 0 0 1 1 1]';
logmu = ones(1,12)'; % as mu has to be positive, we optimize the log of mu
c = celebrities;
negloglik = @(logmu) restle(logmu,F,c); 

% OPTIMIZATION IN OCTAVE
% logmu = fminunc(negloglik,logmu); 

% OPTIMIZATION IN MATLAB
o = optimset;
o.MaxFunEvals = 100000;
o.MaxIter = 100000;
o.TolX = 10^-8;
o.TolFun = 10^-8;
[logmu,fval,exitflag,output] = fminsearch(negloglik,logmu,o); 

[negloglik,p] = restle(logmu,F,c);
mu = exp(logmu);      % the actual mu's are only positive
mu = mu./sum(mu)*100; % and the scale is arbitrary

fprintf('\n')
fprintf('Restle''s Choice Model\n')
fprintf('-----------------------------------------------------------------\n')
fprintf(' LJ1  HW2  CD3  JH4  CY5  AF6  BB7  ET8  SL9 POLI SPOR ACTO NLL\n')
fprintf('%4.1f ', mu')
fprintf('%4.0f\n', negloglik)
fprintf('-----------------------------------------------------------------\n')

% now make a plot for Restle's model
figure(3)
choiceplot(p,q,234)
title('Restle')
