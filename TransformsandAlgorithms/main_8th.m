clc
close all;
clear all;
im=imread('liftingbody.png');
im=imresize(im,[512 512]);
 %im=magic(16)
imshow(im)
im67=im;
[m n]=size(im);
%=============================
%====================================
% ycbcr=rgb2ycbcr(im);
% im=ycbcr(:,:,1);
 y=imresize(im,[256 256]);
% cb=imresize(imresize(ycbcr(:,:,2),[256 256]),[512 512]);
% cr=imresize(imresize(ycbcr(:,:,3),[256 256]),[512 512]);
im1=y;
y11=imresize(imresize(im,[256 256]),2);
% bicub(:,:,1)=y11;
% bicub(:,:,2)=cb;
% bicub(:,:,3)=cr;
figure
imshow(y11)

PH=zeros(16,64);
% n=randperm(64)
   n=[1 3 5 7 17 19 21 23 33 35 37 39 49 51 53 55];
for i=1:16
    PH(i,n(i))=1;
end;
% PH=zeros(16,64);
%  n=randperm(64);
% % n=[1 3 9 11]
% for i=1:16
%     PH(i,n(i))=1;
% end;
%load sampling_matrix
% PH=phi;

%%
   load globalTrainedDictionary
   b=currDictionary;
%  load Dictionary1
%  b=Dictionary1;
% PH=phi;
%%
%%
%%

%% multiply the matrices
D=PH*b;
% %  coherence
% coherence=mutual_coherence(Q,b)

% %% taking 4 by 4 patches as the columns of a matrix "blocks"
bb=4;
slidingDis=1;

Image=im2double(im1);
Image12=imresize(Image,[256 256]);
[blocks,idx] = my_im2col(Image,[bb,bb],slidingDis);


 
   vecOfMeans = mean(blocks);
   blocks= blocks(:,1:size(blocks,2)) - repmat(vecOfMeans,size(blocks,1),1); % substracting the mean of each column from corresponding column elements

 Coefs=OMP(D,blocks(:,1:size(blocks,2)),9);
% Coefs=l1ls_featuresign(D,blocks,1);


   block= b*Coefs + ones(size(b*Coefs,1),1)* vecOfMeans;
  

image= block;
[NN11,NN22] = size(im);
count = 1;
bb1=8;
Weight= zeros(NN11,NN22);
IMout1 = zeros(NN11,NN22);

idxMat = zeros(size(im)-[bb1 bb1]+1);
idxMat([[1:2:end-1],end],[[1:2:end-1],end]) = 1; % take blocks in distances of 'slidingDix', but always take the first and last one (in each row and column).
idx = find(idxMat);
[rows,cols] = ind2sub(size(im)-bb1+1,idx);
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
  I=backprojection(I,Image12,30);

% I=real(I);
% I=mat2gray(I);
% I=im2uint8(I);
% ycbcrmap(:,:,1)=I;
% ycbcrmap(:,:,2)=cb;
% ycbcrmap(:,:,3)=cr;
% I=ycbcr2rgb(ycbcrmap);
 figure
imshow(I);
im=im2double(im);
our=psnr(I,im,1)

bicub=psnr(y11,im)
% I2=backprojection(imresize(Image12,[512 512]),Image12,10);
% our3=psnr(I2,im)
% figure
% imshow(our3)