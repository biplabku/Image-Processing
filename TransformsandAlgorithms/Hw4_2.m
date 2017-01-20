%% region merging segmentation
I = imread('UBcampus.jpg');
im = im2uint8(rgb2gray(I));
im = im2double(im);
[r, c]=size(im);
newim = zeros(r+r, c+c);
[r1, c1] = size(newim);
tmp1 = 0;
tmp2 = 0;
for i = 1:1:r
    for j = 1:1:c
        newim(i + tmp1,j + tmp2) = im(i , j);
        tmp2 = tmp2 + 1;
    end
    tmp1 =tmp1 + 1; 
    tmp2 =0;
end
%% for crack edges input the difference of the adjacent image pixels in alternate places
for i = 1:2:r1
    for j = 2:2:c1
        if(j == c1)
            newim(i,j) = ((newim(i,1) - newim(i,j - 1) ));
        else
            newim(i,j) =( ( newim(i,j + 1)- newim(i,j - 1) ));
        end
    end
end
for i = 2:2:r1
    for j = 1:1:c1 
       if(i == r1 || j == c1)
            newim(i,j) =( ( newim(1,1) - newim(i - 1,j)));
       else
            newim(i,j) =( (newim(i + 1,j + 1) - newim(i - 1,j) ));
       end 
    end
end
%===========crack image with double the size of image===================
% figure
% imshow(newim)

% setting a threshold of the image
T1 = graythresh(newim);
% 
% making the values of the image to zero if it is less than the 
% threshold only considering the crack image pixels 
for i = 1:2:r1
    for j = 2:2:c1
        if(newim(i, j) < T1)
            newim(i, j) = 0;
        else
            newim(i, j) = 1;
        end 
    end
end
for i = 2:2:r1
    for j = 1:1:c1
        if(newim(i, j) < T1)
            newim(i, j) = 0;
        else
            newim(i, j) = 1;
        end 
    end
end

figure
imshow(newim)




% region labelling and segmentation
inpt = PadZero(newim, 3);
reg = zeros(size(newim));
reg(1,1) = 1;
for i = 1:2:r1
    for j = 1:2:c1 
        if(i == 1 && j == 1) % 1st element top left
            if(inpt(i + 1, j) == 0)
                reg(i + 1 ,j) = 1;
            elseif(inpt(i, j + 1) == 0)
                reg(i  ,j + 1) = 1;
            elseif(inpt(i + 1, j) ~=0 ||inpt(i, j + 1) == 0)
                reg(i + 1 ,j) = 1;
            end
        elseif( i == 1 && j > 1)
            if(inpt(i, j -1) == 0) %left
                label = 1;
            elseif(inpt(i + 1, j ) == 0) % down
                label = 1;
            elseif(inpt(i , j + 1) == 0) % right
                label = 1;
            end
        elseif(i == r1 && j == 1 ) %bottom left
            if(inpt(i - 1, j) == 0)
                label = 1;
            elseif(inpt(i, j + 1) == 0)
                label = 1;
            end
        elseif(i == r1 && j == c1) %% bottom right
             if(inpt(i - 1, j) == 0)
                label = 1;
            elseif(inpt(i, j - 1) == 0)
                label = 1;
             end 
        elseif(i == 1 && j == c1)%% top right
            if(inpt(i, j - 1) == 0)
                label = 1;
            elseif(inpt(i + 1, j) == 0)
                label = 1;
            end
        elseif(i == r1 && j > 1)
            if(inpt(i, j - 1) == 0) %left
                label = 1;
            elseif(inpt(i - 1, j ) == 0) % up
                label = 1;
            elseif(inpt(i, j + 1) == 0) % right
                label = 1;
            end
        else %% if r1 >1 and c1 >1
            if(inpt(i - 1, j) == 0 )
            elseif(inpt(i + 1, j) == 0)
                
            elseif(inpt(i, j - 1) == 0)
                
            elseif(inpt(i, j + 1) == 0)
                
            end
        end
    end
end
                

function y = marklabel(x, y ,reg)

end











