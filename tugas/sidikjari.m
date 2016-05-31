clc;
clear all;

X1=[];
X2=[];
UJI=[];

O=5;
P=O-1;
r=O*O;

sdirectory = 'images';
namafile = dir([sdirectory  '/', ['sidikjari_', '*.bmp']]);
for z = 1:length(namafile)
    filename = [sdirectory '/' namafile(z).name];
    image = imread(filename);
    figure, imshow(image);

    R=image(:,:,1);
    G=image(:,:,2);
    B=image(:,:,3);

    %gray scale
    %gray=(0.333*R)+(0.333*G)+(0.333*B);
    gray=(0.299*R)+(0.548*G)+(0.114*B);
    %figure, imshow(gray);
    
    [m n]=size(gray);
    %invers
    for i=1:m,
        for j=1:n,
            cb(i,j)=255-gray(i,j);
        end
    end
    %figure, imshow(cb);
    
    %kontras
    for i=1:m,
        for j=1:n,
            cb1(i,j)=cb(i,j)*3;
            if(cb1(i,j) > 255)
                cb2(i,j)=255;
            else
                cb2(i,j)=cb1(i,j);
            end
        end
    end
    %figure, imshow(cb2);

    % Region Of Interest dengan tresholding nilai 0.2 
    % Melakukan tresholding, mengubah image ke biner 0 dan 1
    th = 0.5; bit1 = 0; bit2 = 1;
    Y_th  = threshold(cb2,th,bit1,bit2);
    %figure, imshow(Y_th);

    % Autocontras adjusts/enhances untuk level optimal
    capture=fautocontrast(cb);
    figure, imshow(capture);

    % Region Of Interest dengan tresholding nilai 0.2 
    % Melakukan tresholding, mengubah image ke biner 0 dan 1
    th = 0.5; bit1 = 0; bit2 = 1;
    Y_th2  = threshold(capture,th,bit1,bit2);
    figure, imshow(Y_th2);
    
    filename
    
    W=uint8(Y_th2);
    [o p]=size(W);

    D=[];
    c=0;
    for m=1:O:o
        for n=1:O:p
            a=0;
            b=0;
            if(((m+P) < o) && ((n+P) < p))
                for i=m:(m+P)
                    for j=n:(n+P)
                        W(i,j);
                        a=a+W(i,j);
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
    
    if(z == 1)
        X1=D;
    elseif(z == 2)
        X2=D;
	else
        UJI=D;
    end
    
end,

X1;
X2;
UJI;

% Euclidean
m1=(double(X1))';
m2=(double(X2))';
x=(double(UJI))';

xx11=(x-m1).^2;
xx1=sum(xx11)
xxw1=sqrt(abs(xx1))

xx12=(x-m2).^2;
xx2=sum(xx12)
xxw2=sqrt(abs(xx2))

if (xxw1 < xxw2)
    disp('uji, masuk dalam kelas 1');
else
    disp('uji, masuk dalam kelas 2');
end





