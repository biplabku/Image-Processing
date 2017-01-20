format compact
n=8;
K=[0:8];
f=zeros(size(K));
for k=K
    f(k+1)=factorial(n)/(factorial(k))*factorial(n-k);
    k
    disp(f(k+1));
end
figure;
plot(K,f,'r-o');

xlabel('k');
ylabel('n!/(n-k)!');
title('plot of n! with the y-axis in log scale')