% Compute the essential matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences 3xn matrices
%
% Output
% 	Eh 			Essential matrix with the det F = 0 constraint and the constraint that the first two singular values are equal
% 	E 			Initial essential matrix obtained from the eight point algorithm
%

function [Eh, E] = essentialMatrix(x1s, x2s)
%normalization
[x1s, T1] = normalizePoints2d(x1s);
[x2s, T2] = normalizePoints2d(x2s);

n = size(x1s, 2);
A = [];
for i = 1:n
    A = [A; x2s(1,i) * x1s(1,i), x2s(1,i) * x1s(2,i), x2s(1,i), ... 
            x2s(2,i) * x1s(1,i), x2s(2,i) * x1s(2,i), x2s(2,i), ...
            x1s(1,i), x1s(2,i), 1];
end

%Find F
[~,~,V] = svd(A);
Evec = V(:,end);
En = reshape(Evec,[3,3])';
E = T2'*En*T1; 

%Enforce the singularity constraint
[U,S,V] = svd(E);
S = diag([(S(1,1)+S(2,2))/2,(S(1,1)+S(2,2))/2,0]);
Eh = U*S*V';

end