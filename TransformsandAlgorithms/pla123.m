%% program using random dictonary

clc;
close all;
clear all;
I0=imread('cameraman.tif');
I=double(I0);
imshow(I,[]);
figure
%% downsampling the image I to I1 of size 128 by 128
s=1;
t=1;
for i1=1:128
    for j1=1:128
        I1(i1,j1)=I(s,t);
        t=t+2;
    end
    t=1;
    j1=1;
    s=s+2;
end

%% upsampling image I1 by zero padding to get I2 of size 256 by 256
s1=1;
t1=1;
I2=zeros(256,256);
for i1=1:128
    for j1=1:128
        I2(s1,t1)=I1(i1,j1);
        t1=t1+2;
    end
    t1=1;
    j1=1;
    s1=s1+2;
end

%% formation of dft matrix 64 by 64
A=[];
p=1;
for k=0:63
    for l=0:63      
          A(p)=(1/8)*(exp((-2*i*pi*k*l)/64));
          p=p+1;
    end
end
  A=A';         
  d=col2im(A,[1 1],[64 64]);
  d=d';
 
  
%% formation of DCT matrix of size 64 by 64
bbb=8;
K=64;
Pn=ceil(sqrt(K));
DCT=zeros(bbb,Pn);
for k=0:1:Pn-1,
    V=cos([0:1:bbb-1]'*k*pi/Pn);
    if k>0, V=V-mean(V); 
    end;
    DCT(:,k+1)=V/norm(V);
end; 
 DCT=kron(DCT,DCT); 
  
%% taking random matrix
v=rand(64);
h=zeros(64,64);
N=1;
for i=1:64
h(:,N)=(v(:,i))/norm(v(:,i));
N=N+1;
end
 PH=zeros(16,64);
 P=randperm(64);
 K1=1;
  for l=1:16
      a=P(K1);
      for J=1:64
          PH(l,J)=h(a,J);
      end
      J=1;
      K1=K1+1;
  end 
%% dictionary of size 16 by 64 formed by multiplying DCT and spike matrix
  D=PH*d;
 
%% taking blocks of size 4 by 4 from image I1 of size 128 by 128 

Reduce_DC=1;
[NN1,NN2] = size(I1);
C = 1.15;
slidingDis = 1;
bb = 4;

maxBlocksToConsider = 26000;

while (prod(floor((size(I1)-bb)/slidingDis)+1)>maxBlocksToConsider)
    slidingDis = slidingDis+1;
end
[blocks,idx] = my_im2col(I1,[bb,bb],slidingDis); %%size of blocks:- 16 by 15625 (sliding distance 1; I1 size:-128 by 128)

%% forming matrix of size 64 by 15625 to accomodate "Coefs" from "Omperr"
bb1=8;
slidingDis1 = 2;
[blocks1,idx1]=my_im2col(I,[bb1,bb1],slidingDis1); %%size of blocks1:-64 by 15625 (sliding distance 2; I2 size 256 by 256)

%go with jumps of 10,000
errT =10;
for jj = 1:10000:size(blocks,2)
    
    jumpSize = min(jj+10000-1,size(blocks,2));
    if (Reduce_DC)
        vecOfMeans = mean(blocks(:,jj:jumpSize));
        vecOfMeans1 = mean(blocks1(:,jj:jumpSize));
        blocks(:,jj:jumpSize) = blocks(:,jj:jumpSize) - repmat(vecOfMeans,size(blocks,1),1);
        blocks1(:,jj:jumpSize) = blocks1(:,jj:jumpSize) - repmat(vecOfMeans1,size(blocks1,1),1);
    end
 
   Coefs= OMPerr(D,blocks(:,jj:jumpSize),errT); %% size of Coefs:-64 by 15625
   
 if (Reduce_DC)
        blocks1(:,jj:jumpSize)=d*Coefs + ones(size(blocks1,1),1) * vecOfMeans1;
    else
        blocks1(:,jj:jumpSize)= d*Coefs ;%% columns of new image kept in matrix of size 64 by 15625
 end
end
% while errT>6
%  for jj = 1:10000:size(blocks1,2)
%     jumpSize = min(jj+10000-1,size(blocks1,2));
%     if (Reduce_DC)
%         %vecOfMeans = mean(blocks(:,jj:jumpSize));
%         vecOfMeans1 = mean(blocks1(:,jj:jumpSize));
%         %blocks(:,jj:jumpSize) = blocks(:,jj:jumpSize) - repmat(vecOfMeans,size(blocks,1),1);
%         blocks1(:,jj:jumpSize) = blocks1(:,jj:jumpSize) - repmat(vecOfMeans1,size(blocks1,1),1);
%     end
%  
%    Coefs1= OMPerr(d,blocks1(:,jj:jumpSize),errT); %% size of Coefs:-64 by 15625
%    
%  if (Reduce_DC)
%         blocks1(:,jj:jumpSize)=DCT*Coefs1 + ones(size(blocks1,1),1) * vecOfMeans1;
%     else
%         blocks1(:,jj:jumpSize)= DCT*Coefs1 ;%% columns of new image kept in matrix of size 64 by 15625
%  end
%  end
% errT=errT-1;
% end
 
%% reconstructing the image-blocks 64 by 15625 to an image 256 by 256

count = 1;
[nn1,nn2]=size(I);
Weight= zeros(nn1,nn2);
IMout = zeros(nn1,nn2);
bb1=8;
[rows,cols] = ind2sub(size(I)-bb1+1,idx1);
for i1  = 1:length(cols)
    col = cols(i1); 
    row = rows(i1);
    block =reshape(blocks1(:,count),[bb1,bb1]);
    IMout(row:row+bb1-1,col:col+bb1-1)=IMout(row:row+bb1-1,col:col+bb1-1)+block;
    Weight(row:row+bb1-1,col:col+bb1-1)=Weight(row:row+bb1-1,col:col+bb1-1)+ones(bb1);
    count = count+1;
end;
Iout=(IMout)./(Weight);
imshow(Iout,[0 255])