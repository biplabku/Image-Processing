function g=GaussFilter(wnsz, sig)
%taking the window size
sz=wnsz;
% initialising the matrix to be zero with window size dimesnion
g=zeros(sz,sz);
fac=(sz-1)/2;
fac1=(sz+1)/2;
for i=-fac:fac
    for j=-fac:fac
        x_tmp=fac1; %center
        y_tmp=fac1; %center
        x=i+x_tmp; %row
        y=j+y_tmp; %col
        g(y,x)=exp(-((x-x_tmp)^2+(y-y_tmp)^2)/(2*sig^2))/(2*3.14*sig^2);
    end
end
%normalize gaussian filter
sum1=sum(g);
sum2=sum(sum1);
g=g/sum2;
end