%% upsampling an image by adjacent values
function OutUp=upsample(Imgin)
% it would be upsampled to 128 X 128
[r c]=size(Imgin);
z=Imgin;
[rws cls]=size(z);
M=rws+rws;
OutUp=zeros(M,M);
tmp1=0;
tmp=0;
tmp2=0;
tmp_2=0;
for i=1:1:rws
    for j=1:1:cls
        tmp=z(i,j);
        OutUp(i+tmp2,j+tmp1)=tmp;
        tmp1=tmp1+1;
    end
    tmp2=tmp2+1;
    tmp1=0;
end

% now taking the value of the neighbouring pixels
for i=1:2:M
    for j=2:2:M
        OutUp(i,j)=OutUp(i,j-1);
    end
end

for i=2:2:M
    for j=1:1:M
        OutUp(i,j)=OutUp(i-1,j);
    end
end
imshow(uint8(OutUp))
end
        
