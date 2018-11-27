function [K, R, t, error, P] = runGoldStandard(xy, XYZ)

%normalize data points
[xy_n, XYZ_n, T, U] = normalization(xy,XYZ);

%compute DLT
[P_n] = dlt(xy_n, XYZ_n);

%minimize geometric error
p_n = [P_n(1,:) P_n(2,:) P_n(3,:)];
for i=1:20
    [p_n] = fminsearch(@fminGoldStandard, p_n, [], xy_n, XYZ_n, i/5, T, U);
end

P_n = [p_n(1:4);p_n(5:8);p_n(9:12)];

%denormalize camera matrix
P = T^-1*P_n*U;

%factorize camera matrix in to K, R and t
[K,R,C,t] = decompose(P);

%compute reprojection error
error = 0;
r_xy = [];
n = size(xy,2);
for i = 1:n
    r = P*XYZ(:,i);
    r_xy = [r_xy, r./r(end)];
    error = error+sum((r_xy(:,i)-xy(:,i)).^2);
end

end