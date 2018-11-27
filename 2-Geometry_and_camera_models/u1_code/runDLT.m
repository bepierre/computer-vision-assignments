function [K, R, t, error, P] = runDLT(xy, XYZ)

%normalize data points
%xy_normalized = [];
%XYZ_normalized = [];
[xy_n, XYZ_n, T, U] = normalization(xy,XYZ);

%compute DLT
[P_n] = dlt(xy_n, XYZ_n);

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