% Normalization of 2d-pts
% Inputs: 
%           x1s = 2d points
% Outputs:
%           nxs = normalized points
%           T = normalization matrix
function [nxs, T] = normalizePoints2d(xy)
    n = size(xy, 2);

    %first compute centroid
    xy_centroid = [mean(xy(1,:));mean(xy(2,:))];
    
    %then, compute scale
    s_2D = mean(sqrt((xy(1,:)-xy_centroid(1)*ones(1,n)).^2+(xy(2,:)-xy_centroid(2)*ones(1,n)).^2))/(sqrt(2));
    
    %create T transformation matrix
    T = [s_2D, 0, xy_centroid(1);
     0, s_2D, xy_centroid(2);
     0, 0, 1]^-1;
 
    %and normalize the points according to the transformation
    nxs = T*xy;
end
