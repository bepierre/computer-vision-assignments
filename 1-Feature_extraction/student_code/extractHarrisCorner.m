% extract harris corner
%
% Input:
%   img           - n x m gray scale image
%   thresh        - scalar value to threshold corner strength
%   
% Output:
%   corners       - 2 x k matrix storing the keypoint coordinates
%   H             - n x m gray scale image storing the corner strength
function [corners, H] = extractHarrisCorner(img, thresh, sigma)
    G = fspecial('gaussian',max(1,fix(6*sigma)), sigma); % gaussian filter for noise reduction
    imgf = imfilter(img,G);
    [Ix,Iy] = gradient(imgf);
    c = [1 1 1; 1 0 1; 1 1 1]; % kernel to get neighbours
    Ix2 = conv2(Ix.^2,c);
    Iy2 = conv2(Iy.^2,c);
    Ixy = conv2(Ix.*Iy,c);
    H = (Ix2.*Iy2-Ixy.^2)./(Ix2+Iy2);
    nSize = 3;
    M = ordfilt2(H, nSize^2, ones(nSize)); % matrix containing maxima for every nSize*nSize neighborhood
    Hc = (H==M)&(H>thresh); % matrix containing 1 for the good pixels and 0 otherwise
    [corners(1,:), corners(2,:)] = find(Hc); % coordinates array
end