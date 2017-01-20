%% function for padding of the image for convulation of the image and the matrix
function zpad=PadZero(img)
N=5; % Gaussian filter size
[rz1 rz2]=size(img); % without padded image
% new rows and columns size for the padded image matrix
rz_1=rz1+4;
rz_2=rz2+4;
zpad=uint8(zeros(rz_1,rz_2));
for i=1:1:rz1
    for j=1:1:rz2
        zpad(i+2,j+2)=img(i,j);
    end
end
end
