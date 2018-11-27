close all
clear all

% parameters
sigma = 5;

% load image
img = imread('cow.jpg');
%img = imread('zebra_b.jpg');
% for faster debugging you might want to decrease the size of your image
% img = imresize(img, 1/3);
% (especially for the mean-shift part!)

figure, imshow(img), title('original image')

% smooth image (6.1a)
% smoothing of the image
G = fspecial('gaussian', 5, sigma); % gaussian filter for noise reduction
imgSmoothed = imfilter(img,G);
figure, imshow(imgSmoothed), title('smoothed image')

% convert to L*a*b* image (6.1b)
% convert the image to lab space
cform = makecform('srgb2lab');
imglab = applycform(imgSmoothed, cform);
figure, imshow(imglab), title('l*a*b* image')

% (6.2)
%[mapMS, peak] = meanshiftSeg(imglab);
%visualizeSegmentationResults(mapMS,peak);

% (6.3)
[mapEM, cluster] = EM(imglab);
visualizeSegmentationResults (mapEM,cluster);