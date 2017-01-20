function [R]=myHarris
Image1=imread('img02.jpg');
Image1=double(Image1);
Gx = [-1 0 1 ; -2 0 2; -1 0 1]*0.25;
Gy = [-1 -2 -1 ; 0 0 0 ; 1 2 1]*0.25 ;
Ix = conv2(Image1, Gx)
Iy = conv2(Image1, Gy);
Ixx=Ix.*Ix;
Iyy=Iy.*Iy;
Ixy=Ix.*Iy;

H=fspecial('gaussian',[7 7], 1);
Ix2=conv2(Ixx,H);
Iy2=conv2(Iyy,H);
Ixy=conv2(Ixy,H);

[rows cols]=size(Ix2);
Rmax=0;
k=0.04;
for i=1:rows
    for j=1:cols
        M=im2double([Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)]);
        R(i,j)=det(M)-k*(trace(M).^2);
        if(R(i,j)>Rmax)
        Rmax=R(i,j);
        end
    end
end
%thrsh=0.025
[rows cols]=size(R);
for i = 2:rows-1
    for j = 2:cols-1
        if(R(i,j)>thrsh)
        corners(i,j) = 160;
        end;
    end;
end;
[pos_x, pos_y] = find(corners==160);
imshow(Image1);
hold on;
plot(pos_x,pos_y,'bo');

