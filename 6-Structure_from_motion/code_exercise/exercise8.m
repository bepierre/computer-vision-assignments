% =========================================================================
% Exercise 8
% =========================================================================
clear all
close all

% Initialize VLFeat (http://www.vlfeat.org/)
% add folder to path and call vl_setup;
run vlfeat\toolbox\vl_setup

%K Matrix for house images (approx.)
K = [  670.0000     0     393.000
         0       670.0000 275.000
         0          0        1];

ransac_t = 0.05;
     
%Load images
imgName1 = '../data/house.000.pgm';
imgName2 = '../data/house.004.pgm';

img1 = single(imread(imgName1));
img2 = single(imread(imgName2));

%extract SIFT features and match
[fa, da] = vl_sift(img1);
[fb, db] = vl_sift(img2);

%don't take features at the top of the image - only background
filter = fa(2,:) > 100;
fa = fa(:,find(filter));
da = da(:,find(filter));

[matches_12, ~] = vl_ubcmatch(da, db);

%% Compute essential matrix and projection matrices and triangulate matched points
%use 8-point ransac or 5-point ransac - compute (you can also optimize it to get best possible results)
%and decompose the essential matrix and create the projection matrices
x1_in = makehomogeneous(fa(1:2,matches_12(1,:)));
x2_in = makehomogeneous(fb(1:2,matches_12(2,:)));

% find funadamental matrix
[F, inliers_12] = ransacfitfundmatrix(x1_in, x2_in, 0.00012);
outliers_12 = setdiff(find(matches_12(1,:)),inliers_12);
showInliersOutliers(img1, fa(1:2, matches_12(1,inliers_12)), fa(1:2, matches_12(1,outliers_12)), img2, fb(1:2, matches_12(2,inliers_12)), fb(1:2, matches_12(2,outliers_12)), 1)
E = K'*F*K;

% get inliers and calibrate points
x1_in = x1_in(:,inliers_12);
x2_in = x2_in(:,inliers_12);
x1_in_calibrated = K\x1_in;
x2_in_calibrated = K\x2_in;

% camera projection matrices
Ps{1} = eye(4);
Ps{2} = decomposeE(E, x1_in_calibrated, x2_in_calibrated);

%triangulate the inlier matches with the computed projection matrix
[XS_12, ~] = linearTriangulation(Ps{1}, x1_in_calibrated, Ps{2}, x2_in_calibrated);

%% view 3 
% load image and extract sift features
imgName3 = '../data/house.001.pgm';
img3 = single(imread(imgName3));
[fc, dc] = vl_sift(img3);

% get inlier matches and match them with new view
fa_in = fa(1:2, matches_12(1,inliers_12));
da_in = da(:,matches_12(1,inliers_12));
[matches_13, ~] = vl_ubcmatch(da_in, dc);

% calibrate
x3_calibrated=K\makehomogeneous(fc(1:2,matches_13(2,:)));

%run 6-point ransac
[Ps{3}, inliers_13] = ransacfitprojmatrix(x3_calibrated, XS_12(:,matches_13(1,:)), ransac_t);
outliers_13 = setdiff(find(matches_13(1,:)),inliers_13);
showInliersOutliers(img1, fa_in(1:2, matches_13(1,inliers_13)), fa_in(1:2, matches_13(1,outliers_13)), img3, fc(1:2, matches_13(2,inliers_13)), fc(1:2, matches_13(2,outliers_13)), 2)

% make sure projection matrix is correctly oriented
if (det(Ps{3}(1:3,1:3)) < 0 )
    Ps{3}(1:3,1:3) = -Ps{3}(1:3,1:3);
    Ps{3}(1:3, 4) = -Ps{3}(1:3, 4);
end

%triangulate the inlier matches with the computed projection matrix
[XS_13, ~] = linearTriangulation(Ps{1}, x1_in_calibrated(:,matches_13(1,inliers_13)), Ps{3}, x3_calibrated(:,inliers_13(1,:)));

%% view 4
% load image and extract sift features
imgName4 = '../data/house.002.pgm';
img4 = single(imread(imgName4));
[fd, dd] = vl_sift(img4);

% get inlier matches and match them with new view
fa_in = fa(1:2, matches_12(1,inliers_12));
da_in = da(:,matches_12(1,inliers_12));
[matches_14, ~] = vl_ubcmatch(da_in, dd);

% calibrate
x4_calibrated=K\makehomogeneous(fd(1:2,matches_14(2,:)));

%run 6-point ransac
[Ps{4}, inliers_14] = ransacfitprojmatrix(x4_calibrated, XS_12(:,matches_14(1,:)), ransac_t);
outliers_14 = setdiff(find(matches_14(1,:)),inliers_14);
showInliersOutliers(img1, fa_in(1:2, matches_14(1,inliers_14)), fa_in(1:2, matches_14(1,outliers_14)), img4, fd(1:2, matches_14(2,inliers_14)), fd(1:2, matches_14(2,outliers_14)), 3)

% make sure projection matrix is correctly oriented
if (det(Ps{4}(1:3,1:3)) < 0 )
    Ps{4}(1:3,1:3) = -Ps{4}(1:3,1:3);
    Ps{4}(1:3, 4) = -Ps{4}(1:3, 4);
end

%triangulate the inlier matches with the computed projection matrix
[XS_14, ~] = linearTriangulation(Ps{1}, x1_in_calibrated(:,matches_14(1,inliers_14)), Ps{4}, x4_calibrated(:,inliers_14(1,:)));

%% view 5
% load image and extract sift features
imgName5 = '../data/house.003.pgm';
img5 = single(imread(imgName5));
[fe, de] = vl_sift(img5);

% get inlier matches and match them with new view
fa_in = fa(1:2, matches_12(1,inliers_12));
da_in = da(:,matches_12(1,inliers_12));
[matches_15, ~] = vl_ubcmatch(da_in, de);

% calibrate
x5_calibrated=K\makehomogeneous(fe(1:2,matches_15(2,:)));

%run 6-point ransac
[Ps{5}, inliers_15] = ransacfitprojmatrix(x5_calibrated, XS_12(:,matches_15(1,:)), ransac_t);
outliers_15 = setdiff(find(matches_15(1,:)),inliers_15);
showInliersOutliers(img1, fa_in(1:2, matches_15(1,inliers_15)), fa_in(1:2, matches_15(1,outliers_15)), img5, fe(1:2, matches_15(2,inliers_15)), fe(1:2, matches_15(2,outliers_15)), 4)
% make sure projection matrix is correctly oriented
if (det(Ps{5}(1:3,1:3)) < 0 )
    Ps{5}(1:3,1:3) = -Ps{5}(1:3,1:3);
    Ps{5}(1:3, 4) = -Ps{5}(1:3, 4);
end

%triangulate the inlier matches with the computed projection matrix
[XS_15, ~] = linearTriangulation(Ps{1}, x1_in_calibrated(:,matches_15(1,inliers_15)), Ps{5}, x5_calibrated(:,inliers_15(1,:)));

%% epipolar geometry
figure(10)
subplot(1,2,1);
% display image
imshow(img1, []);
hold on
% plot matches
plot(x1_in(1,:),x1_in(2,:), '*r');
% draw epipolar lines in img 1
for k = 1:size(x1_in,2)
    drawEpipolarLines(F'*x1_in(:,k), img1, 'b');
end

subplot(1,2,2);
% display image
imshow(img2, []);
hold on
% plot matches
plot(x2_in(1,:),x2_in(2,:), '*r');
% draw epipolar lines in img 2
for k = 1:size(x2_in,2)
    drawEpipolarLines(F*x2_in(:,k), img2, 'b');
end
%% triangulated points and cameras
fig = 50;
figure(fig);

%use plot3 to plot the triangulated 3D points
hold on
plot3(XS_12(1,:),XS_12(2,:),XS_12(3,:),'r.')
plot3(XS_13(1,:),XS_13(2,:),XS_13(3,:),'g.')
plot3(XS_14(1,:),XS_14(2,:),XS_14(3,:),'b.')
plot3(XS_15(1,:),XS_15(2,:),XS_15(3,:),'y.')

%draw cameras
drawCameras(Ps, fig);

%% dense reconstruction
x5_in = makehomogeneous(fe(1:2,matches_15(2,inliers_15)));
depth = zeros(size(img5)); 
for i = 1:size(x5_in,2)
    depth(round(x5_in(2,i)),round(x5_in(1,i))) = XS_15(3,i);
end
img = cat(3,img5,img5,img5);
img = img/255;
%depth = cat(3,depth,depth);
create3DModel(depth,img, 60)