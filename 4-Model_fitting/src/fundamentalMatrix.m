% Compute the fundamental matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences
%
% Output
% 	Fh 			Fundamental matrix with the det F = 0 constraint
% 	F 			Initial fundamental matrix obtained from the eight point algorithm
%
function [Fh, F] = fundamentalMatrix(x1s, x2s)
%normalization
[nx1s, T1] = normalizePoints2d(x1s);
[nx2s, T2] = normalizePoints2d(x2s);

n = size(x1s, 2);
A = [];
for i = 1:n
    A = [A; nx2s(1,i) * nx1s(1,i), nx2s(1,i) * nx1s(2,i), nx2s(1,i), ... 
            nx2s(2,i) * nx1s(1,i), nx2s(2,i) * nx1s(2,i), nx2s(2,i), ...
            nx1s(1,i), nx1s(2,i), 1];
end

%Find F
[~,~,V] = svd(A);
Fvec = V(:,end);
Fn = reshape(Fvec,[3,3])';
F = T2'*Fn*T1;

%Enforce the singularity constraint
[U,S,V] = svd(F);
S(3,3) = 0;
Fh = U*S*V';

end