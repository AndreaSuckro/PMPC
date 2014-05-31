% values for the experiment
numberTrials   = 25;
threshold      = 20;
numberSubjects = 1e6;

% generate trials for each subject, count the successes per subject
trials = sum(rand(numberSubjects, numberTrials) > 0.5, 2);

% plot a histogram
hist(trials);

% count how many are very good and what their proportion is
numHigh    = sum(trials > threshold);
proportion = numHigh / numberSubjects;

display([num2str(proportion*100) '% (' num2str(numHigh) ') of '...
         num2str(numberSubjects) ' subjects scored more than '...
         num2str(threshold) ' out of ' num2str(numberTrials) '.'])