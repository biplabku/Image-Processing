clc;
close all;
clear all;
%--------part C--------------------
QP=[22, 24, 26, 28, 30, 32, 34, 36]
R=[818.47, 592.18, 431.84, 320.70 , 228.29, 159.02,114.29, 80.82];
lnR=log(R);
P=polyfit(QP,lnR,1)
Rate_up=exp((-0.1653*QP)+10.3635);
plot(QP,R,QP,Rate_up)
%-----------for calculating the Average---------
sum=0;
for i=1:8
x(i)=abs((R(i)-Rate_up(i))/Rate_up(i));
sum=sum+x(i);
end
avg=(sum/8)*100

xlabel('QP')
ylabel('Rate')
title('Plot of Rate Silent')
legend('Silent','Model')
