% Telapak Tangan Kanan Bagian Dalam

clc;
clear all;

X1=[];
X2=[];
UJI1=[];
UJI2=[];

H1 = [-1 -1 -1; 2 2 2; -1 -1 -1]; 

O=5;
P=O-1;
r=O*O;

sdirectory = 'images';
namafile = dir([sdirectory  '/', ['kaki_', '*.bmp']]);
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
    %imwrite(gray, [sdirectory '/', ['gray_', namafile(z).name]]);
    
	%(double) sqrt trouble
	I=double(gray);
    
    [k l]=size(I);
    
    G = deteksi(gray, 100);
    imshow(1-G);
    
    G = deteksi(img, H1); 
    imshow(G,[0 1]);
    
end,