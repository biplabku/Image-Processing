clc;
close all;
clear all;
%%%%-------STEFAN Video Sequence-------%%%%%%
QP=[22, 24, 26, 28, 30, 32, 34, 36];
PSNR=[41.491, 39.663, 37.849, 36.155, 34.221, 32.343, 30.677, 28.875];
%------for calculating MSE-----------
for i=1:8
MSE(i)=(255*255)/10^(0.1*PSNR(i));
display(MSE(i));
end
MSE_stf=MSE;
MSEstefan=((QP.^2)/3);
plot(QP,MSE_stf,QP,MSEstefan)

sum=0;
for i=1:8
x(i)=abs((MSE_stf(i)-MSEstefan(i))/MSEstefan(i));
sum=sum+x(i);
end
avg=(sum/8)*100
figure (1)
xlabel('QP')
ylabel('Distortion')
title('Plot of Distortion- Stefan')
legend('Stefan','Model')


%%%%-------SILENT Video Sequence-------%%%%%%
PSNR1=[40.572, 38.950, 37.449,36.073, 34.710, 33.385, 32.364, 31.125 ];
for i=1:8
MSE1(i)=(255*255)/10^(0.1*PSNR1(i));
display(MSE1(i));
end
MSE_slt=MSE1;
MSEsilent=((QP.^2)/3);
figure (2)
plot(QP,MSE_slt,QP,MSEsilent);
sum1=0;
for i=1:8
xb(i)=abs((MSE_slt(i)-MSEsilent(i))/MSEsilent(i));
sum1=sum1+xb(i);
end
avg1=(sum1/8)*100

xlabel('QP')
ylabel('Distortion')
title('Plot of Distortion- Silent')
legend('Silent','Model')

figure(3)
plot (QP,MSE_stf,'r',QP,MSE_slt)
xlabel('QP')
ylabel('Distortion')
title('Distortion Comparision of Stefan and Silent')
legend('Stefan','Silent')
