clc
close all;
clear all;
im=imread('lena.png');
% im=imread('barbara.png');
% im=imread('boat.png');
% im=imread('liftingbody.png');
% im=imread('flowers.jpg');
% im=rgb2gray(im);
 if size(im, 3) == 3,
    im = rgb2gray(im);
 end
im=imresize(im,[512 512]);
 
% im67=im;
[m n]=size(im);
zooming=4;
factor=4;
r=m/factor;
s=n/factor;
p=1;
for k=1:factor:m-1
    for j=1:factor:n-1
        x(p)=im(k,j);
        p=p+1;
    end
end
x=x';
size(x)
im1=reshape(x,r,s);
im1=im1';
l=1;
q=1;
size(im1);
y=im1;
imshow(y)
y11=imresize(im1,factor);
figure
imshow(y11)

%%

%%
FACT=2;
for i=1:zooming/2
PH=zeros(16,64);
n=[1 3 5 7 17 19 21 23 33 35 37 39 49 51 53 55];
for i=1:16
    PH(i,n(i))=1;
end;
load AVG
%%
load DICT256
  b1=avg*Dh;
%    b1=Dh;
%   b=Dh;
b=b1;

%%

%% multiply the matrices
D=PH*b1;

%% taking 4 by 4 patches as the columns of a matrix "blocks"
bb=4;
slidingDis=1;
Image=im2double(im1);
[blocks,idx] = my_im2col(Image,[bb,bb],slidingDis);
vecOfMeans = mean(blocks);
blocks= blocks(:,1:size(blocks,2)) - repmat(vecOfMeans,size(blocks,1),1); % substracting the mean of each column from corresponding column elements

%%
Coefs=OMP(D,blocks(:,1:size(blocks,2)),6);
% Coefs=OMPerr(D,blocks,0.001);
%%
% block= (b*Coefs) + ones(size(b*Coefs,1),1) * vecOfMeans;
block=(b*Coefs)+repmat(vecOfMeans,size(b*Coefs,1),1);
image= block;
[NN11,NN22] = size(im1);
NN11=2*NN11;
NN22=2*NN22;
count = 1;
bb1=8;

Weight= zeros(NN11,NN22);
IMout1 = zeros(NN11,NN22);

idxMat = zeros([NN11 NN22]-[bb1 bb1]+1);
idxMat([[1:FACT:end-1],end],[[1:FACT:end-1],end]) = 1; % take blocks in distances of 'slidingDix', but always take the first and last one (in each row and column).
idx = find(idxMat);
[rows,cols] = ind2sub(2*size(im1)-bb1+1,idx);
for i  = 1:length(cols)
    col = cols(i); row = rows(i);
    blocks =reshape(image(:,count),[bb1,bb1]);
    IMout1(row:row+bb1-1,col:col+bb1-1)=IMout1(row:row+bb1-1,col:col+bb1-1)+blocks;
    Weight(row:row+bb1-1,col:col+bb1-1)=Weight(row:row+bb1-1,col:col+bb1-1)+ones(bb1);
    count = count+1;
end;

% taking weighted average

IOut = IMout1./(Weight);
I=IOut;
im1=I;
end
figure
imshow(I);
im=im2double(im);

our=psnr(I(5:end-5,5:end-5),im(5:end-5,5:end-5),1)

bicub=psnr(im2double(y11),im)
coherence=mutual_coherence(PH,b1)
 I=im2uint8(I);
 im=im2uint8(im);
 y11=im2uint8(y11);
[mssim,ssim_index]=ssim(I,im);
[mssim_bicubic,ssim_index_bicubic]=ssim(im,y11);
mssim
mssim_bicubic
