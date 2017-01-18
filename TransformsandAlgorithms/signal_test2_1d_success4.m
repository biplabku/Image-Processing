clc;
clear all;
close all;
original=(imread('peppers.png'));
original=im2double(original(:,:,1));
load globalTrainedDictionary
 qwe=im2col(original,[8 8],'distinct');

%  Alpha1=OMP(currDictionary,qwe,25);
%
% load sampling_matrix2_16_64;
 phi=zeros(16,64);
 n=randperm(64);
for i=1:16
    phi(i,n(i))=1;
end
load kanchan1
currDictionary=shi;
qwe=phi*qwe;
    IMAGEcol=qwe;
%     InputImg=col2im(qwe,[4 4],[256 256],'distinct');
%    InputImg=imresize(InputImg,[512 512]);

Dictionary1=currDictionary;
% load Dictionary1
D=phi*Dictionary1;
norm_D=sqrt(sum(D.^2,1));
D=D./repmat(norm_D,size(D,1),1);

 NN1=4;
 MM1=4;
%   IMAGEcol=im2col(InputImg,[NN1,MM1],'distinct');
 IMAGEcol_mean=mean(IMAGEcol);
 IMAGEcol=IMAGEcol-repmat(IMAGEcol_mean,size(IMAGEcol,1),1);

Alpha=OMP(D,IMAGEcol,7);
% Alpha1=zeros(size(Alpha));
% [a w e]=find(Alpha>0.001); 
% for i=1:length(a)
%     Alpha1(a(i),w(i))=e(i);
% end

X=Dictionary1*Alpha; 
X=X+repmat(IMAGEcol_mean,size(X,1),1); 

   I=col2im(X,[8 8],[512 512],'distinct');
%  im=original;
%  image= X;
%  [NN11,NN22] = size(im);
% 
%  count = 1;
%  bb1=8;
%  Weight= zeros(NN11,NN22);
%  IMout1 = zeros(NN11,NN22);
% 
%  idxMat = zeros([NN11 NN22]-[bb1 bb1]+1);
%  idxMat([[1:1:end-1],end],[[1:1:end-1],end]) = 1; 
%  idx = find(idxMat);
%  [rows,cols] = ind2sub(size(idxMat),idx);
% 
%  for i  = 1:length(cols)
%     col = cols(i); row = rows(i);
%     blocks =reshape(image(:,count),[bb1,bb1]);
%     IMout1(row:row+bb1-1,col:col+bb1-1)=IMout1(row:row+bb1-1,col:col+bb1-1)+blocks;
%    Weight(row:row+bb1-1,col:col+bb1-1)=Weight(row:row+bb1-1,col:col+bb1-1)+ones(bb1);
%     count = count+1;
%  end;
%  IOut = IMout1./(Weight);
% % % I=backprojection(IOut,InputImg,20);
%    I=IOut;
% % % I=im2uint8(I);
% % % I=im2uint8(I);
% % 
 figure
 imshow(I);
%    I2=imresize(InputImg,[512 512],'bicubic');
% % % % I2=backprojection(I2,InputImg,20);
% % % % I2=im2uint8(I2);
% % % % I2=imresize(imcrop(I2),[256 256]);
%    figure
%    imshow(I2);
% % % figure
% % % imshow(InputImg)
% % %  our_method_rmse=compute_rmse(I(10:end-10,10:end-10),original(10:end-10,10:end-10));
% % %  bicubic_rmse=compute_rmse(I2(10:end-10,10:end-10),original(10:end-10,10:end-10));
% % % original=(imread('gnd.bmp'));
% % % original=rgb2ycbcr(original);
% % % original=original(:,:,1);
% % % 
 our_method_rmse=compute_rmse(I,original)
%  bicubic_rmse=compute_rmse(I2,original)
% 
% 
psnr_our=20*log10(1/our_method_rmse)
% psnr_bicubic=20*log10(1/bicubic_rmse)
% imshow(original);

% figure
% I3=original-I;
% imshow(I3);
% figure
% I4=original-I2;
% imshow(I4);
%  
