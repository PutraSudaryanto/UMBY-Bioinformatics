% Jari Tangan Kanan Bagian Dalam

clc;
clear all;

X1=[];
X2=[];
UJI1=[];
UJI2=[];

O=5;
P=O-1;
r=O*O;

sdirectory = 'images';
namafile = dir([sdirectory  '/', ['jari_', '*.bmp']]);
for z = 1:length(namafile)
    filename = [sdirectory '/' namafile(z).name];
    img = imread(filename);
    %figure, imshow(img);
    
    R=img(:,:,1);
    G=img(:,:,2);
    B=img(:,:,3);

	%gray scale
    gray=(0.299*R)+(0.586*G)+(0.114*B);
    %gray=(0.333*R)+(0.333*G)+(0.333*B);
    %figure, imshow(gray);
    imwrite(gray, [sdirectory '/', ['gray_', namafile(z).name]]);
    
    Ro = roberts(gray);
    imwrite(Ro, [sdirectory '/', ['roberts_', namafile(z).name]]);
    
    So = sobel(gray);
    imwrite(So, [sdirectory '/', ['sobel_', namafile(z).name]]);
    
    Pw = prewitt(gray);
    imwrite(Pw, [sdirectory '/', ['prewitt_', namafile(z).name]]);
    
    Fr = freichen(gray);
    imwrite(Fr, [sdirectory '/', ['freichen_', namafile(z).name]]);
    
    Ko = kompas(gray);
    imwrite(Ko, [sdirectory '/', ['kompas_', namafile(z).name]]);
    
    [o p]=size(Pw);

    D=[];
    c=0;
    for m=1:O:o
        for n=1:O:p
            a=0;
            b=0;
            if(((m+P) < o) && ((n+P) < p))
                for i=m:(m+P)
                    for j=n:(n+P)
                        Ko(i,j);
                        a=a+Ko(i,j);
                    end
                end
                b=a/r;
                c=c+1;
                D=[D b];
            end
        end
    end
    D;
    figure, plot(D);
    
    filename
    if(z == 1)
        X1=D;
    elseif(z == 2)
        X2=D;
    elseif(z == 3)
        UJI1=D;
	else
        UJI2=D;
    end
end,

X1;
X2;
UJI1;
UJI2;

% Euclidean
m1=(double(X1))';
m2=(double(X2))';
x1=(double(UJI1))';
x2=(double(UJI2))';

A1=(x1-m1).^2;
A11=sum(A1);
AA11=sqrt(abs(A11))

A2=(x1-m2).^2;
A21=sum(A2);
AA21=sqrt(abs(A21))

B1=(x2-m1).^2;
B11=sum(B1);
BB11=sqrt(abs(B11))

B2=(x2-m2).^2;
B21=sum(B2);
BB21=sqrt(abs(B21))

if (AA11 < AA21)
    disp('uji, masuk dalam kelas 1');
else
    disp('uji, masuk dalam kelas 2');
end

if (BB11 < BB21)
    disp('uji, masuk dalam kelas 1');
else
    disp('uji, masuk dalam kelas 2');
end