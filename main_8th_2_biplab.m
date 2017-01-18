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
 n=randperm(16)
   n=[1 3 5 7 17 19 21 23 33 35 37 39 49 51 53 55];
% n=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
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


%    load globalTrainedDictionary
%    b=currDictionary;
%  load Dictionary1
%  b=Dictionary1;
% PH=phi;
% 
  %load D_512_8

%%haar matrix generation
% Dh=zeros(64,64);
N=64;
Dh=zeros(N,N);
for k=0:N-1
    for m=0:N-1
        if(k==0)
            Dh(k+1,m+1)=1/(sqrt(N));
        else
            t=m/N;
            p=floor(log2(k));
            q=k-(2^p)+1;
            if((t>=((q-1)/(2^(p)))) & (t<((q-0.5)/(2^(p)))))
                Dh(k+1,m+1)=(1/(sqrt(N)))*(2^(p/2));
            elseif((t>=((q-0.5)/(2^(p)))) & (t<((q)/(2^(p)))))
                Dh(k+1,m+1)=-(1/(sqrt(N)))*(2^(p/2));
            else
                Dh(k+1,m+1)=0;
            end
        end
    end
end
% load kanchan1
% b=DICTIONARY;
% PH=phi;
% % %% gaussian matrix generation
% % p=1;
% % for X1=0:.0158:1
% %     F(p)=(1/sqrt(2*pi*(.5^2)))*exp(-((X1^2)/2*(.5)^2));
% %     p=p+1;
% % end
% % p=1;
% % G=zeros(64,64);
% % for i=1:64
% %     for j=1:64
% %         if i==j
% %             G(i,j)=F(p);
% %             p=p+1;
% %         else
% %             G(i,j)=0;
% %         end
% %     end
% %     j=1;
% % end
% % t=sqrt(sum(G.^2,1));
% %  for j=1:64 %selecting each column one by one
% %         for k=1:64
% %             if((G(k,j)==0))
% %                 G(k,j)=0;
% %             else
% %                 G(k,j)=G(k,j)/t(k);
% %             end
% %         end
% %     end
% % 
% % %  b=Dh*G;
% % %  [r c]=size(b)
b=Dh;%%
%%

%% multiply the matrices
%b=conj(DFt)'*Dh*DFt;


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
I=abs(I);
% I=imsharpen(I);
% I=backprojection(I,Image12,30);

% I=real(I);
 I=mat2gray(I);
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