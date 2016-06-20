function [G] = adapmean(F, w, c)
% ADAPMEAN Melakukan pengambangan adaptif dengan menggunakan
%	 mean.
%	 F = Citra berskala keabuan
%	 w = ukura jendela
%	 c = nilai konstan
%
% Hasil: citra G
 
if nargin == 0
	disp('Penggunaan adapmean(Citra, ukuran, konstanta');
	return;
end
 
if nargin == 1
	w = 2;
	c = 0;
end
 
if nargin == 2
	c = 0;
end
 
% Lakukan pemrosesan citra
[m, n] = size(F);
 
delta = floor(w/2);
 
if c < 0
	G = zeros(m, n);   % Diasumsikan berlatarbelakang 0
else
	G = ones(m, n);	% Diasumsikan berlatarbelakang 1
end
 
F=double(F);
for y=1+delta : m-delta
	for x=1+delta : n-delta
		rerata = 0.0;
		jum = w * w;
		for p=1 : w
			for q=1 : w
				rerata = rerata + F(y-round(w/2)+p, ...
									x-round(w/2)+q);
			end
		end
		
		rerata = floor(rerata / jum) - c;
		
		if F(y,x) >= rerata
		   G(y, x) = 1;
		else
		   G(y, x) = 0;
		end
	end
end
