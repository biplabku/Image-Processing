rV = randn(1,1500)
mean1=30;
var1=144;
y= var1.*rV + mean1;
figure;
hold on
subplot(1,2,1);
hist(y,25);
xlabel('Bin');
ylabel('Frequency');
title('Histogram of 1500 Norma Random Variables');
% converting into standard normal random variables
mean_y=0;
for i=1:1500
    mean_y=y(i)+mean_y;
end
mean_y=mean_y/1500;
var_y=0;
for i=1:1500;
    var_y=(y(i)-mean_y)^2+var_y;
end
var_y=var_y/1500;
rV1=(y-mean_y)/sqrt(var_y)
subplot(1,2,2);
hist(rV1,25);
xlabel('Bin');
ylabel('Frequency');
title('Histogram of 1500 Norma Random Variables');