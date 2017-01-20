%% homework 4
clc;
I = imread('MixedVegetables.jpg');
I2 = imread('MixedVegetables.jpg');
I3 = imread('MixedVegetables.jpg');
im = im2uint8(rgb2gray(I));
%im = im2double(im);
[r, c] = size(im);
G=[ 0   0  -1  -1  -1  0   0;
    0  -2  -3  -3  -3 -2   0
   -1  -3   5   5   5 -3  -1
   -1  -3   5  16   5 -3  -1
   -1  -3   5   5   5 -3  -1
    0  -2  -3  -3  -3 -2   0
    0   0  -1  -1  -1  0   0];

im_pad = PadZero(im, 7); 
out = conv2d(G,im_pad, im);
%-----------output part a -------------
figure 
imshow(out);
%======================================
%% for checking zero crossing, checking the up, down, left and right for change of sign i.e 4 neighbours
out = PadZero(out, 3);
zc_dog = zeros(r, c);
for i = 2:1:r
    for j = 2:1:c
        if(out(i,j-1) > 0 && out(i, j) < 0 || out(i,j) < 0 && out(i,j + 1) < 0 ||out(i,j) < 0 && out(i+1,j) < 0)
            zc_dog(i - 1, j - 1) = 1;
        else
            zc_dog(i - 1, j - 1) = 0;
        end
    end
end
% %-----------output part b -------------%
figure
imshow(zc_dog);
%======================================%

im2 = im2uint8(rgb2gray(I2));
im2 = im2double(im2);
% Application of sobel Filter
h1 = [1  2  1
      0  0  0
     -1 -2 -1];
 
h3 = [-1 0 1
    -2 0 2
    -1 0 1];

g_pad = PadZero(im2, 3);
Hx = fspecial('sobel');
Hy = Hx';
Gx = imfilter(im2, h1, 'conv');
Gy = imfilter(im2, h3, 'conv');
G = sqrt(Gx.^2 + Gy.^2);
% thresholding G with an appropriate value.
thrsh = graythresh(G);
S = im2bw(G,thrsh);
ZC = (zc_dog);
%% doing logical and operation between both the matrices
cout = S & ZC;
%-----------output part c -------------%
figure
imshow(cout)
%=======================================


%%%%%%%%%%%%%%%%%%%%%%%% LOG part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im3 = im2uint8(rgb2gray(I3));
im3 = im2double(im3);

Lmsk = [0   0   1   0   0
       0   1   2   1   0
       1   2  -16  2   1
       0   1   2   1   0
       0   0   1   0   0];
   
lpad = PadZero(im3, 5);
LOG = conv2d(Lmsk, lpad, im3);
%-----------output part d -------------%
figure
imshow(LOG);
thrsh = graythresh(LOG);
SA = im2bw(LOG,thrsh);
figure
imshow(SA);
%======================================= word







