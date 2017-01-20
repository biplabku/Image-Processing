format compact
N=[0:8];
f=zeros(size(N));
for n=N
    f(n+1)=factorial(n);
    n
    disp(f(n+1))
end
figure;
semilogy(N,f,'r-o');

xlabel('n');
ylabel('f(n)');
title('plot of n! with the y-axis in log scale')