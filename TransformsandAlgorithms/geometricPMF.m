function out= geometricPMF(n,p)
p1=p+0.2;
p2=p1+0.3;
for k=1:n
    y(k)=(1-p)^(k-1)*p;
    y1(k)=(1-p)^(k-1)*p1;
    y2(k)=(1-p)^(k-1)*p2;

end
figure;
hold on
stem(1:12,y,'r')
stem(1:12,y1,'g')
stem(1:12,y2,'b')

xlabel('k')
ylabel('p_X(k)')
title('geometric destribution')

legend('p=0.3', 'p=0.5', ...
    'p=0.8', 'Location', 'NorthEast')
end
