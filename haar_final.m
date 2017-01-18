clc
close all;
clear all;
H=zeros(64,64);
l=1;
for k=1:2:64
   for i=1:2
        for j=1:2
            if((i==2)&&(j==2))
               H(i+k-1,j+l-1)=-1/sqrt(2);
            else
               H(i+k-1,j+l-1)=1/sqrt(2);
            end
        end
   end
   l=l+2;
end
display(H);
d=sqrt(sum(H.^2,1));
    for j=1:64 %selecting each column one by one
        for k=1:8
            if((H(k,j)==0)| d(k)==0)
                H(k,j)=0;
            else
                H(k,j)=H(k,j)/d(k);
            end
        end
    end
% x=[ 2 3 4 5 6 7 8 9];
% p=H*x';
% p=p';
display(H);
% k=0;
% for i=1:length(p)
%     if(rem(i,2)==1)
%         a(k+1)=p(i);
%         k=k+1;
%     else
%         a((length(p)/2)+k)=p(i);
%     end
% end
% display(a);% final output after arranging it


