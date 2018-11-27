% extract descriptor
%
% Input:
%   keyPoints     - detected keypoints in a 2 x n matrix holding the key
%                   point coordinates
%   img           - the gray scale image
%   
% Output:
%   descr         - w x n matrix, stores for each keypoint a
%                   descriptor. w is the size of the image patch,
%                   represented as vector
function descr = extractDescriptor(corners, img)
    pSize = 9;
    shift = (pSize-1)/2;
    imgPadded = padarray(img, [shift shift]); % surround the matrix with 4 layers of zerosp
    [~,n] = size(corners);
    for i = 1:n
        % here we go from - shift to + shift but we have to add shift to
        % avoid the zeros so we go from 0 to 2*shift
        patch = imgPadded(corners(1,i):corners(1,i)+2*shift, corners(2,i):corners(2,i)+2*shift); % select pSize*pSize submatrix arround the corner
        descr(:,i) = patch(:); %stores the values as a vector
    end
end