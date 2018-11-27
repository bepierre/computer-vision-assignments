% Exercise 3
%
close all;

IMG_NAME1 = 'images/I1.jpg';
IMG_NAME2 = 'images/I2.jpg';

% read in image
img1 = im2double(imread(IMG_NAME1));
img2 = im2double(imread(IMG_NAME2));

img1 = imresize(img1, 1);
img2 = imresize(img2, 1);

% convert to gray image
imgBW1 = rgb2gray(img1);
imgBW2 = rgb2gray(img2);

% Task 3.1 - extract Harris corners
 hThresh = 0.0002;
 sigma = 2;
 [corners1, H1] = extractHarrisCorner(imgBW1', hThresh, sigma);
 [corners2, H2] = extractHarrisCorner(imgBW2', hThresh, sigma);

% show images with Harris corners
 showImageWithCorners(img1, corners1, 10);
 showImageWithCorners(img2, corners2, 11);

% Task 3.2 - extract your own descriptors
 descr1 = extractDescriptor(corners1, imgBW1');
 descr2 = extractDescriptor(corners2, imgBW2');

% Task 3.3 - match the descriptors
 mThresh = 0.04;
 matches = matchDescriptors(descr1, descr2, mThresh);

 showFeatureMatches(img1, corners1(:, matches(1,:)), img2, corners2(:, matches(2,:)), 20);
 
 % Task 3.4 - sift features
 img_luc = im2double(imread('images/luc.jpg'));
 sThresh = 0.045;
 siftFeatures(img_luc, sThresh, 30);
 
 % Task 3.5 - sift matching
 smThresh = 0.0385;
 siftMatching(img1, img2, smThresh, 40);