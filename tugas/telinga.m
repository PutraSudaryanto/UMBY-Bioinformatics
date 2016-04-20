clc;
clear all;

image=imread('images/101_small.bmp');
R=image(:,:,1);
G=image(:,:,2);
B=image(:,:,3);

%gray scale
%gray=(0.333*R)+(0.333*G)+(0.333*B);
gray=(0.299*R)+(0.548*G)+(0.114*B);

% Autocontras adjusts/enhances untuk level optimal
capture=fautocontrast(gray);
%figure, imshow(capture);

%(double) sqrt trouble
I=double(gray);

[k l]=size(I);
 
%edge detection sobel
for i=1:k-2
    for j=1:l-2
        %Sobel mask for x-direction:
        Gx=((2*I(i+2,j+1)+I(i+2,j)+I(i+2,j+2))-(2*I(i,j+1)+I(i,j)+I(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*I(i+1,j+2)+I(i,j+2)+I(i+2,j+2))-(2*I(i+1,j)+I(i,j)+I(i+2,j)));
        
        %W(i,j) = sqrt((-1*I((i-1),(j-1))-2*I(i,(j-1))-1*I((i+1),(j-1))+...
        %        1*I((i-1),(j+1))+2*I(i,(j+1))+1*I((i+1),(j+1))).^2+...
        %        (1*I((i-1),(j-1))+2*I((i-1),j)+1*I((i-1),(j+1))-...
        %        1*I((i+1),(j-1))-2*I((i+1),j)-1*I((i+1),(j+1))).^2);
		  
        %The gradient of the image
        %d(i,j)=abs(Gx)+abs(Gy);
        B(i,j)=(sqrt(Gx.^2+Gy.^2));
    end
end
d=B;
%figure,imshow(d); title('Sobel gradient'); 

d=uint8(d);
figure, imshow(d);