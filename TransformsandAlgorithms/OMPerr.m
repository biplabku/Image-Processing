function [A]=OMPerr(G2,VV1,D,X,errorGoal); 
%=============================================
% Sparse coding of a group of signals based on a given 
% dictionary and specified number of atoms to use. 
% input arguments: D - the dictionary
%                  X - the signals to represent
%                  errorGoal - the maximal allowed representation error for
%                  each siganl.
% output arguments: A - sparse coefficient matrix.
%=============================================
D2=G2*VV1;
[n,P]=size(X);
[n,K]=size(D);
E2 = errorGoal^2*n;
maxNumCoef = n/2;
A = sparse(size(D,2),size(X,2));
for k=1:1:P,
    a=[];
    x=X(:,k);
    residual=x;
  
	indx = [];
	a = [];
	currResNorm2 = sum(residual.^2);
	j = 0;
    while currResNorm2>E2 && j < maxNumCoef,
		j = j+1;
       dddd= size(D2)
       rrrrr=size(residual)
 
        proj=D2*residual;
  % dddddd=size(D)
        pos=find(abs(proj)==max(abs(proj)));
        pos=pos(1);
        indx(j)=pos;
        H=D;
        a=pinv(H(:,indx(1:j)))*x;
        residual=x-H(:,indx(1:j))*a;
		currResNorm2 = sum(residual.^2);
   end;
   if (length(indx)>0)
       A(indx,k)=a;
   end
end;
return;

