% =========================================================================
% Exercise 4
% =========================================================================

%don't forget to initialize VLFeat
run vlfeat\toolbox\vl_setup

%Load images
dataset = 1;
if(dataset==1)
	imgName1 = 'images/ladybug_Rectified_0768x1024_00000064_Cam0.png';
	imgName2 = 'images/ladybug_Rectified_0768x1024_00000080_Cam0.png';
elseif(dataset==2)
	imgName1 = 'images/rect1.jpg';
	imgName2 = 'images/rect2.jpg';
end

%BW
img1 = single(rgb2gray(imread(imgName1)));
img2 = single(rgb2gray(imread(imgName2)));
%Colour
img1C = im2double(imread(imgName1));
img2C = im2double(imread(imgName2));

%extract SIFT features and match
[fa, da] = vl_sift(img1, 'peakthresh', 0.02);
[fb, db] = vl_sift(img2, 'peakthresh', 0.02);
[matches, scores] = vl_ubcmatch(da, db, 2.5);

%motion
showMotion(img1C,fa(1:2, matches(1,:)),fb(1:2, matches(2,:)),38);

%show matches
showFeatureMatches(img1, fa(1:2, matches(1,:)), img2, fb(1:2, matches(2,:)), 20);

% =========================================================================

%run 8-point RANSAC
[inliers1, inliers2, outliers1, outliers2, m, F] = ransac8pF(fa(1:2, matches(1,:)), fb(1:2, matches(2,:)), 8);

%show inliers and outliers
%motion
showMotion(img1C,inliers1,inliers2,39);

%show matches
showInliersOutliers(img1, inliers1, outliers1, img2, inliers2, outliers2, 30);

%show number of iterations needed
m

%show inlier ratio
ratio = size(inliers1,2)/size(fa(1:2, matches(1,:)),2)

%and check the epipolar geometry of the computed F<
%get Fh
[U,S,V] = svd(F);
S(3,3) = 0;
Fh = U*S*V';


%Points to check epipolar geometry
x1s = inliers1;
x1s(3,:) = ones(1,size(x1s,2));
x2s = inliers2;
x2s(3,:) = ones(1,size(x2s,2));

% show clicked points
figure(11),clf, imshow(img1C, []); hold on, plot(x1s(1,:), x1s(2,:), '*r');
figure(12),clf, imshow(img2C, []); hold on, plot(x2s(1,:), x2s(2,:), '*r');

% draw epipolar lines in img 1
figure(11)
for k = 1:size(x1s,2)
    drawEpipolarLines(Fh'*x2s(:,k), img1C);
end
% draw epipolar lines in img 2
figure(12)
for k = 1:size(x2s,2)
    drawEpipolarLines(Fh*x1s(:,k), img2C);
end

% =========================================================================