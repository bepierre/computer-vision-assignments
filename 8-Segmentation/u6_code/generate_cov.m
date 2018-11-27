% Generate initial values for the K
% covariance matrices

function cov = generate_cov(Lmax,Lmin,amax,amin,bMax,bmin,K)
rangeLab = [Lmax-Lmin,amax-amin,bMax-bmin];
cov = zeros(3,3,K);
for i = 1:K
    cov(:,:,i) = diag(rangeLab);
end

end