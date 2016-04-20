% Fungsi AUTOCONTRAST  untuk otomatisasi adjusts contrast menjadi level optimum.
function [output_img]=fautocontrast(input_img)

low_limit=0.008;
up_limit=0.992;
img=input_img;
[m1 n1 r1]=size(img);
img=double(img);

% Kalkulasi vmin dan vmax
for k=1:r1
    arr=sort(reshape(img(:,:,k),m1*n1,1));
    v_min(k)=arr(ceil(low_limit*m1*n1));
    v_max(k)=arr(ceil(up_limit*m1*n1));
end

if r1==3
    v_min=rgb2ntsc(v_min);
    v_max=rgb2ntsc(v_max);
end

img=(img-v_min(1))/(v_max(1)-v_min(1));
output_img=img;