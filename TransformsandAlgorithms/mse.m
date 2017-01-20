%% error- Mean square error
function MSE1= mse(x,y)
[M N]=size(x);
MSE1=0;
tmpv1=0;
for i=1:1:M
    for j=1:1:M
        tmpv1= tmpv1 + (x(i,j)-y(i,j))^2;
    end
    MSE1=tmpv1+MSE1;
end
MSE1=abs(MSE1);
% taking the average to calculate the mean square error of the
% reconstructed image to that of the original image.
end