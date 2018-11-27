% Exervice 2
%
close all;
clear all;

%IMG_NAME = 'images/image001.jpg';
IMG_NAME = 'images/image002.jpg';

%This function displays the calibration image and allows the user to click
%in the image to get the input points. Left click on the chessboard corners
%and type the 3D coordinates of the clicked points in to the input box that
%appears after the click. You can also zoom in to the image to get more
%precise coordinates. To finish use the right mouse button for the last
%point.
%You don't have to do this all the time, just store the resulting xy and
%XYZ matrices and use them as input for your algorithms.

%[xy XYZ] = getpoints(IMG_NAME);

% Image 001
% xy = 1.0e+03 * [  0.7338    0.1977    0.1017    0.7112    1.5308    1.4590;
%                   0.8765    1.0982    0.0940    0.1907    0.0688    1.0964;
%                   1e-03     1e-03     1e-03     1e-03     1e-03     1e-03];

% XYZ = [0    0.1640    0.1640         0         0         0;
%        0         0         0         0    0.2050    0.2050;
%        0         0    0.2050    0.2050    0.2050         0;
%        1         1         1         1         1         1];

% xy_p = 1.0e+03 * [0.1977    0.3666    0.5140    0.6239    0.7338    0.8414    0.9607    1.0964    1.2648    1.4590   0.1724   0.3514    0.5046    0.6225    0.7262    0.8394    0.9596    1.1011    1.2708    1.4736   0.1561    0.3362    0.4882    0.6145    0.7221    0.8414    0.9631    1.1081    1.2765    1.4870   0.1350    0.3268    0.4835    0.6099    0.7198    0.8391    0.9654    1.1104    1.2882    1.5011   0.1017    0.2972    0.4674    0.5956    0.7112    0.8310    0.9739    1.1231    1.3143    1.5308      0.1144    0.3128    0.4720    0.6030    0.7172    0.8370    0.9681    1.1197    1.3013    1.5184;
%                   1.0982    1.0332    0.9678    0.9186    0.8765    0.9023    0.9397    0.9818    1.0356    1.0964   0.9233   0.8693    0.8221    0.7844    0.7537    0.7702    0.7962    0.8292    0.8669    0.9164   0.7292    0.6941    0.6637    0.6379    0.6169    0.6286    0.6449    0.6660    0.6894    0.7151   0.5327    0.5163    0.4999    0.4906    0.4812    0.4812    0.4882    0.4952    0.5023    0.5116   0.0940    0.1255    0.1508    0.1718    0.1907    0.1760    0.1571    0.1318    0.1024    0.0688      0.3141    0.3253    0.3290    0.3328    0.3384    0.3309    0.3253    0.3159    0.3047    0.2897;
%                   1.0e-03   1.0e-03   1.0e-03  1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03  1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03  1.0e-03   1.0e-03   1.0e-03  1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03  1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03   1.0e-03     1e-03     1e-03     1e-03     1e-03     1e-03     1e-03     1e-03     1e-03     1e-03     1e-03];


%Image 002
xy = 1.0e+03 *[0.0429  0.6884  1.5139  0.1770  0.6807  1.3369;
               1.0355  1.0171  0.9950  0.0807  0.3535  0.0807;
               1.0e-03 1.0e-03 1.0e-03 1.0e-03 1.0e-03 1.0e-03];

XYZ = [  0.1640    0         0     0.1640         0         0;
         0         0    0.2050          0         0    0.2050;
         0         0         0     0.2050    0.2050    0.2050;
         1         1         1         1          1         1];


XYZ_p = zeros(4,60);
k = 1;
for i = 1:6
    for j = 1:10
        if j <= 5
           XYZ_p(:,k) = [-(j-5)*0.041;0;(i-1)*0.041;1];
        else 
           XYZ_p(:,k) = [0;(j-5)*0.041;(i-1)*0.041;1];
        end
        k = k+1;
    end
end

% === Task 2 DLT algorithm ===

[K, R, t, error, P] = runDLT(xy, XYZ);
%plot of chosen points and reprojected points
figure(1);
img = imread(IMG_NAME);
imshow(img, []);
hold on;
plot(xy(1,:),xy(2,:), 'yo');
%plot(xy_p(1,:),xy_p(2,:),'kx');

xy_dlt = P*XYZ_p;
m = size(xy_dlt,2);
for i = 1:m
    xy_dlt(:,i) = xy_dlt(:,i)/xy_dlt(end,i);
end
plot(xy_dlt(1,:),xy_dlt(2,:),'rd');


% === Task 3 Gold Standard algorithm ===

[K_gs, R_gs, t_gs, error_gs, P_gs] = runGoldStandard(xy, XYZ);
%plot of chosen points and reprojected points
xy_gs = P_gs*XYZ_p;
m = size(xy_dlt,2);
for i = 1:m
    xy_gs(:,i) = xy_gs(:,i)/xy_gs(end,i);
end

plot(xy_gs(1,:),xy_gs(2,:),'gs');

% === Bonus: Gold Standard algorithm with radial distortion estimation ===

%[K, R, t, error] = runGoldStandardRadial(xy, XYZ);

