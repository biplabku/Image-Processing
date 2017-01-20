function y= shft2dft(h)
[m n ]=size(h);
y=0;
for i=1:1:m/2
    var1=0;
    var2=0;
    for j=1:1:n/2
        var1=h(i,j);
        h(i,j)=h(i+m/2,j+n/2);
        h(i+m/2,j+n/2)=var1;
        var2=h(i+m/2,j);
        h(i+m/2,j)=h(i,j+n/2);
        h(i,j+n/2)=var2;
    end
end
y=h;
end