figure;
d = 1;          %distance of gaussians
c = 1/2;        %criterion
hits=1-normcdf(c,d,1);          %one hit
falsealarms=1-normcdf(c,0,1);   %one false alarm
subplot(3,2,1)
%plot datapoint
plot(falsealarms,hits,'+','linewidth',2),axis([0 1 0 1]),axis square;

%simulating varying criterion from -3 to 3
c=linspace(-3,3,1000);          
hits=1-normcdf(c,d,1);
falsealarms=1-normcdf(c,0,1);
subplot(3,2,2)
%plot ROC curve with distance of gaussians = 1
plot(falsealarms,hits,'LineWidth',2), axis square, title('d=1');

d=0;
hits=1-normcdf(c,d,1);
falsealarms=1-normcdf(c,0,1);
subplot(3,2,3)
%plot ROC curve with distance of gaussians = 0
plot(falsealarms,hits,'LineWidth',2), axis square, title('d=0');

d=1/2;
hits=1-normcdf(c,d,1);
falsealarms=1-normcdf(c,0,1);
subplot(3,2,4)
%plot ROC curve with distance of gaussians = 1/2
plot(falsealarms,hits,'LineWidth',2), axis square, title('d=1/2');

d=2;
hits=1-normcdf(c,d,1);
falsealarms=1-normcdf(c,0,1);
subplot(3,2,5)
%plot ROC curve with distance of gaussians = 2
plot(falsealarms,hits,'LineWidth',2), axis square, title('d=2');

d=3;
hits=1-normcdf(c,d,1);
falsealarms=1-normcdf(c,0,1);
subplot(3,2,6)
%plot ROC curve with distance of gaussians = 3
plot(falsealarms,hits,'LineWidth',2), axis square, title('d=3');

figure;
cc=hsv(12);         %playing around with the colors
d=1;
subplot(1,3,1);
hits=1-normcdf(c,d,1);
falsealarms=1-normcdf(c,0,1);
%plot ROC curve with distance of gaussians = 1
plot(falsealarms,hits,'k'), axis square, title('criterion=1/4');
hold on;
for i=1:6
    %simulate 100 random trials with a criterion of 1/4
    %take the mean of the trials above the criterion
    expectedfalsealarms=mean(normrnd(0,1,[100,1])>(1/4));
    expectedhits=mean(normrnd(1,1,[100,1])>(1/4));
    %plot the datapoint
    plot(expectedfalsealarms,expectedhits,'w^','linewidth',2,...
        'MarkerFaceColor',cc(i,:),'MarkerEdgeColor','none',...
        'MarkerSize',7),axis([0 1 0 1]),...
    axis square;
    hold on;
end

%repeat previous step with different criterion (=1/2)
subplot(1,3,2);
hits=1-normcdf(c,d,1);
falsealarms=1-normcdf(c,0,1);
plot(falsealarms,hits,'k'), axis square, title('criterion=1/2');
hold on;
for i=1:10
    expectedfalsealarms=mean(normrnd(0,1,[100,1])>(1/2));
    expectedhits=mean(normrnd(1,1,[100,1])>(1/2));
    plot(expectedfalsealarms,expectedhits,'w^','linewidth',2,...
        'MarkerFaceColor',cc(i,:),'MarkerEdgeColor','none',...
        'MarkerSize',7),axis([0 1 0 1]),...
    axis square;
    hold on;
end

%repeat with different criterion (=2/3)
subplot(1,3,3);
hits=1-normcdf(c,d,1);
falsealarms=1-normcdf(c,0,1);
plot(falsealarms,hits,'k'), axis square, title('criterion=2/3');
hold on;
for i=1:10
    expectedfalsealarms=mean(normrnd(0,1,[100,1])>(3/2));
    expectedhits=mean(normrnd(1,1,[100,1])>(3/2));
    plot(expectedfalsealarms,expectedhits,'w^','linewidth',2,...
        'MarkerFaceColor',cc(i,:),'MarkerEdgeColor','none',...
        'MarkerSize',7),axis([0 1 0 1]),...
    axis square;
    hold on;
end