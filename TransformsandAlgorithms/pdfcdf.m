mymu=0;
mymu1=-3;
myvar2=0.5;
myvar=1;
myvar1=2.5;
X = [-10:0.1:10];
pdf1=pdf('normal',X, mymu, myvar);
pdf2=pdf('normal',X, mymu, myvar1);
pdf3=pdf('normal',X, mymu1, myvar2);
cdf1=cdf('normal',X, mymu, myvar);
cdf2=cdf('normal',X, mymu, myvar1);
cdf3=cdf('normal',X, mymu1, myvar2);
figure;
hold on
subplot(1,2,1);
plot(X,pdf1,'r',X,pdf2,'g',X,pdf3,'b');
xlabel('x');
ylabel('f_X(x)')
title('Normal PDF')

subplot(1,2,2);
plot(X,cdf1,'r',X,cdf2,'g',X,cdf3,'b');

xlabel('x');
ylabel('f_X(x)')
title('Normal CDF')