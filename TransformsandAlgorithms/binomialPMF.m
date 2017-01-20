function y= binomialPMF(n,p)
p1=p+0.35;
for k=1:n
    y(k)=factorial(n)/(factorial(k)*factorial(n-k))*p^k*(1-p)^(n-k)       
    y1(k)=factorial(n)/(factorial(k)*factorial(n-k))*p1^k*(1-p1)^(n-k)       
    y2(k)=factorial(50)/(factorial(k)*factorial(50-k))*p^k*(1-p)^(50-k)       
end
size(y)
figure;
hold on
stem(1:25,y,'r')
stem(1:25,y1,'g')
stem(1:25,y2,'b')

xlabel('k')
ylabel('p_X(k)')
title('geometric destribution')

legend('p=0.4 and n=25', 'p=0.75 and n=25', ...
    'p=0.4 and n=50', 'Location', 'NorthEast')
end
