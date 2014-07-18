% probabilities for each event
P = normcdf(( repmat([1 1.5 2.5]', 1, 3)...
             -repmat([1 1.5 2.5]', 1, 3)') / sqrt(2), 0, 1);

% play around with m and n to see that many subjects is better than many
% trials with fewer subjects
m = 10;   % number of subjects
n = 1000; % number of trials with m subjects
violation = zeros(n, 1); % we also save when the violations occured

for t = 1:n % for each trial
    q21 = mean(rand(1, m) < P(2, 1)); % generate randomly how many persons
    q32 = mean(rand(1, m) < P(3, 2)); % prefer a choice over the other and
    q31 = mean(rand(1, m) < P(3, 1)); % take the mean over this boolean 
                                      % vector to achieve a probability
    
    if q21 >= .5 && q32 >= .5         % check premise for s-s-t
        if q31 >= max(q21, q32)       % if the conclusion does hold: noop
        else                          % else
            violation(t) = 1;         % save the violation
        end
    end
end
probability = sum(violation)/n
% result: (for example)
%probability = 0.226