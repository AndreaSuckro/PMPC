% sample size
x = 0:0.001:1;

% alpha/beta prior from sheet, derived posterior values
alphaPrior = 1; alphaPosterior = 231;
betaPrior  = 9; betaPosterior  = 279;

% distributions
yPriorPDF     = betapdf(x,alphaPrior,betaPrior);
yPosteriorPDF = betapdf(x,alphaPosterior,betaPosterior);
yPosteriorCDF = betacdf(x,alphaPosterior,betaPosterior);

% 95 % threshold
yHigh(1:size(x,2)) = 0.975;
yLow(1:size(x,2)) = 0.025;

% epsilon threshold
epsilon = size(x,2)/1000;

% find intersection x-indices for the 95% interval
intersectionHigh = ceil(betainv(yHigh(1), alphaPosterior, betaPosterior)...
                        * size(x,2));
intersectionLow  = ceil(betainv(yLow(1),  alphaPosterior, betaPosterior)...
                        * size(x,2));
subplot(2,2,1);
    % plot prior
    plot(x, yPriorPDF);
    title(['Prior PDF, \alpha = ' num2str(alphaPrior)...
           ', \beta = ' num2str(betaPrior)]);
subplot(2,2,3);
    hold on;    
    % plot posterior cdf
    plot(x, yPosteriorCDF);
    % plot 95% lines
    plot(x, yHigh, '-r');
    plot(x, yLow, '-r');
    % mark intersections
    plot(x(intersectionHigh), yPosteriorCDF(intersectionHigh), 'og');
    plot(x(intersectionLow), yPosteriorCDF(intersectionLow), 'og');
    title(['Posterior CDF with 95 % intersections, \alpha = '...
           num2str(alphaPosterior) ', \beta = ' num2str(betaPosterior)]);
    hold off;
subplot(2,2,[2 4]);
    hold on;
    % find indices for 95% interval
    indexHigh = find(x - x(intersectionHigh) < epsilon...
                   & x - x(intersectionHigh) > 0, 1);
    indexLow  = find(x - x(intersectionLow)  < epsilon...
                   & x - x(intersectionLow) > 0, 1);
    
    % draw area below the pdf
    for i = indexLow : floor(size(x,2)/100) : indexHigh
        plot([x(i) x(i)], [0 yPosteriorPDF(i)], '-y');
    end    
    % draw borders of the area
    plot([x(indexLow)  x(indexLow)],  [0 yPosteriorPDF(indexLow)],  '-r');
    plot([x(indexHigh) x(indexHigh)], [0 yPosteriorPDF(indexHigh)], '-r');
    
    % plot pdf
    plot(x, yPosteriorPDF);
    title(['Posterior PDF with 95 % interval, \alpha = '...
           num2str(alphaPosterior) ', \beta = ' num2str(betaPosterior)]);
    hold off;