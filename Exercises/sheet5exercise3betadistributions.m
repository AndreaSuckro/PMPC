close all; clear; clc;
x = linspace(0, 1, 1000);             % samples

alphaPrior = 1; alphaPosterior = 231; % prior/posterior alpha/beta
betaPrior  = 9; betaPosterior  = 279; % from sheet and calculated

yPriorPDF     = betapdf(x, alphaPrior,     betaPrior);
yPosteriorPDF = betapdf(x, alphaPosterior, betaPosterior);
yPosteriorCDF = betacdf(x, alphaPosterior, betaPosterior);

yLow  = 0.025;                                         % 95 % threshold
yHigh = 0.975;
xLow  = betainv(yLow,  alphaPosterior, betaPosterior); % corresponding x
xHigh = betainv(yHigh, alphaPosterior, betaPosterior);

subplot(2, 2, 1);
    plot(x, yPriorPDF);               % plot prior
    title(['Prior PDF, \alpha = ' num2str(alphaPrior)...
           ', \beta = ' num2str(betaPrior)]);
subplot(2, 2, 3);
    hold on;    
    plot(x, yPosteriorCDF);           % plot posterior cdf
    plot(xlim, [yHigh yHigh], 'r');   % plot 95% lines and intersections
    plot(xlim, [yLow  yLow],  'r');
    plot(xHigh, yHigh, 'og');
    plot(xLow,  yLow,  'og');
    title(['Posterior CDF with 95 % intersections, \alpha = '...
           num2str(alphaPosterior) ', \beta = ' num2str(betaPosterior)]);
    hold off;
subplot(2, 2, [2 4]);
    hold on;
    for i = linspace(xLow, xHigh, 100)  % plot area
        plot([i i], [0 betapdf(i, alphaPosterior, betaPosterior)], 'r');
    end    
    
    plot(x, yPosteriorPDF);           % plot pdf
    title(['Posterior PDF with 95 % interval, \alpha = '...
           num2str(alphaPosterior) ', \beta = ' num2str(betaPosterior)]);
    hold off;

clear i;

% save data to csv
%csvwrite('output/priorPDF.txt',[x' yPriorPDF']);
%csvwrite('output/posteriorPDF.txt',[x' yPosteriorPDF']);
%csvwrite('output/posteriorPDFArea.txt',[linspace(xLow, xHigh, 100)' betapdf(linspace(xLow, xHigh, 100), alphaPosterior, betaPosterior)']);
%csvwrite('output/posteriorCDF.txt',[x' yPosteriorCDF']);

%csvwrite('output/2014-05-30_exercise2_pdf.txt',[(0:0.001:1)' betapdf(0:0.001:1,534,468)'])
%csvwrite('output/2014-05-30_exercise2_pdf.txt',[(0:0.001:1)' betapdf(0:0.001:1,534,468)'])