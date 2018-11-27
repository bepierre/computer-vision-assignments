% Generate initial values for mu
% K is the number of segments

function mu = generate_mu(Lmax,Lmin,amax,amin,bmax,bmin,K)

mu = zeros(K,3);
% spreading equally in L*a*b space
stepL = (Lmax - Lmin)/(K+1);
stepa = (amax - amin)/(K+1);
stepb = (bmax - bmin)/(K+1);

for i = 1:K
    mu(i,:) = [i*stepL,i*stepa,i*stepb];
end

end
