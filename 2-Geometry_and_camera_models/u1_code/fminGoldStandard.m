function f = fminGoldStandard(p, xy, XYZ, w, T, U)

%reassemble P
P = [p(1:4);p(5:8);p(9:12)];
Pd = T^-1*P*U;

[~,R] = qr(eye(3)/Pd(1:3,1:3));
K = eye(3)/R;
%compute squared geometric error
xy_p = P*XYZ;
n = size(xy,2);
error = 0;
for i = 1:n
    error = error + sum((xy(:,i)-xy_p(:,i)./xy_p(end,i)).^2);
end

%compute cost function value
f = error + w*K(1,2)^2+w*(K(1,1)-K(2,2))^2;
%f = error;
end