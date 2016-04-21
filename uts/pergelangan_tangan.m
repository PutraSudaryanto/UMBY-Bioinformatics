% Pergelangan Tangan

clc;
clear all;

X1=[];
X2=[];
UJI=[];

O=5;
P=O-1;
r=O*O;

sdirectory = 'images';
namafile = dir([sdirectory  '/', ['tangan_', '*.bmp']]);
for z = 1:length(namafile)
    filename = [sdirectory '/' namafile(z).name];
    img = imread(filename);
    %figure, imshow(img);
    
    R=img(:,:,1);
    G=img(:,:,2);
    B=img(:,:,3);

    gray=(0.299*R)+(0.586*G)+(0.114*B);
    %gray=(0.333*R)+(0.333*G)+(0.333*B);
    %figure, imshow(gray);
    %imwrite(gray, [sdirectory '/', ['gray_', namafile(z).name]]);

	%(double) sqrt trouble
	I=double(gray);
    
    [k l]=size(I);
 
    %edge detection sobel
    %for x=2:k-1
    %    for y=2:l-1
    for x=1:k-2
        for y=1:l-2       
            %W(x,y) = sqrt((-1*I((x-1),(y-1))-2*I(x,(y-1))-1*I((x+1),(y-1))+...
            %        1*I((x-1),(y+1))+2*I(x,(y+1))+1*I((x+1),(y+1))).^2+...
            %        (1*I((x-1),(y-1))+2*I((x-1),y)+1*I((x-1),(y+1))-...
            %        1*I((x+1),(y-1))-2*I((x+1),y)-1*I((x+1),(y+1))).^2);  

            %Sobel mask for x-direction:
            Gx=((2*I(x+2,y+1)+I(x+2,y)+I(x+2,y+2))-(2*I(x,y+1)+I(x,y)+I(x,y+2)));
            %Sobel mask for y-direction:
            Gy=((2*I(x+1,y+2)+I(x,y+2)+I(x+2,y+2))-(2*I(x+1,y)+I(x,y)+I(x+2,y)));
            
            %The gradient of the image
            %d(i,j)=abs(Gx)+abs(Gy);
            
            B(x,y)=(sqrt(Gx.^2+Gy.^2));
            W(x,y)=B(x,y);
        end
    end
    %figure, imshow(W);    
    W=uint8(W);
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
    %figure, plot(D);
    
    [a b]=size(D);
    t=[1:c];    
    
    filename
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

[c d]=size(m1);
[c d]=size(m2);
[c d]=size(x);

x11=x-m1;
x1=x11'*x11;
xw1=abs(sqrt(x1));

x12=x-m2;
x2=x12'*x12;
xw2=abs(sqrt(x2));

if (xw1 < xw2)
    disp('uji, masuk dalam kelas 1');
else
    disp('uji, masuk dalam kelas 2');
end

