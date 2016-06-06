clear all;
clc;

Y=[1 1 1 2 1;
   1 1 1 2 2;
   1 1 1 3 3;
   2 2 2 3 3;
   2 2 2 3 2]

[m,n]=size(Y)

for i=1:3,  %3 itu space yang digunakan dalam matrik Y hanya 1-3, jika 0-3 maka space = 4
    for j=1:3,
        matcos(i,j)=0;
    end,
end,

for i=1:m,
    for j=1:n-1,
        i1=Y(i,j);
        i2=Y(i,j+1);
        matcos(i1,i2)=matcos(i2,i1)+1;
    end,
end,

matcos

%output :
% 1-1 = 6 buah
% 1-2 = 2 buah
% dst


g=matcos;
H=0;
[m1, n1]=size(g);
for a=1:m1,
    for b=1:n1,
        H=H+g(a,b)^2;
    end,
end,
H

K=0;
[m1, n1]=size(g);
for a=1:m1,
    for b=1:n1,
        K=K+(a-b)^2*g(a,b);
    end,
end,
K