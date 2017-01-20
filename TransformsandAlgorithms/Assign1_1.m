format compact
N=25;
f=zeros(size(N));
for n=N
    f(n+1)=factorial(n);
    n
    disp(f(n+1))
end
figure;
plot(N,f,'r-o');

xlabel('n');
ylabel('f(n)');
title('plot of n!'