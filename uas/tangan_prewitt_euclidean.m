% Telapak Tangan Kanan Bagian Dalam

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
namafile = dir([sdirectory  '/', ['tangan_small_', '*.bmp']]);
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
                        Pw(i,j);
                        a=a+Pw(i,j);
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

y1=(x1-m1).^2;
y11=sum(y1);
yy11=sqrt(abs(y11))

y2=(x1-m2).^2;
y21=sum(y2);
yy21=sqrt(abs(y21))

z1=(x2-m1).^2;
z11=sum(z1);
zz11=sqrt(abs(z11))

z2=(x2-m2).^2;
z21=sum(z2);
zz21=sqrt(abs(z21))

if (yy11 < yy21)
    disp('uji, masuk dalam kelas 1');
else
    disp('uji, masuk dalam kelas 2');
end

if (zz11 < zz21)
    disp('uji, masuk dalam kelas 1');
else
    disp('uji, masuk dalam kelas 2');
end