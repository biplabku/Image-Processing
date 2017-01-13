clc;
close all;
clear all;

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
%% formation of spike matrix of size 16 by 64
for K=1:2:64
      J=1;
      for J=1:2:64
          m(K,J)=1;
          m(K+1,J+1)=0;
      end
end
  [Q R]=qr(m);
  PH=zeros(16,64);
  P=randperm(64);
  K1=1;
  for l=1:16
      a=P(K1);
      for J=1:64
          PH(l,J)=Q(a,J);
      end
      J=1;
      K1=K1+1;
  end
%% gaussian matrix
p=1;
for X1=0:.0158:1
    F(p)=(1/sqrt(2*pi*(.5^2)))*exp(-((X1^2)/2*(.5)^2));
    p=p+1;
end
p=1;
G=zeros(64,64);
for i=1:64
    for j=1:64
        if i==j
            G(i,j)=F(p);
            p=p+1;
        else
            G(i,j)=0;
        end
    end
    j=1;
end
%% dft
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
 B=ctranspose(d);
 V1=B*G*d*DCT;
 
 
%% mutual coherence program 
p1=1;
c1=[];
for j1=1:64
    for j2=1:64
        if(j1~=j2)
    c1(p1)=(Q(:,j1)'* DCT(:,j2))/(norm(Q(:,j1))*norm(DCT(:,j2))); %before blurring
    c2(p1)=(Q(:,j1)'* V1(:,j2))/(norm(Q(:,j1))*norm(V1(:,j2)));   %after blurring     
        end
        p1=p1+1;
    end
    j2=1;
end
c3=max(abs(c1));%before blurring
c4=max(abs(c2));%after blurring