function [Kontur] = get_contour(BW)
% GET_CONTOUR Berfungsi untuk memperoleh kontur eksternal 
%	 dari suatu citra biner BW
%	 Hasil berupa Kontur yang berisi pasangan X dan Y dari setiap
%	 piksel yang menyusun kontur. Kolom 1 menyatakan Y dan
%	 kolom 2 menyatakan X
  
% Peroleh kontur
 
% Proses rantai kode

% Arah sebelumnya ke sekarang
DPC = [0, 1, 2, 3, 4, 5, 6, 7]; 

% Arah sekarang ke sebelumnya
DCP = [4, 5, 6, 7, 0, 1, 2, 3]; 

% Arah  0   1   2   3   4   5  6  7  
%	   terhadap posisi sekarang
XP =   [1,  1,  0, -1, -1, -1, 0, 1];
YP =   [0, -1, -1, -1,  0,  1, 1, 1];
	 
% Peroleh titik awal
[tinggi, lebar] = size(BW);
	 
% Cari titik awal
x1 = 1;
y1 = 1;
selesai = false;
for baris = 1 : tinggi
	for kolom = 1 :lebar
		if BW(baris, kolom) == 1
			y1 = baris;
			x1 = kolom-1;
			selesai = true;
 
			Kontur(1,1) = y1;		   
			Kontur(1,2) = x1;
			break;
		end	 
	end
		
	if selesai
		break;
	end   
end
 
% Proses piksel kedua 
for i = 4 : 7
	if BW(y1+YP(i+1), x1+XP(i+1)) == 0
		dcn = i; % Arah sekarang ke sesudahnya
		break;
	end
end
 
yberikut = y1 + YP(dcn+1);
xberikut = x1 + XP(dcn+1);
 
indeks = 2; % Indeks kedua
 
% Proses peletakan piksel kedua dan seterusnya 
%	ke array Kontur
while (yberikut ~= Kontur(1,1)) || (xberikut ~= Kontur(1,2))
	Kontur(indeks,1) = yberikut;
	Kontur(indeks,2) = xberikut;
	dpc = dcn;  % Arah sebelum ke sekarang diisi
				% dengan arah sekarang ke berikutnya
 
	% Cari piksel berikutnya
	for r = 0 : 7
		dcp = DCP(dpc+1);
		de = rem(dcp+r, 8);
		di = rem(dcp+r+1, 8);
 
		cxe = Kontur(indeks,2) + XP(de+1);
		cye = Kontur(indeks,1) + YP(de+1);
		cxi = Kontur(indeks,2) + XP(di+1);
		cyi = Kontur(indeks,1) + YP(di+1);
	   
		if (BW(cye, cxe) == 0) && (BW(cyi, cxi) == 1)
			yberikut = cye;
			xberikut = cxe;
			break;
		end
	end
	
	% Naikkan indeks
	indeks = indeks + 1;
end
