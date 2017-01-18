clc
close all;
clear all;
im=imread('lena.png');
% im=rgb2gray(im);
im=imresize(im,[512 512]);
 %im=magic(16)
imshow(im)
im67=im;
[m n]=size(im);
%=============================
%====================================
% ycbcr=rgb2ycbcr(im);
% im=ycbcr(:,:,1);
r=m/2;
s=n/2;
p=1;
for k=1:2:m-1
    for j=1:2:n-1
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

%   y=imresize(im,[256 256]);
  y=im1;

% cb=imresize(imresize(ycbcr(:,:,2),[256 256]),[512 512]);
% cr=imresize(imresize(ycbcr(:,:,3),[256 256]),[512 512]);
im1=y;
y11=imresize(im1,2);
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
% PH=zeros(4,16);
% % n=randperm(64)
% n=[1 3 9 11]
% for i=1:4
%     PH(i,n(i))=1;
% end;
%load sampling_matrix
% PH=phi;

%%
%    load globalTrainedDictionary
%    b=currDictionary;
%  load Dictionary1
%  b=Dictionary1;
% PH=phi;
% 
 load D_512_8   %% representing Dh that is the dictionary matrix
% load kanchan1
% b=DICTIONARY;
% PH=phi;
b=Dh;
 
%% haar_2d matrix
function v=haar_2d( u )
%    Input, real U(M,N), the vector to be transformed.
%    Output, real V(M,N), the transformed vector.
m=64;
n=64;
v = u;
s = sqrt ( 2.0 );
w = zeros ( m, n );
%%  Transform all columns.
k = m;
while(1<k)
    k = floor ( k / 2 )
    w(  1:  k,:) = ( v(1:2:2*k-1,:) + v(2:2:2*k,:) ) / s
    w(k+1:k+k,:) = ( v(1:2:2*k-1,:) - v(2:2:2*k,:) ) / s
    v(1:2*k,:) = w(1:2*k,:)
end
%%  Transform all rows.
  k = n;
  while ( 1 < k )
    k = floor ( k / 2 )
    w(:,  1:  k) = ( v(:,1:2:2*k-1) + v(:,2:2:2*k) ) / s
    w(:,k+1:k+k) = ( v(:,1:2:2*k-1) - v(:,2:2:2*k) ) / s
    v(:,1:2*k) = w(:,1:2*k)
  end
  return
end
display(w)


%% multiply the matrices
D=PH*b;
% %  coherence
% coherence=mutual_coherence(Q,b)

% %% taking 4 by 4 patches as the columns of a matrix "blocks"
bb=4;
slidingDis=1;

Image=im2double(im1);
% Image12=imresize(Image,[256 256]);
[blocks,idx] = my_im2col(Image,[bb,bb],slidingDis);


 
   vecOfMeans = mean(blocks);
   blocks= blocks(:,1:size(blocks,2)) - repmat(vecOfMeans,size(blocks,1),1); % substracting the mean of each column from corresponding column elements
%     norm_blocks=sqrt(sum(blocks.^2,1));
% norm_blocks=max(blocks);
% % % norm_val=(norm_block*(1.2)./norm_blocks);
%  blocks=blocks./repmat(norm_blocks, size(blocks, 1), 1);


     Coefs=OMP(D,blocks(:,1:size(blocks,2)),6);
%     Coefs=OMPerr(D,blocks,0.001);
%Coefs=l1ls_featuresign(D,blocks,1);

% block13=b*Coefs;
   block= b*Coefs + ones(size(b*Coefs,1),1) * vecOfMeans;
%    block12=max(block13);
%    norm_blocks=norm_blocks./block12;
%   block=block.*repmat(norm_blocks,size(block,1),1);

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
% I=imsharpen(I);
% I=backprojection(I,Image12,30);

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

bicub=psnr(im2double(y11),im)
 coherence=mutual_coherence(PH,b)
% I2=backprojection(imresize(Image12,[512 512]),Image12,10);
% our3=psnr(I2,im)
% figure
% imshow(our3)