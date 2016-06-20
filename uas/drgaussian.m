function [G] = drgaussian(F, sigma, mu)
% DRGAUSSIAN Menghasilkan citra yang telah diberi derau
%	menggunakan Gaussian.
%	F = citra berskala keabuan
%	sigma = standar deviasi fungsi Gaussian
%	mu = rerata fungsi Gaussian
 
if nargin < 3
	mu = 0; % Nilai bawaan mu
end
 
if nargin < 2
	sigma = 1; % Nilai bawaan deviasi standar
end
 
[m, n] = size(F);
 
F = double(F);
for i=1 : m
	for j=1 : nc
		derau = randn * sigma + mu;
		G(i,j) = round(F(i, j) + derau);
		
		if G(i,j) > 255
			G(i,j) = 255;
		elseif G(i,j) < 0
			G(i,j) = 0;
		end
	end
end
 
G = uint8(G);
