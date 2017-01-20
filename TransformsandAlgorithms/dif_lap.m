%% error- Mean square error
function MSE= dif_lap(x,y)
[M N]=size(x);
MSE=0;
for i=1:1:M
    for j=1:1:M
        MSE(i,j)=((x(i,j)-y(i,j)));
    end
end
% taking the average to calculate the mean square error of the
% reconstructed image to that of the original image.
end