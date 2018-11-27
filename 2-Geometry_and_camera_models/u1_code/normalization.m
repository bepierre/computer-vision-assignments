function [xyn, XYZn, T, U] = normalization(xy, XYZ)

%data normalization
%first compute centroid
xy_centroid = [mean(xy(1,:));mean(xy(2,:))];
XYZ_centroid = [mean(XYZ(1,:));mean(XYZ(2,:));mean(XYZ(3,:))];

n = size(xy,2);

%then, compute scale
s_2D = mean(sqrt((xy(1,:)-xy_centroid(1)*ones(1,n)).^2+(xy(2,:)-xy_centroid(2)*ones(1,n)).^2))/(sqrt(2));
s_3D = mean(sqrt((XYZ(1,:)-XYZ_centroid(1)*ones(1,n)).^2+(XYZ(2,:)-XYZ_centroid(2)*ones(1,n)).^2+(XYZ(3,:)-XYZ_centroid(3)*ones(1,n)).^2))/(sqrt(3));

%create T and U transformation matrices
T = [s_2D, 0, xy_centroid(1);
     0, s_2D, xy_centroid(2);
     0, 0, 1]^-1;
     
U = [s_3D, 0, 0, XYZ_centroid(1);
     0, s_3D, 0, XYZ_centroid(2);
     0, 0, s_3D, XYZ_centroid(3);
     0, 0, 0, 1]^-1;

%and normalize the points according to the transformations
xyn = T*xy;
XYZn = U*XYZ;


end